<template>
      <el-container>
        <el-header>
          <BaseHeader />
        </el-header>
        
        <el-container class="middleWrap">
          <!-- <div style="display: inline-flex;width: 100%;height: 200%;"> -->
          <!-- <el-aside> -->
          <BaseSide style="display: inline-block;" />
          <!-- </el-aside> -->
          <!-- <div style="display: inline-block; width: 100%;"> -->
          <!-- <img alt="Vue logo" class="element-plus-logo" src="./assets/logo.png" />
            <HelloWorld msg="Hello Vue 3.0 + Element Plus + Vite" /> -->
          <el-main>
            <Tabs style="height: 100%; width: 100%;border: 0px solid #414243;" />
          </el-main>
          <!-- </div>
          </div> -->
        </el-container>
      </el-container>
  </template>
  
  <style>
  #app {
    text-align: center;
    color: var(--ep-text-color-primary);
  }
  
  .element-plus-logo {
    width: 50%;
  }
  
  /* 主容器   */
  .middleWrap {
    width: 100%;
    /* 并使主容器高度 充满屏幕 */
    height: calc(100vh - 64px);
    overflow: hidden;
    display: flex;
    position: relative;
  }
  </style>
  