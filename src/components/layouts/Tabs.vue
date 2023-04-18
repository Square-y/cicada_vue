<template>
  <el-tabs
    v-model="editableTabsValue"
    type="card"
    class="demo-tabs"
    closable
    @tab-remove="removeTab"
  >
    <el-tab-pane
      v-for="item in editableTabs"
      :key="item.name"
      :label="item.title"
      :name="item.name"
    >
      <div>
        <component :is="item.content"></component>
      </div>
      
    </el-tab-pane>
  </el-tabs>
</template>
<script lang="ts" setup>
import { ref } from 'vue'
import { useTabStore } from '../../stores/editableTabs'
import emitter from "../../utils/eventbus" //menu也要引用刚刚新建的utils文件

const tabStore = useTabStore()
// const homeTabMenuId = tabStore.GetHomeTabMenuId
console.log('---===---', tabStore.$state)
let tabIndex = 1
const editableTabsValue = ref('1')
console.log("///", editableTabsValue.value)
const editableTabs = ref([
  {
    title: tabStore.openedTabs[0].title,
    // title: 'ffff',
    name: editableTabsValue.value,
    // name: '1234',
    content: tabStore.openedTabs[0].components[0].path,
  }
])
console.log('>>>', editableTabs)


emitter.on("opTab", (info: any) => {
  // console.log("--->", info)
  addTab(info)
})

const addTab = (targetName: any) => {
  // 设置当前要显示的 tab name
  tabStore.currentTabIndex = targetName.menuId

  // 判断 tab 项是否已存在
  let tabExsit = tabStore.openedTabs.find(i => i.menuId === targetName.menuId)
  // if (!tabExsit) {
  //   editableTabs.value.push({
  //     title: targetName.title,                      // 显示标题
  //     name: targetName.menuId,                    // 用于标记当前打开 tab 的 name
  //     content: targetName.component,   //  tab 对应的组件
  //   })
  // } else if(targetName.fromHistory) {               // 点击前进后退按钮
  //   tabStore.openedTabs.map(i => {
  //     if(i.menuId === targetName.menuId) {
  //       i.components = targetName.components
  //     }
  //   })
  // }

  const newTabName = `${++tabIndex}`
  console.log("name:", newTabName)
  editableTabs.value.push({
    title: targetName.title,
    name: newTabName,
    content: targetName.component,
  })
  editableTabsValue.value = newTabName
}

const removeTab = (targetName: string) => {
  const tabs = editableTabs.value
  let activeName = editableTabsValue.value
  if (activeName === targetName) {
    tabs.forEach((tab, index) => {
      if (tab.name === targetName) {
        const nextTab = tabs[index + 1] || tabs[index - 1]
        if (nextTab) {
          activeName = nextTab.name
        }
      }
    })
  }

  editableTabsValue.value = activeName
  editableTabs.value = tabs.filter((tab) => tab.name !== targetName)
}
 
</script>
<style>
.demo-tabs>.el-tabs__content {
  padding: 32px;
  color: #6b778c;
  font-size: 32px;
  font-weight: 600;
}
</style>
