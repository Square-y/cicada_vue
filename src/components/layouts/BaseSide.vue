<template>
  <!-- <div style="background-color:floralwhite;width: 199px; height: 56px;display: flex;align-items: center;">
    <i style="width: 33%;">
      <img   style="width: 30px;height: 30px;" src="../../assets/logo-1.png">
    </i>
        <span style="line-height: 100%;width: 40%;">CICADA</span>
        <el-icon @click="statusChange" style="width: 27%">
          <Fold />
        </el-icon>
  </div> -->

  <!-- <el-radio-group v-model="isCollapse" style="margin-bottom: 20px">
    <el-radio-button :label="false">expand</el-radio-button>
    <el-radio-button :label="true">collapse</el-radio-button>
  </el-radio-group> -->
  <!-- <el-menu default-active="$router.path" class="el-menu-vertical-demo" :collapse="isCollapse" :collapse-transition="false"
    @open="handleOpen" @close="handleClose">
    <el-sub-menu index="1">
      <template #title >
        <el-icon>
          <location />
        </el-icon>
        <span>Navigator One</span>
      </template>
      <el-menu-item index="1-1">item one</el-menu-item>
      <el-menu-item index="1-2">item two</el-menu-item>
      <el-menu-item index="1-3">item three</el-menu-item>
      <el-sub-menu index="1-4">
        <template #title><span>item four</span></template>
        <el-menu-item index="1-4-1">item one</el-menu-item>
      </el-sub-menu>
    </el-sub-menu>
    
    <el-menu-item index="2">
      <el-icon><icon-menu /></el-icon>
      <template #title>Navigator Two</template>
      <el-menu-item index="1-1">item one</el-menu-item>
    </el-menu-item>
    <el-menu-item index="3" disabled>
      <el-icon>
        <document />
      </el-icon>
      <template #title>Navigator Three</template>
    </el-menu-item>
    <el-menu-item index="4">
      <el-icon>
        <setting />
      </el-icon>
      <template #title>Navigator Four</template>
    </el-menu-item>
  </el-menu> -->

  <!--左侧 开始-->
  <!-- <transition name="left"> -->
    <el-aside  class="left" :width="isCollapse ?'64px':'150px'">
      <!--左侧主菜单 开始-->
      <el-menu default-active="$router.path" class="el-menu-vertical" :collapse="isCollapse" @open="handleOpen" :collapse-transition="false"
        @close="handleClose">

        <el-sub-menu  v-for="item, index in menuList" :key="index" :index="item.menuId">
          <template #title>
            <!-- 动态加载icon -->
            <el-icon>
              <component :is="item.icon"></component>
            </el-icon>

            <span>{{ item.title }}</span>
          </template>
          <!-- <el-menu-item-group> -->
          <el-menu-item v-for="(subItem, subIndex) in item.sub" :key="subIndex" :index="subItem.menuId" @click="openTab(subItem)">
            {{ subItem.title }}
          </el-menu-item>
          <!-- </el-menu-item-group> -->
        </el-sub-menu>
      </el-menu>
      <!--左侧主菜单 结束-->
    </el-aside>
  <!-- </transition> -->
  <!--左侧 结束-->
  <!--左侧 隐藏菜单按钮 开始-->
  <!-- <transition name="hideMenu">
    <div class="hideMenuButton" v-if="showMenu" @click="showHideMenu(false)">
      <el-icon>
        <ArrowLeft />
      </el-icon>
    </div>
  </transition> -->
  <!--左侧 隐藏菜单按钮 结束-->

  <!--左侧 显示菜单按钮 开始-->
  <!-- <transition name="showMenu">
    <div class="showMenuButton" v-if="!showMenu" @click="showHideMenu(true)">
      <el-icon>
        <ArrowRight />
      </el-icon>
    </div>
  </transition> -->
  <!--左侧 显示菜单按钮 结束-->
</template>

<script lang="ts" setup>
import config from "./BaseSide"
import { ref } from 'vue'
import {
  Document,
  Menu as IconMenu,
  Location,
  Setting,
} from '@element-plus/icons-vue'
import { useMenuInfo } from '../../stores/menuInfo'
import emitter from "../../utils/eventbus" //menu也要引用刚刚新建的utils文件
import { it } from "node:test";
import { useTabStore } from '../../stores/editableTabs'
import tab  from "./Tabs.vue"
import axios from "axios"
import { useRouter } from 'vue-router';
import menu from "~/lang/backend/en/auth/menu"

let TabStore= useTabStore()
const editableTabs =TabStore.GetOpenedTabs




// 接收侧边栏的 收缩状态
let isCollapse = ref(false)
emitter.on("sayInfo", (info: any) => {
  console.log("--->", info)
  TabStore.GetOpenedTabs
  isCollapse.value = info
})

// 打开 页签 传出 页签数据
const openTab = (item: any) => {
  console.log("-->",item)
  emitter.emit("opTab",item)	
  }

const router = useRouter();
const menuInfo = useMenuInfo()

