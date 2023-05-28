<script lang="ts" setup>
import { useRouter } from 'vue-router';
import { toggleDark } from '~/composables';
import emitter from "../../utils/eventbus" //引用刚刚新建的utils文件
import { ref } from 'vue'
import axios from 'axios';
import { UserFilled } from '@element-plus/icons-vue'
import { reactive, toRefs } from 'vue'
import { useMenuInfo } from '../../stores/menuInfo'


// import auto from "./BaseHeader"



const getUserInfo = () => {
        console.log("===>>>", sessionStorage.getItem("userId"), sessionStorage.getItem("token"))
        const header = {'headers':{'Authorization': sessionStorage.getItem("token")}}
        if (sessionStorage.getItem("userId") && sessionStorage.getItem("token")) {
          axios.get("/api/users?userId=" + sessionStorage.getItem("userId"), header)
          .then(
            function(data) {
                if (data.data.retCode == "000"){
                    console.log("data.data>>>", data.data)
                    username.value = data.data.result[0].userName
                    isVisible.value = false

                  } else {
                    console.log("bbbb",data.data)
                    // 用户未登录
                    isVisible.value = true
                  }
              }).catch(
                function(error) {
                  console.log("ddd", error)
                  isVisible.value = true
                }
          )
          } else {
            console.log("aaaaa")
            isVisible.value = true
          }

    
    }

// 显示 或者 隐藏 指定的标签
const isVisible = ref(true)
const username = ref('')

getUserInfo()

console.log("--->>>", username.value)
console.log('===>>>', isVisible.value)





const state = reactive({
  circleUrl:
    'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png',
  squareUrl:
    'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png',
  sizeList: ['small', '', 'large'] as const,
})

const { circleUrl, squareUrl, sizeList } = toRefs(state)

const router = useRouter();

const menuL = ref<boolean>(false)	// 建立一个menuL
let head_icon = ref("Fold")
const statusChange = () => {	// head里面的图标点击按钮
  menuL.value = !menuL.value	//首先把menuL取反
  menuL.value ? head_icon.value = 'Expand' : head_icon.value = 'Fold'	//这里是改变按钮上面的图标式样
  // head_icon.value = 'Expand'
  // console.log("==-->",head_icon.value)
  emitter.emit("sayInfo",menuL.value)	//通过mitt的emit把menuL传递出去，sayInfo传参名称
}


const isDialogVisible = ref(false)
// 登录
const login = () => {
  console.log("login");
  router.push({path:"/login"});
  // isDialogVisible.value = true
  // console.log(isDialogVisible.value)
}

// 注册
const register = () => {
  console.log("register");
  router.push({path:"/register"});
}




const getMenuList = () => {
  const header = {'headers':{'Authorization': sessionStorage.getItem("token")}}
  if (sessionStorage.getItem("userId") && sessionStorage.getItem("token"))  {
    axios.get("/api/menu?userId=" + sessionStorage.getItem("userId"), header)
            .then(function(data){
              if (data.data.retCode == "000"){
                // console.log("<<>>", sessionStorage.getItem("userId"),sessionStorage.getItem("token"))
                console.log("menulogined:", data.data.result)
                // menuList.value =  data.data.result
                menuInfo.setMenuInfo(data.data.result)
                // menuList.value = menuInfo.getMenuInfo()
                console.log(">>><<<--",menuInfo.getMenuInfo())
                // menuList.value = menuInfo.getMenuInfo()
                return data.data.result
              } else {
                // 登录失败，报出登录失败提示信息
                console.log("error",data.data.retMsg)
                // ElMessage.error(data.data.retMsg)
              }
            }).catch(function(error){
              // 向后端请求失败， 弹出异常信息
              console.log("error",error)
              // ElMessage.error(error)
              })
  } else {
    axios.get("/api/menu")
            .then(function(data){
              if (data.data.retCode == "000"){
                // console.log("menu_unlogined", data.data.result)
                // menuList.value =  data.data.result
                menuInfo.setMenuInfo(data.data.result)
                // menuList.value =  menuInfo.getMenuInfo()
                console.log(">>>+++",menuInfo.getMenuInfo())
                return data.data.result
              } else {
                // 登录失败，报出登录失败提示信息
                console.log(data.data.retMsg)
                // ElMessage.error(data.data.retMsg)
              }

            }).catch(function(error){
              // 向后端请求失败， 弹出异常信息
              console.log(error)
              // ElMessage.error(error)
              })
  }
  
}

const menuInfo = useMenuInfo()

const clearToken = () => {
  sessionStorage.clear();
  username.value = ''
  isVisible.value = true
  getMenuList()
  emitter.emit("menu_list",menuInfo.getMenuInfo())
  // menuInfo.setMenuInfo
}











// import { useCollapse } from '../../stores/collapse'
// const isCollapse = useCollapse()
// counter.count++
// with autocompletion ✨
// counter.$patch({ count: counter.count + 1 })
// or using an action instead
// let statusChange = () => {
//   console.log(isCollapse.isCollapse)
//   console.log("=======")
//   isCollapse.changeCollapse()
//   console.log(isCollapse.isCollapse)
// }

const dialogModifyPasswordVisible =ref(false)

const handleModifyPassword = () => {
  dialogModifyPasswordVisible.value = true
}


