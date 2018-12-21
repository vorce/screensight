<template>
  <div id="app" class="siimple-content siimple-content--fluid">
    <div class="siimple-h1">Screensight</div>
    <div class="siimple-grid">
      <div class="siimple-grid-row">
        <main>
        <div class="siimple-grid-col siimple-grid-col--9"><media-share v-bind:channel="channels.media" v-bind:username="username"></media-share></div>
        <div class="siimple-grid-col siimple-grid-col--3"><chat v-bind:channel="channels.chat" v-bind:username="username"></chat></div>
        </main>
      </div>
    </div>
    <div class="siimple-footer siimple-footer--light siimple-footer--fluid" align="center">
      <div class="siimple-footer-subtitle">Screensight</div> <a href="#" class="siimple-footer-link siimple-footer-link--inline">Github</a> <a href="#" class="siimple-footer-link siimple-footer-link--inline">Contact</a>
    </div>
  </div>
</template>
<script>
  import Chat from './components/Chat'
  import MediaShare from './components/MediaShare'
  import {Socket} from "phoenix"

  export default {
    name: 'app',
    components: {
      Chat,
      MediaShare
    },
    created: function () {
      let socket = new Socket("/socket", {params: {token: window.userToken, user_id: this.username}})
      socket.connect();
      this.channels.chat = socket.channel("room:example-room", {});
      this.channels.media = socket.channel("room:example-room-media", {})
    },
    data() {
      return {
        username: window.location.search.split("=")[1] || generateUUID(),
        channels: {
          chat: null,
          media: null
        }
      }
    }
  }
</script>
