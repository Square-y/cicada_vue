<script lang="ts" setup>
import { useRouter } from 'vue-router';
import { toggleDark } from '~/composables';
import emitter from "../../utils/eventbus" //引用刚刚新建的utils文件
import { ref } from 'vue'

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
// 登录
const login = () => {
  console.log("login");
  router.push({path:"/login"});
}

// 注册
const register = () => {
  console.log("register");
  router.push({path:"/register"});
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
        <component :is="head_icon"></component>
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
    <el-button style="margin-left: 580px;width: 50px;" @click="login()">登录</el-button>
    <el-button style="width: 50px;" @click="register()">注册</el-button>
    <!-- <el-icon style="margin-left: 750px;"><Avatar /></el-icon> -->
  </el-menu>
</template>