const formLabelWidth = "205px"
const formModifyPassword = reactive({
  passwordOld:"",
  passwordNew:"",
  confirmPassword:""
})

const dialogModifyPasswordRequest = () => {
  console.log("修改密码>>>",formModifyPassword)
  dialogModifyPasswordVisible.value = false
}

</script>

<template>
  <el-menu class="el-menu-demo" mode="horizontal" style="align-items:center">
    <div index="0" @click="statusChange" style="align-items:center;margin-left: 20px;width:30px">
      <img   style="width: 30px;height: 30px;" src="../../assets/logo-1.png">
    </div>
    <el-menu-item index="1">CICADA Plus</el-menu-item>
    
    <div index="2"  @click="statusChange">
      <el-icon  style="height: var(--ep-menu-item-height);">
        <!-- <Fold /> -->
        <component style="cursor: pointer" :is="head_icon"></component>
      </el-icon>
      <!-- <el-icon>III</el-icon> -->
    </div>
    <el-sub-menu index="3">
      <template #title>Workspace</template>
      <el-menu-item index="3-1">item one</el-menu-item>
      <el-menu-item index="3-2">item two</el-menu-item>
      <el-menu-item index="3-3">item three</el-menu-item>
      <el-sub-menu index="3-4">
        <template #title>item four</template>
        <el-menu-item index="3-4-1">item one</el-menu-item>
        <el-menu-item index="3-4-2">item two</el-menu-item>
        <el-menu-item index="3-4-3">item three</el-menu-item>
      </el-sub-menu>
    </el-sub-menu>
    <el-menu-item index="4" disabled>Info</el-menu-item>
    <el-menu-item index="5">Orders</el-menu-item>
    <el-menu-item h="full" @click="toggleDark()">
      <button class="border-none w-full bg-transparent cursor-pointer" style="height: var(--ep-menu-item-height);">
        <i inline-flex i="dark:ep-moon ep-sunny" />
      </button>
    </el-menu-item>
    <!-- <el-menu-item index="6" style="margin-right: 10px;">
      
    </el-menu-item> -->
    <!-- 注册登录 -->

    <el-button v-show="isVisible" style="margin-left: 580px;width: 50px;" @click="login()">登录</el-button>

    <!-- <dialog v-show="isDialogVisible">
        jdjjjjjjjjjjjjjj
        <Login/>
    </dialog> -->

    <el-button v-show="isVisible" style="width: 50px;" @click="register()">注册</el-button>
    <!-- 用户 -->
    <el-dropdown v-show="!isVisible"  style="margin-left: auto;"  trigger="click">
    <span class="el-dropdown-link" >
      {{ username }}
      <el-icon class="el-icon--right"><caret-bottom /></el-icon>
    </span>
    <template #dropdown>
      <el-dropdown-menu>
        <!-- <el-dropdown-item class="clearfix">
          comments
          <el-badge class="mark" :value="12" />
        </el-dropdown-item> -->
        <el-dropdown-item class="changePassword" @click="handleModifyPassword()">
          <el-icon><Setting /></el-icon>
          修改密码
          <el-badge class="mark" />
        </el-dropdown-item>
        <el-dropdown-item class="clearfix" @click="clearToken">
          <el-icon><SwitchButton /></el-icon>
          退出登录
          <el-badge class="mark" />
        </el-dropdown-item>
      </el-dropdown-menu>
    </template>
  </el-dropdown>


    <!-- <el-avatar v-show="!isVisible"  style="margin-left: 750px;" size="small" :src="circleUrl" />
    <div v-show="!isVisible" style="margin-left: 650px;" > {{ username }}</div> -->
    <!-- <el-icon style="margin-left: 750px;"><Avatar /></el-icon> -->
  </el-menu>

  <el-dialog v-model="dialogModifyPasswordVisible" title="修改密码">
    <el-form  style="text-align: center;margin:" :model="formModifyPassword">
      <el-form-item  label="旧密码" :label-width="formLabelWidth">
        <el-input style="width: 50%;" v-model="formModifyPassword.passwordOld" autocomplete="off" />
      </el-form-item>
      <el-form-item  label="新密码" :label-width="formLabelWidth">
        <el-input style="width: 50%;" v-model="formModifyPassword.passwordNew" autocomplete="off" />
      </el-form-item>
      <el-form-item  label="确认密码" :label-width="formLabelWidth">
        <el-input style="width: 50%;" v-model="formModifyPassword.confirmPassword" autocomplete="off" />
      </el-form-item>
      <!-- <el-form-item  label="密码" :label-width="formLabelWidth">
        <el-input style="width: 50%;" v-model="form.name" autocomplete="off" />
      </el-form-item> -->
      <!-- <el-form-item label="角色" :label-width="formLabelWidth">
        <el-select v-model="form.region" placeholder="请选择角色">
          <el-option label="用户" value="user" />
          <el-option label="管理员" value="admin" />
        </el-select>
      </el-form-item> -->
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="dialogModifyPasswordVisible = false">取消</el-button>
        <el-button type="primary" @click="dialogModifyPasswordRequest()">
          确认
        </el-button>
      </span>
    </template>
  </el-dialog>
</template>


<style>
.dialog {
  position: fixed;
  left: 0;
  top: 0;
  bottom: 0;
  right: 0;
  /* 其他样式 */
}
</style>
