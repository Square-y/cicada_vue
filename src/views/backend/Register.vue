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
            ref="ruleFormRef"

            :model="ruleForm"
            status-icon
            :rules="rules"
            class="demo-ruleForm"
          >
            <el-form-item prop="username">
              <el-input v-model="ruleForm.username" placeholder="请输入用户名">
              <template #prefix>
                <Icon name="fa fa-user" class="form-item-icon" size="16" color="var(--el-input-icon-color)" />
              </template>
              </el-input>
            </el-form-item>
            <el-form-item  prop="pass">
              <el-input v-model="ruleForm.password" type="password" autocomplete="off" placeholder="请输入密码">
                <template #prefix>
                  <Icon name="fa fa-unlock-alt" class="form-item-icon" size="16" color="var(--el-input-icon-color)" />
                </template>
              </el-input>
            </el-form-item>
            <el-form-item  prop="checkPass" >
              <el-input
                v-model="ruleForm.repassword"
                type="password"
                autocomplete="off"
                placeholder="确认密码"
              >
                <template #prefix>
                  <Icon name="fa fa-unlock-alt" class="form-item-icon" size="16" color="var(--el-input-icon-color)" />
                </template>
              </el-input>
            </el-form-item>


            <!-- <el-form-item  prop="captcha">
              <el-row class="w100" :gutter="15">
                  <el-col :span="16">
                      <el-input
                          ref="captchaRef"
                          type="text"
                          placeholder="请输入验证码"
                          clearable
                          autocomplete="off"
                      >
                          <template #prefix>
                              <Icon name="fa fa-ellipsis-h" class="form-item-icon" size="16" color="var(--el-input-icon-color)" />
                          </template>
                      </el-input>
                  </el-col>
                  <el-col :span="8">
                      <img
                          @click="onChangeCaptcha"
                          class="captcha-img"
                          :src="buildCaptchaUrl() + '&id=' + state.captchaId"
                          alt=""
                      />
                  </el-col>
              </el-row>
            </el-form-item> -->

            <el-form-item>
              <el-button class="submit-button" type="primary" @click="submitForm(ruleFormRef)"
                >注册</el-button
              >
              <!-- <el-button @click="resetForm(ruleFormRef)">Reset</el-button> -->
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
import { ElMessage } from 'element-plus'
import axios from 'axios'
import { useRouter } from 'vue-router';


const router = useRouter();
const ruleFormRef = ref<FormInstance>()

const checkEmail = (rule: any, value: any, callback: any) => {
  if (!value) {
    return callback(new Error('请输入邮箱'))
  }
  var reg = /^[0-9a-zA-Z_.-]+[@][0-9a-zA-Z_.-]+([.][a-zA-Z]+){1,2}$/;

  setTimeout(() => {
    if (!reg.test(value)) {
      callback(new Error('请输入邮箱'))
    } else {
        callback();
    }
  }, 1000);
}

const validatePass = (rule: any, value: any, callback: any) => {
  if (value === '') {
    callback(new Error('Please input the password'))
  } else {
    if (ruleForm.repassword !== '') {
      if (!ruleFormRef.value) return
      ruleFormRef.value.validateField('repassword', () => null)
    }
    callback()
  }
}
const validatePass2 = (rule: any, value: any, callback: any) => {
  if (value === '') {
    callback(new Error('请再次输入密码'))
  } else if (value !== ruleForm.password) {
    callback(new Error("两次输入的密码不一致!"))
  } else {
    callback()
  }
}

const ruleForm = reactive({
  username: '',
  password: '',
  repassword: '',
})

const rules = reactive<FormRules>({
  username: [{ validator: checkEmail, trigger: 'blur' }],
  password: [{ validator: validatePass, trigger: 'blur' }],
  repassword: [{ validator: validatePass2, trigger: 'blur' }],
})

const submitForm = (formEl: FormInstance | undefined) => {
  if (!formEl) return
  formEl.validate((valid) => {
    if (valid) {
      console.log('submit!', ruleForm)
      axios.post("/api/register", ruleForm)
      .then(function(data) {
          if (data.data.retCode == "000") {
            ElMessage({
                  message: data.data.retMsg,
                  type: 'success',
                })
            console.log(data.data)
            console.log("register", data.data.token, data.data.user_id)
            // 保存登录后的token状态
            sessionStorage.setItem("token",data.data.token)
            // 保存登录后的 用户id
            sessionStorage.setItem('userId', data.data.user_id);
            router.push({path:"/"});
          } else {
            ElMessage.error(data.data.retMsg)
          }
        }).catch(function(error){
              // 向后端请求失败， 弹出异常信息
              ElMessage.error(error)
              })
    } else {
      console.log('error submit!')
      return false
    }
  })
}

const resetForm = (formEl: FormInstance | undefined) => {
  if (!formEl) return
  formEl.resetFields()
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
