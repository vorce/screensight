<template>
  <div id="screenshare" class="siimple-content siimple-content--fluid">
    <div class="siimple-grid">
      <div class="siimple-grid-row">
          <h3>Screenshare</h3>
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
  import {Channel} from "phoenix"

  export default {
    name: 'media-share',
    props: {
      channel: Channel,
      username: String
    },
    mounted() {
      this.channel.join()
        .receive("ok", resp => { console.log("Joined media channel successfully", resp) })
        .receive("error", resp => { console.log("Unable to join media channel", resp) })
      this.channel.on('new:video:chunk', payload => {
        console.log("from video", payload)
        this.mediaChunks.video.push(payload)
      });
    },
    data() {
      return {
        screenShareOn: false,
        micShareOn: false,
        mediaChunks: {
          video: [],
          audio: []
        }
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
      },

      startScreenCapture: function () {
        if (navigator.getDisplayMedia) {
          return navigator.getDisplayMedia({video: true});
        } else {
          return navigator.mediaDevices.getUserMedia({video: {mediaSource: 'screen'}});
        }
      },

      startCapturing: function (e) {
        this.screenShareOn = true;
        // this.stream = await ScreenSharing._startScreenCapture();
        // this.stream.addEventListener('inactive', e => {
        //   console.log('Capture stream inactive - stop recording!');
        //   this._stopCapturing(e);
        // });
        // this.mediaRecorder = new MediaRecorder(this.stream, {mimeType: 'video/webm'});
        // this.mediaRecorder.addEventListener('dataavailable', event => {
        //   if (event.data && event.data.size > 0) {
        //     this.chunks.push(event.data);
        //   }
        // });
        // this.mediaRecorder.start(10);
      }
    }
  }
</script>