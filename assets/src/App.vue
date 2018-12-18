<template>
  <div id="app">
    <header>
      <h1>Screensight</h1>
    </header>
    <main>
      <chat></chat>
    </main>
  </div>
</template>
<script>
  import Chat from './components/Chat'
  export default {
    name: 'app',
    components: {
      Chat
    }
  }
</script>
<style>
  main {
    margin-top: 60px;
  }
</style>
