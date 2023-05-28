import { defineStore } from 'pinia'
import { MenuInfo } from "/@/stores/interface"

export const useMenuInfo = defineStore('menuInfo', {
  state: (): MenuInfo => {
    return { menuList: []}
  },
  // 也可以这样定义
  // state: () => ({ count: 0 })
  actions: {
    getMenuInfo() {
      return this.menuList
    },
    setMenuInfo(menuList:any) {
        this.menuList = menuList
    }
  },
})