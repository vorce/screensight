<template>
  <div class="hello">
    <h3>Hello from Vue.js!</h3>
    <p>{{msg}}</p>
  </div>
</template>
<script>
  export default {
    name: 'hello',
    data() {
      return {
        msg: 'Simple example using Phoenix, Vue and Webpack.'
      }
    }
  }
</script>
<style scoped>
    p {
        margin-top: 40px;
    }
</style>
