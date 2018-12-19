<template>
  <div id="screenshare" class="siimple-content siimple-content--fluid">
    <div class="siimple-grid">
      <div class="siimple-grid-row">
        <div class="siimple-grid-col siimple-grid-col--12">
          <h3>Screenshare</h3>
        </div>
      </div>
      <div class="siimple-grid-row">
        <div class="siimple-card">
            <div class="siimple-card-header">
                Username
            </div>
            <div class="siimple-card-body">
                IMG HERE
            </div>
            <div class="siimple-card-footer">
                Card footer
            </div>
        </div>
      </div>
      <div class="siimple-grid-row">
        <div @click="toggleShareScreen" class="siimple-btn siimple-btn--blue">🎥</div> <div @click="toggleShareMicrophone" class="siimple-btn siimple-btn--blue">🎙</div>
      </div>
    </div>
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