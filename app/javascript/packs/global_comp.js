import Vue from 'vue'

import CompWrapper from './CompWrapper'
document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        components: { CompWrapper }
    }).$mount('.global-comp')
})