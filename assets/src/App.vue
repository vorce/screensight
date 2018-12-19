<template>

  <div id="app" class="siimple-content siimple-content--fluid">
    <div class="siimple-grid">
      <div class="siimple-grid-row">
          <div class="siimple-grid-col siimple-grid-col--12">
            <header>
              <h1>Screensight</h1>
            </header>
          </div>
      </div>

      <div class="siimple-grid-row">
        <main>
        <div class="siimple-grid-col siimple-grid-col--9"><media-share></media-share></div>
        <div class="siimple-grid-col siimple-grid-col--3"><chat></chat></div>
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

  export default {
    name: 'app',
    components: {
      Chat,
      MediaShare
    }
  }
</script>
<style>
</style>
