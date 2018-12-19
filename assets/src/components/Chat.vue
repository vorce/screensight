<template>
  <div class="chat">
    <h3>Chat</h3>
    <!-- <div id="chat-messages" class="siimple-alert siimple-alert--info"> -->
    <div class="siimple-list" style="max-width:800px;">
      <div v-for="message of messages" class="siimple-list-item" style="max-width:800px;">
        <div class="siimple-list-title">{{ message.user }}</div>
        <span> {{ message.body}} </span>
      </div>
    </div>
    <input v-model="form.message" type="text" class="siimple-input" placeholder="..." v-on:keyup.enter="sendMessage"> <div @click="sendMessage" class="siimple-btn siimple-btn--blue">Send</div>
  </div>
</template>
<script>
  import {Socket} from "phoenix"

  function generateUUID() {
    var d = new Date().getTime();
    var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        var r = (d + Math.random()*16)%16 | 0;
        d = Math.floor(d/16);
        return (c=='x' ? r : (r&0x3|0x8)).toString(16);
    });
    return uuid;
  }

  export default {
    name: 'chat',
    mounted() {
      let socket = new Socket("/socket", {params: {token: window.userToken}})
      socket.connect();
      this.channel = socket.channel("room:example-room", {});
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
        user: window.location.search.split("=")[1] || generateUUID(),
        messages: []
      }
    },
    methods: {
      sendMessage: function () {
        let payload = {
          body: this.form.message,
          user: this.user
        }

        console.log("Sending to room", payload)
        this.channel.push("new:chat:message", payload)
        this.form.message = ''
      }
    }
  }
</script>
<style scoped>
    p {
        margin-top: 40px;
    }
</style>