const getMenuList = () => {
  const header = {'headers':{'Authorization': sessionStorage.getItem("token")}}
  if (sessionStorage.getItem("userId") && sessionStorage.getItem("token"))  {
    axios.get("/api/menu?userId=" + sessionStorage.getItem("userId"), header)
            .then(function(data){
              if (data.data.retCode == "000"){
                console.log("<<>>", sessionStorage.getItem("userId"),sessionStorage.getItem("token"))
                console.log("menulogined:", data.data.result)
                // menuList.value =  data.data.result
                menuInfo.setMenuInfo(data.data.result)
                
                menuList.value = menuInfo.getMenuInfo()
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
                console.log("menu_unlogined", data.data.result)
                // menuList.value =  data.data.result
                menuInfo.setMenuInfo(data.data.result)
                menuList.value =  menuInfo.getMenuInfo()
                // console.log(">>><<<:",menuInfo.getMenuInfo())
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

// 未使用 pinia
const menuList = ref([])
emitter.on("menu_list", (info: any) => {
  // console.log("--->", info)
  // menuList.value = info
  getMenuList()
  // console.log("+++", menuList.value)
})



getMenuList()


// console.log('getMenuList:', getMenuList())



console.log("menuList",menuList.value)
// console.log("config",config.menu)


let showMenu = true
// let isCollapseStatus = useCollapse()
// let fullScreen = false
console.log(status)
const showHideMenu = (status: boolean) => {
  console.log("========")
  console.log(isCollapse.value)
  isCollapse.value = !isCollapse.value 
  console.log(isCollapse.value)
}
// // 全屏
// const enterFullScreen = () => {
//   let element = this.$refs['right']
//   var requestMethod = element.requestFullScreen ||
//     element.webkitRequestFullScreen ||
//     element.mozRequestFullScreen ||
//     element.msRequestFullScreen;
//   // document.body.width = 1920
//   // document.body.height = 1080
//   requestMethod.call(document.body);
//   fullScreen = true
// }
// // 退出全屏
// const exitFullScreen = () => {
//   fullScreen = false
//   var exitMethod = document.exitFullscreen ||
//     document.mozCancelFullScreen ||
//     document.webkitExitFullscreen ||
//     document.msExitFullScreen;
//   exitMethod.call(document);
// }
// // 监听 ESC 按键
// const listenKeyBoardEvent = () => {
//   let that = this
//   // 监听 ESC 按键
//   window.onresize = function () {
//     let isFull = document.fullscreenEnabled || window.fullScreen || document.webkitIsFullScreen || document.msFullscreenEnabled || false
//     !isFull && exitFullScreen()
//   }
// }




// console.log("--", useCollapse().isCollapse)
// useCollapse().changeCollapse()
// console.log("++", useCollapse().isCollapse)

// console.log("==", isCollapse)


// let statusChange = () => {
//   console.log(isCollapseStatus.isCollapse)
//   console.log("=======")
//   isCollapseStatus.changeCollapse()
//   console.log(isCollapseStatus.isCollapse)
//   isCollapse = ref(isCollapseStatus.isCollapse)
// }

// const isCollapse = ref(isCollapseStatus.isCollapse)
const handleOpen = (key: string, keyPath: string[]) => {
  console.log(key, keyPath)
}

const handleClose = (key: string, keyPath: string[]) => {
  console.log(key, keyPath)
}

// export default {
//   created (){
//     axios.Axios
//   }
// }

// emitter.on("sayInfo", (info: any) => {
//   isCollapse.value = info
// })

// const statusChange = () => {
//   console.log("------")
//   console.log(isCollapse.value)

//   isCollapse.value = !isCollapse.value
//   console.log("=====")
//   console.log(isCollapse.value)
// }

defineExpose({
  menuList,
});

</script>

<style>
.el-menu-vertical-demo:not(.el-menu--collapse) {
  width: 150px;
  min-height: 400px;
}

/* 去掉 el-menu 的边厚度 */
.ep-menu {
  border-right: none;
}

/* .el-menu-vertical .ep-sub-menu__title {
  width: 64px
} */

/*主菜单 侧边栏样式 */
.left {
  /* width: 65px; */
  /* height: 100%; */
  display: block;
  /*background: #fff;*/
  /* background: #071526; */
  border-right: 1px solid #414243;
  overflow-y: scroll;
  overflow-x: hidden;
  padding: 0;
  margin: 0;
  position: relative;
  box-sizing: border-box;
  flex-shrink: 0;

  -ms-overflow-style: none;

  /*-ms-scroll-chaining: chained;*/
  /*-ms-overflow-style: none;*/
  /*-ms-content-zooming: zoom;*/
  /*-ms-scroll-rails: none;*/
  /*-ms-content-zoom-limit-min: 100%;*/
  /*-ms-content-zoom-limit-max: 500%;*/
  /*-ms-scroll-snap-type: proximity;*/
  /*-ms-scroll-snap-points-x: snapList(100%, 200%, 300%, 400%, 500%);*/
  /*overflow: auto;*/
}

.left::-webkit-scrollbar {
  display: none;
}

/*菜单显示/隐藏 动画*/
.left-enter-active,
.left-leave-active {
  transition: width .5s;
}

.left-enter,
.left-leave-to {
  width: 0px;
}



/*隐藏菜单 按钮*/
.hideMenuButton {
  width: 12px;
  height: 50px;
  position: fixed;
  top: 50%;
  left: 187px;
  transform: translate(0, -50%);

  background: #030A13;
  border-radius: 10px 0 0 10px;
  display: flex;
  justify-content: flex-start;
  align-items: center;
  color: #fff;
  z-index: 99;
}

/*显示菜单 按钮*/
.showMenuButton {
  width: 12px;
  height: 50px;
  position: fixed;
  top: 50%;
  left: 0;
  transform: translate(0, -50%);

  background: #030A13;
  border-radius: 0px 10px 10px 0px;
  display: flex;
  justify-content: flex-end;
  align-items: center;
  color: #fff;
  z-index: 99;
}

/*显示/隐藏 按鈕 动画*/
.hideMenu-enter-active,
.hideMenu-leave-active {
  transition: all .5s;
}

.hideMenu-enter,
.hideMenu-leave-to {
  left: -12px;
}

/*显示/隐藏 按鈕 动画*/
.showMenu-enter-active,
.showMenu-leave-active {
  transition: all .5s;
}

.showMenu-enter,
.showMenu-leave-to {
  opacity: 0;
}
</style>
