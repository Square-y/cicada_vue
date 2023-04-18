import { defineStore } from 'pinia'

export const useCollapse = defineStore('isCollapse', {
  state: () => {
    return { isCollapse: false,  }
  },
  // 也可以这样定义
  // state: () => ({ count: 0 })
  actions: {
    changeCollapse() {
      this.isCollapse = !this.isCollapse
      return this.isCollapse
    },
  },
})