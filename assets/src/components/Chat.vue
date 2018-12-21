<template>
  <div id="chat" class="siimple-content siimple-content--fluid">
    <div class="siimple-grid">
      <div class="siimple-grid-row">
        <h3>Chat</h3>
      </div>
  
      <div class="siimple-grid-row">
        <div id="presence" class="siimple-card">
          <div class="siimple-card-header">
            Users ({{ onlineUsers.length }})
          </div>
          <div class="siimple-card-body">
            <span v-for="user of onlineUsers" class="siimple-tag siimple-tag--light siimple--mr-1">
              {{ user.name.substring(0, 20) }} ({{ user.count }})
            </span>
          </div>
        </div>
      </div>
      <div class="siimple-grid-row">
        <div id="messages" class="siimple-list">
          <div v-for="message of messages" class="siimple-list-item">
            <div class="siimple-list-title">{{ message.user.substring(0, 20) }}</div>
            <span> {{ message.body}} </span>
          </div>
        </div>
      </div>
      <div class="siimple-grid-row">
        <div class="siimple-rule"></div>
        <input v-model="form.message" type="text" class="siimple-input siimple-input--fluid" placeholder="" v-on:keyup.enter="sendMessage">
      </div>
    </div>
  </div>
</template>
<script>
  import {Channel, Presence} from "phoenix"

  export default {
    name: 'chat',
    props: {
      channel: Channel,
      username: String
    },
    mounted() {
      let presence = new Presence(this.channel)
      presence.onSync(() => this.updateOnlineUsers(presence))
      this.channel.join()
        .receive("ok", resp => { console.log("Joined chat successfully", resp) })
        .receive("error", resp => { console.log("Unable to join chat", resp) })
      this.channel.on('new:chat:message', payload => {
        console.log("from chat", payload)
        this.messages.push(payload)
      });
    },
    data() {
      return {
        form: {
          message: '',
        },
        onlineUsers: [],
        messages: []
      }
    },
    methods: {
      sendMessage: function () {
        if(this.form.message == '') {
          return;
        }

        let payload = {
          body: this.form.message,
          user: this.username
        }

        console.log("Sending to room", payload)
        this.channel.push("new:chat:message", payload)
        this.form.message = ''
      },
      updateOnlineUsers: function(presence) {
        let newOnlineUsers = []
        console.log("Updating online users...")
        presence.list((id, {metas: [first, ...rest]}) => {
          let count = rest.length + 1
          newOnlineUsers.push({name: id, count: count})
        })
        console.log("New onlineUsers", newOnlineUsers)
        this.onlineUsers = newOnlineUsers;
      }
    }
  }
</script>
<style scoped>
    p {
        margin-top: 40px;
    }
</style>
