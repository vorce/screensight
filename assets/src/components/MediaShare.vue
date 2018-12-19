<template>
  <div class="screenshare">
    <h3>Screenshare</h3>
    <div @click="toggleShareScreen" class="siimple-btn siimple-btn--blue">🎥</div> <div @click="toggleShareMicrophone" class="siimple-btn siimple-btn--blue">🎙</div>
  </div>
</template>
<script>
  import {Socket} from "phoenix"

  export default {
    name: 'media-share',
    data() {
      return {
        screenShareOn: false,
        micShareOn: false,
      }
    },
    methods: {
      toggleShareScreen: function () {
        if(this.screenShareOn) {
          console.log("Stop screen share")
        } else {
          console.log("Start screen share")
        }
        this.screenShareOn = !this.screenShareOn
      },

      toggleShareMicrophone: function () {
        if(this.micShareOn) {
          console.log("Stop mic share")
        } else {
          console.log("Start mic share")
        }
        this.micShareOn = !this.micShareOn
      }
    }
  }
</script>