<template>
  <el-config-provider namespace="ep" :locale="locale">
    <RouterView></RouterView>
  </el-config-provider>
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
