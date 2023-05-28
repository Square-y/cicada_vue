// 组件注册  全局组件注册 注册之后任何 Vue实例都能用


import home from "../components/HelloWorld.vue"
import index from '../views/index.vue'
import hello1 from '../views/hello1.vue'
import hello2 from '../views/hello2.vue'
import hello3 from '../views/hello3.vue'
import user_manage from  '../views/user_mgmt/user_manage/userManage.vue'
import auth_manage from  '../views/user_mgmt/auth_manage/authManage.vue'
import role_manage from  '../views/user_mgmt/role_manage/roleManage.vue'

const route = Object.create(null)
route.install = function (vue:any) {
  // 第一个字符串是 组件名，第二个是组件名

	vue.component('home', home)
	vue.component('index', index)
	vue.component('hello1', hello1)
	vue.component('hello2', hello2)
	vue.component('hello3', hello3)
	// 用户管理组件
	vue.component('user_manage', user_manage)
	vue.component('role_manage', role_manage)
	vue.component('auth_manage', auth_manage)
}


export default route