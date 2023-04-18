import { createApp } from "vue";
import App from "./Register.vue";

// import "~/styles/element/index.scss";

// import ElementPlus from "element-plus";
// import all element css, uncommented next line
// import "element-plus/dist/index.css";

// or use cdn, uncomment cdn link in `index.html`

import "~/styles/index.scss";
import 'uno.css'
// import rout
// If you want to use ElMessage, import it.
import "element-plus/theme-chalk/src/message.scss"
// import router from "./Router/TabRoute"

import {createPinia} from "pinia";
// import { useCollapse } from './stores/collapse'
import * as ElementPlusIconsVue from '@element-plus/icons-vue'

import axios from 'axios'
import VueAxios from 'vue-axios'




// import mitt from "mitt";
// const emitter = mitt();
// export default emitter;
const pinia = createPinia()
const app = createApp(App);
// app.use(ElementPlus);


app.use(pinia)
// app.use(router)
app.use(VueAxios,axios)
// app.use(emitter)
// const isCollapseGlobal = useCollapse()
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
    app.component(key, component)
  }
app.mount("#app");
