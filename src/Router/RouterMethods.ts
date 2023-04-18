import { createRouter, createWebHistory, RouteRecordRaw } from "vue-router";
import HelloWorldVue from "~/components/HelloWorld.vue"
const index = () => import("../views/index.vue")
const hello1 = () => import ("../views/hello1.vue")
const hello2 = () => import ("../views/hello2.vue")
const hello3 = () => import ("../views/hello3.vue")
const home = () => import ("../views/home.vue")
const Tab = () => import ("~/components/layouts/tabs.vue")
const Login = () => import ("~/login/Login.vue")


const routes = [
  {
    path: '/login',
    component: Login
  },
  {
    path: '/home',
    component: home
  },
  {
    path: '/index',
    component: index
  },
  {
    path: '/hello1',
    component: hello1
  },
  {
    path: '/hello2',
    component: hello2
  },
  {
    path: '/hello3',
    component: hello3
  },
]

const router = createRouter({
  // 4. 内部提供了 history 模式的实现。为了简单起见，我们在这里使用 hash 模式。
  history: createWebHistory(),
  routes, // `routes: routes` 的缩写
})



export default router




