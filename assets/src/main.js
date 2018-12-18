import Vue from 'vue'
import App from './app'

Vue.config.productionTip = false
const element = document.getElementById('app')
const app = new Vue(App).$mount(element)
