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
              <video width="100%" height="100%" id="screenshare-video" autoplay playsinline :srcObject="stream"></video>
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
        console.log("got video chunk...")
        // this.mediaChunks.video.push(payload.videoChunk)
        // this.recording = window.URL.createObjectURL(new Blob([payload.videoChunk], {type: 'video/webm'}));
      });
    },
    data() {
      return {
        screenShareOn: false,
        micShareOn: false,
        mediaChunks: {
          video: [],
          audio: []
        },
        mediaRecorder: null,
        recording: null,
        stream: new MediaStream()
      }
    },
    methods: {
      toggleShareScreen: function () {
        if(this.screenShareOn) {
          console.log("Stop screen share")
          this.screenShareOn = false
          this.stopScreenCapture()
        } else {
          console.log("Start screen share")
          return this.startScreenCapture()
        }
      },

      toggleShareMicrophone: function () {
        if(this.micShareOn) {
          console.log("Stop mic share")
        } else {
          console.log("Start mic share")
        }
        this.micShareOn = !this.micShareOn
      },

      mediaDataAvailable: function (event) {
        if (event.data && event.data.size > 0) {
          // console.log("mediaDataAvailable")
          // this.channel.push('new:video:chunk', {videoChunk: event.data, user: this.username});
        }
      },

      captureSuccess: function(stream) {
        console.log("Sucessfully got user media device, starting media recorder")
        this.screenShareOn = true
        this.stream = stream
        document.getElementById('screenshare-video').srcObject = stream
        let options = {mimeType: 'video/webm'}
        this.mediaRecorder = new MediaRecorder(stream);
        this.mediaRecorder.ondataavailable = this.mediaDataAvailable
        this.mediaRecorder.start(10);
      },

      startScreenCapture: function () {
        let onError = function(err) {
          console.log('The following error occured: ' + err);
        }
        let constraints = {video: {mediaSource: 'screen'}} // {video: true}
        navigator.mediaDevices.getUserMedia(constraints).then(this.captureSuccess, onError);
      },

      stopScreenCapture: function () {
        if(this.mediaRecorder && this.mediaRecorder.state == 'recording') {
          this.mediaRecorder.stop();
          this.mediaRecorder = null;
        }

        if(this.stream) {
          this.stream.getTracks().forEach(track => track.stop());
          this.stream = null;
        }
      }
    }
  }
</script>
