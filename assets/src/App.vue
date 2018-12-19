<template>
  <div id="app">
    <header>
      <h1>Screensight</h1>
    </header>
    <main>
      <media-share></media-share>
      <chat></chat>
    </main>
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
  main {
    margin-top: 60px;
  }
</style>
