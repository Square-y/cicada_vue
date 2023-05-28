import { defineStore } from 'pinia'

export const useToken = defineStore("token",{
    state: () => {
        return { token: '',  }
      },
      // 也可以这样定义
      // state: () => ({ count: 0 })
      actions: {
        // 存储 token
        setToken(jwt_token:string) {
          this.token = jwt_token
          return this.token
        },
        // 获取 token
        getToken() {
          return this.token
        }
      },
    }
)