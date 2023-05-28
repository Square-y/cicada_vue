<template>
    <!-- <div @contextmenu.stop="" id="bubble" class="bubble">
      <canvas id="bubble-canvas" class="bubble-canvas"></canvas>
    </div> -->
    <div class="login">
      <div class="login-box">
        <div class="head">
          <img src="../../assets/logo-2.png" alt="" />
        </div>
        <div class="form">
          <!-- <img class="profile-avatar" src="~assets/avatar.png" alt=""> -->
          <div class="content">
            <el-form
              ref="formRef"
              @keyup.enter="onSubmit(formRef)"
              :model="form"
              status-icon
              :rules="rules"
              class="demo-ruleForm"
            >
              <el-form-item prop="username" style="height: 60px;">
                <el-input style="height: 60px;font-size: 20px;" ref="usernameRef" type="text" clearable v-model="form.username" placeholder="请输入邮箱">
                <template #prefix style="width: 40px;">
                  <Icon name="fa fa-user" class="form-item-icon" size="32" color="var(--el-input-icon-color)" />
                </template>
                </el-input>
              </el-form-item>
              <el-form-item  prop="password" style="height: 60px;">
                <el-input ref="passwordRef" style="height: 60px;font-size: 20px;" v-model="form.password" type="password" autocomplete="off" placeholder="请输入密码">
                  <template #prefix>
                    <Icon name="fa fa-unlock-alt" class="form-item-icon" size="32" color="var(--el-input-icon-color)" />
                  </template>
                </el-input>
              </el-form-item>
              <el-form-item  prop="captcha" style="height: 60px;">
                <el-row class="w100" :gutter="15" style="height: 60px;">
                    <el-col :span="11">
                        <el-input
                            ref="captchaRef"
                            type="text"
                            placeholder="请输入验证码"
                            v-model="form.captcha"
                            clearable
                            autocomplete="off"
                            style="height: 60px;font-size: 20px;"
                        >
                            <!-- <template #prefix>
                                <Icon name="fa fa-ellipsis-h" class="form-item-icon" size="16" color="var(--el-input-icon-color)" />
                            </template> -->
                        </el-input>
                    </el-col>
                    <el-col :span="8">
                        <img
                            @click="onChangeCaptcha"
                            class="captcha-img"
                            :src="buildCaptchaUrl() + '?id=' + state.captchaId"
                            alt=""
                        />
                    </el-col>
                </el-row>
              </el-form-item>
  
              <el-form-item style="height: 60px;">
                <el-button style="height: 60px;font-size: 20px;" class="submit-button"  type="primary" @click="onSubmit(formRef)"
                  >登录</el-button>
                <!-- 点击登录的弹框 -->
              
              </el-form-item>
            </el-form>
          </div>
        </div>
  
      </div>
    </div>
  
  </template>
  
  <script lang="ts" setup>
  import { reactive, ref } from 'vue'
  import type { FormInstance, FormRules } from 'element-plus'
  // 导入唯一标志
  import { uuid } from '../../utils/random'
  import type { ElForm, ElInput } from 'element-plus'
  import { buildCaptchaUrl } from '../../api/common'
  import axios from 'axios'
  import { buildValidatorData } from '../../utils/validate'
  import { ElMessage, ElMessageBox } from 'element-plus'
import type { Action } from 'element-plus'
import { useRouter } from 'vue-router';
import path from 'path'
import { PiniaVuePlugin } from 'pinia'

  // const fetchData = async () => {  
  //   try {    
  //     const response = await axios.get('/api/captcha');    
  //     console.log(response);  
  //   } catch (error) {    
  //     console.error(error);  
  //   }
  // }

const router = useRouter();
const formRef = ref<InstanceType<typeof ElForm>>()
const usernameRef = ref<InstanceType<typeof ElInput>>()
const passwordRef = ref<InstanceType<typeof ElInput>>()
const captchaRef = ref<InstanceType<typeof ElInput>>()
const form = reactive({
    username: '',
    password: '',
    captcha: '',
    keep: false,
    loading: false,
    captcha_id: '',
})
  
