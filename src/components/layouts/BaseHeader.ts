import  axios  from "axios"



export default {
    setup(){
        // console.log("<<<>>>", sessionStorage.getItem("userId"))
        axios.get("/api/users?userId=" + sessionStorage.getItem("userId")).then(
            function(data) {
                console.log(">>><",data.data)
                if (data.data.retCode == "000"){
                    return data.data
                    // 保存登录后的token状态
                    // window.sessionStorage.setItem("token",data.data.token)
                    // 登录成功，跳转到主页
                    // router.push({path: "/"});
                  } else {
                    // 登录失败，报出登录失败提示信息
                    // ElMessage.error(data.data.retMsg)
                  }
            }
        )
    }
}