// 表单验证规则
const rules = reactive({
    username: [buildValidatorData({ name: 'required', message: '请输入邮箱' }), buildValidatorData({ name: 'email' , title: '邮箱'})],
    password: [buildValidatorData({ name: 'required', message: '请输入密码' }), buildValidatorData({ name: 'password' , title: '密码'})],
    captcha: [
        buildValidatorData({ name: 'required', title: '请输入验证码',message: '请输入验证码' }),
        {
            min: 4,
            max: 6,
            message: '验证码的长度必须是 4-6 位',
            trigger: 'blur',
        },
    ],
})
  
const onSubmit = (formEl: InstanceType<typeof ElForm> | undefined) => {
    if (!formEl) return
    formEl.validate((valid) => {
        if (valid) {
            form.loading = true
            form.captcha_id = state.captchaId
            axios.post("/api/login", form)
            .then(function(data){
              if (data.data.retCode == "000"){
                ElMessage({
                  message: data.data.retMsg,
                  type: 'success',
                })
                // 保存登录后的token状态
                sessionStorage.setItem("token",data.data.token)
                // 保存登录后的 用户id
                // console.log("userId", data)
                sessionStorage.setItem('userId', data.data.user_id);
                // 登录成功，跳转到主页
                router.push({path: "/"});
              } else {
                // 登录失败，报出登录失败提示信息
                ElMessage.error(data.data.retMsg)
              }

            }).catch(function(error){
              // 向后端请求失败， 弹出异常信息
              ElMessage.error(error)
              })

            // login('post', form)
            //     .then((res) => {
            //         form.loading = false
            //         adminInfo.dataFill(res.data.userInfo)
            //         ElNotification({
            //             message: res.msg,
            //             type: 'success',
            //         })
            //         router.push({ path: res.data.routePath })
            //     })
            //     .catch(() => {
            //         onChangeCaptcha()
            //         form.loading = false
            //     })
             


        } else {
            onChangeCaptcha()
            return false
        }
    })
}

const state = reactive({
    showCaptcha: false,
    captchaId: uuid(),
})

const onChangeCaptcha = () => {
    form.captcha = ''
    state.captchaId = uuid()
}


let captcha_img = ref()

  const getImg = () =>{
    // var that = captcha_img
    axios.get("/api/captcha")
    .then(function(data){
      console.log(data)
    }).catch(function(error){
      console.log(error)
      })
  }

  </script>
  
  <style scoped lang="scss">
  .login {
      position: absolute;
      top: 0;
      display: flex;
      width: 100vw;
      height: 100vh;
      align-items: center;
      justify-content: center;
      background-color: #0a0a0a;
      .login-box {
          overflow: hidden;
          width: 430px;
          padding: 0;
          // background: var(--ba-bg-color-overlay);
          background-color:#79b1f9;
          margin-bottom: 80px;
      }
      .head {
          background: #404040;
          img {
              display: block;
              width: 430px;
              margin: 0 auto;
              user-select: none;
          }
      }
      .form {
          position: flex;
          // .profile-avatar {
          //     display: block;
          //     position: absolute;
          //     height: 100px;
          //     width: 100px;
          //     border-radius: 50%;
          //     border: 4px solid var(--ba-bg-color-overlay);
          //     top: -50px;
          //     right: calc(50% - 50px);
          //     z-index: 2;
          //     user-select: none;
          // }
          .content {
              padding: 40px 40px 40px 40px;
              align-items: center;
  
          }
          .submit-button {
              width: 100%;
              letter-spacing: 2px;
              font-weight: 300;
              margin-top: 15px;
              --el-button-bg-color: var(--el-color-primary);
          }
      }
  }
  
  @media screen and (max-width: 720px) {
      .login {
          display: flex;
          align-items: center;
          justify-content: center;
          .login-box {
              width: 340px;
              margin-top: 0;
          }
      }
  }
  
  .form-item-icon {
      height: auto;
  }
  .content :deep(.el-input__prefix) {
      display: flex;
      align-items: center;
  }
  
  // .bubble {
  //     overflow: hidden;
  //     background: url(../../assets/bg.jpg) repeat;
  //     height: 100%;
  // }
  </style>
  