<template>
  <div style="display: flex;align-items: center;" >
      <el-button @click="handleAdd()">新增</el-button>
      <el-input
      class="w-50 m-2"
      placeholder="请输入"
      v-model="queryParam"
      :suffix-icon="Search"
      style="width: 15%;"
      @keyup.enter="queryParamSubmit(queryParam)"
      />
      </div>  
  <el-table :data="tableData" v-loading="loading" style="width: 100%">
    <el-table-column label="用户名" width="180">
      <template #default="scope">
        <el-popover effect="light" trigger="hover" placement="top" width="auto">
          <template #default>
            <div>{{ scope.row.userName }}</div>
            <!-- <div>address: {{ scope.row.address }}</div> -->
          </template>
          <template #reference>
            <el-tag>{{ scope.row.userName }}</el-tag>
          </template>
        </el-popover>
      </template>
    </el-table-column>
    <el-table-column label="昵称" width="180">
      <template #default="scope">
        <div style="display: flex; align-items: center">
          <span style="margin-left: 10px">{{ scope.row.nickName }}</span>
        </div>
      </template>
    </el-table-column>
    <el-table-column label="角色" width="180">
      <template #default="scope">
        <div style="display: flex; align-items: center">
          <!-- <el-icon><timer /></el-icon> -->
          <span style="margin-left: 10px">{{ scope.row.roleName }}</span>
        </div>
      </template>
    </el-table-column>

    <el-table-column label="创建时间" width="180">
      <template #default="scope">
        <div style="display: flex; align-items: center">
          <el-icon><timer /></el-icon>
          <span style="margin-left: 10px">{{ scope.row.createTime }}</span>
        </div>
      </template>
    </el-table-column>

    <el-table-column label="Operations">
      <template #default="scope">
          <el-tooltip content="编辑" placement="top" effect="light">
            <el-button size="small" @click="handleEdit(scope.$index, scope.row)">
              <el-icon><EditPen /></el-icon>
            </el-button>
          </el-tooltip>

        <el-button
          size="small"
          type="danger"
          @click="handleDelete(scope.$index, scope.row)">
            <el-icon><Delete /></el-icon>
          </el-button>

        <el-tooltip content="重置密码" placement="top" effect="light">
            <el-button size="small" @click="handleResetPassword(scope.$index, scope.row)">
              <el-icon><Key /></el-icon>
            </el-button>
        </el-tooltip>
      </template>
    </el-table-column>
  </el-table>


  <el-dialog v-model="dialogEditUserVisible" title="用户修改">
    <el-form  style="text-align: center;margin:" :model="formEditUser">
      <el-form-item  label="用户" :label-width="formLabelWidth">
        <el-input style="width: 50%;" v-model="formEditUser.userName" autocomplete="off" />
      </el-form-item>
      <el-form-item  label="昵称" :label-width="formLabelWidth">
        <el-input style="width: 50%;" v-model="formEditUser.nickName" autocomplete="off" />
      </el-form-item>
      <!-- <el-form-item  label="密码" :label-width="formLabelWidth">
        <el-input style="width: 50%;" v-model="form.name" autocomplete="off" />
      </el-form-item> -->
      <el-form-item label="角色" :label-width="formLabelWidth">
        <el-select v-model="formEditUser.roleId" placeholder="请选择角色">
          <!-- <el-option label="用户" value="user" /> -->
          <el-option v-for="(item,index) in roleData" :key="index" :label="item.roleName" :value="item.roleId"></el-option>
        </el-select>
      </el-form-item>
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="dialogEditUserVisible = false" >取消</el-button>
        <el-button type="primary" @click="formEditUserRequest()">
          确认
        </el-button>
      </span>
    </template>
  </el-dialog>

  <el-dialog v-model="dialogResetPasswordVisible" title="重置密码">
    <el-form  style="text-align: center;" :model="formResetPassword">
      <el-form-item  label="新密码" :label-width="formLabelWidth">
        <el-input style="width: 50%;" v-model="formResetPassword.password" autocomplete="off" />
      </el-form-item>
      <el-form-item  label="确认密码" :label-width="formLabelWidth">
        <el-input style="width: 50%;" v-model="formResetPassword.confirmPassword" autocomplete="off" />
      </el-form-item>
      <!-- <el-form-item  label="密码" :label-width="formLabelWidth">
        <el-input style="width: 50%;" v-model="form.name" autocomplete="off" />
      </el-form-item> -->
      <!-- <el-form-item label="角色" :label-width="formLabelWidth">
        <el-select v-model="form.region" placeholder="请选择角色">
          <el-option label="用户" value="user" />
          <el-option label="管理员" value="admin" />
        </el-select>
      </el-form-item> -->
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="dialogResetPasswordVisible = false">取消</el-button>
        <el-button type="primary" @click="dialogResetPasswordRequest()">
          确认
        </el-button>
      </span>
    </template>
  </el-dialog>


  <el-dialog v-model="dialogAddUserVisible" title="添加用户">
    <el-form  style="text-align: center;margin:" :model="formAddUser">
      <el-form-item  label="用户" :label-width="formLabelWidth">
        <el-input style="width: 50%;" v-model="formAddUser.userName" autocomplete="off" />
      </el-form-item>
      <el-form-item  label="昵称" :label-width="formLabelWidth">
        <el-input style="width: 50%;" v-model="formAddUser.nickName" autocomplete="off" />
      </el-form-item>
      <el-form-item  label="密码" :label-width="formLabelWidth">
        <el-input style="width: 50%;" v-model="formAddUser.password" autocomplete="off" />
      </el-form-item>
      <el-form-item  label="确认密码" :label-width="formLabelWidth">
        <el-input style="width: 50%;" v-model="formAddUser.confirmPassword" autocomplete="off" />
      </el-form-item>
      <el-form-item label="角色" :label-width="formLabelWidth">
        <el-select v-model="formAddUser.roleId" placeholder="请选择角色">
          <!-- <el-option label="用户" value="user" /> -->
          <el-option v-for="(item,index) in roleData" :key="index" :label="item.roleName" :value="item.roleId"></el-option>
        </el-select>
      </el-form-item>
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="dialogAddUserVisible = false">取消</el-button>
        <el-button type="primary" @click="dialogAddUserRequest()">
          确认
        </el-button>
      </span>
    </template>
  </el-dialog>


    <div class="demo-pagination-block">
      <!-- <div class="demonstration">All combined</div> -->
      <el-pagination
        v-model:current-page="currentPage4"
        v-model:page-size="pageSize4"
        :page-sizes="[100, 200, 300, 400]"
        :small="small"
        :disabled="disabled"
        :background="background"
        layout="total, sizes, prev, pager, next, jumper"
        :total="400"
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
      />
    </div>
</template>
<script lang="ts" setup>
import { reactive,ref } from 'vue'
import axios from "axios"
import { Search } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'

const currentPage4 = ref(4)
const pageSize4 = ref(100)
const small = ref(false)
const background = ref(false)
const disabled = ref(false)
const queryParam = ref()

const queryParamSubmit = (param: string) => {
  console.log("查询参数：", param)
}


const handleSizeChange = (val: number) => {
  console.log(`${val} items per page`)
}
const handleCurrentChange = (val: number) => {
  console.log(`current page: ${val}`)
}

import { Timer } from '@element-plus/icons-vue'

interface User {
  userName: string
  nickName: string
  roleName: string
  createTime: string
  userId: string
}


// 点击页面的编辑按钮
const handleEdit = (index: number, row: User) => {
  console.log(index, row)
  dialogEditUserVisible.value = true
  // 将需要编辑的用户的用户id 赋值给 请求的数据
  formEditUser.userId = row.userId
  
}

// 点击删除用户按钮
const handleDelete = (index: number, row: User) => {
  console.log(index, row)
  const header = {'headers':{'Authorization': sessionStorage.getItem("token")}}

  // 发送请求给后端 删除用户
  axios.delete("/api/users?userId=" + row.userId, header)
  .then(
    function(data){
      if (data.data.retCode == "000") {
        console.log("删除用户成功")
        ElMessage({
                  message: data.data.retMsg,
                  type: 'success',
                })
        getUserInfo()
      } else {
        console.log("删除用户失败")
        ElMessage.error(data.data.retMsg)
      }
    }
  ).catch(
    function(error) {
      // 向后端请求失败， 弹出异常信息
      ElMessage.error(error)
    }
  )
}

// 点击重置密码按钮
const handleResetPassword = (index: number, row: User) => {
  console.log(index, row)
  dialogResetPasswordVisible.value = true
  // 取出改行 用户信息的用户id
  formResetPassword.userId = row.userId
  
}

// 点击新增按钮
const handleAdd = () => {
  console.log("handleAdd")
  dialogAddUserVisible.value = true
}


// 更新用户信息请求
const formEditUserRequest = () => {
  console.log("更新用户>>>", formEditUser)
  dialogEditUserVisible.value = false
  const header = {'headers':{'Authorization': sessionStorage.getItem("token")}}
  // 发送请求给后端 更新用户
  axios.put("/api/users", formEditUser, header)
  .then(
    function(data){
      if (data.data.retCode == "000") {
        console.log("更新用户成功")
        ElMessage({
                  message: data.data.retMsg,
                  type: 'success',
                })
        getUserInfo()
      } else {
        console.log("更新用户失败")
        ElMessage.error(data.data.retMsg)
      }
    }
  ).catch(
    function(error) {
      // 向后端请求失败， 弹出异常信息
      ElMessage.error(error)
    }
  )
}

// 重置密码请求
const dialogResetPasswordRequest = () => {
  console.log("重置密码>>>", formResetPassword)
  dialogResetPasswordVisible.value = false
  const header = {'headers':{'Authorization': sessionStorage.getItem("token")}}
  // 发送请求给后端 重置密码
  axios.post("/api/resetPassword", formResetPassword,header)
  .then(
    function(data){
      if (data.data.retCode == "000") {
        console.log("重置成功")
        ElMessage({
                  message: data.data.retMsg,
                  type: 'success',
                })
      } else {
        console.log("重置失败")
        ElMessage.error(data.data.retMsg)
      }
    }
  ).catch(
    function(error) {
      // 向后端请求失败， 弹出异常信息
      ElMessage.error(error)
    }
  )
}

// 新增用户请求
const dialogAddUserRequest = () => {
  console.log("新增用户>>>>", formAddUser)
  dialogAddUserVisible.value = false
  const header = {'headers':{'Authorization': sessionStorage.getItem("token")}}
  // 发送请求给后端 新增用户
  axios.post("/api/users", formAddUser, header)
  .then(
    function(data){
      if (data.data.retCode == "000") {
        console.log("新增用户成功")
        ElMessage({
                  message: data.data.retMsg,
                  type: 'success',
                })
        getUserInfo()
      } else {
        console.log("新增用户失败")
        ElMessage.error(data.data.retMsg)
      }
    }
  ).catch(
    function(error) {
      // 向后端请求失败， 弹出异常信息
      console.log("向后端请求异常")
      ElMessage.error(error)
    }
  )
}

//  获取已存在的用户的信息
const getUserInfo = () => {
        console.log("===>>>", sessionStorage.getItem("userId"), sessionStorage.getItem("token"))
        const header = {'headers':{'Authorization': sessionStorage.getItem("token")}}
        if (sessionStorage.getItem("userId") && sessionStorage.getItem("token")) {
          axios.get("/api/users", header)
          .then(
            function(data) {
                if (data.data.retCode == "000"){
                    console.log("data.data>>>", data.data)
                    tableData.value = data.data.result
                    // isVisible.value = false

                  } else {
                    // console.log("bbbb")
                    // 用户未登录
                    // isVisible.value = true
                  }
              }).catch(
                function(error) {
                  // console.log("ddd", error)
                  // isVisible.value = true
                }
          )
          } else {
            // console.log("aaaaa")
            // isVisible.value = true
          }

    
    }

// 获取角色信息
const getRoleData = () => {
  console.log("===>>>", sessionStorage.getItem("token"))
        const header = {'headers':{'Authorization': sessionStorage.getItem("token")}}
        if (sessionStorage.getItem("userId") && sessionStorage.getItem("token")) {
          axios.get("/api/roles", header)
          .then(
            function(data) {
                if (data.data.retCode == "000"){
                    console.log("角色信息>>>", data.data)
                    roleData.value = data.data.result
                    // isVisible.value = false

                  } else {
                    // console.log("bbbb")
                    // 用户未登录
                    // isVisible.value = true
                  }
              }).catch(
                function(error) {
                  // console.log("ddd", error)
                  // isVisible.value = true
                }
          )
          } else {
            // console.log("aaaaa")
            // isVisible.value = true
          }
}

getUserInfo()
// 已有的用户数据
const tableData = ref([])


getRoleData()
// 获取角色信息
const roleData = ref([])

// 新增用户对话框
const dialogAddUserVisible = ref(false)
// 重置密码对话框
const dialogResetPasswordVisible = ref(false)
// 编辑用户信息对话框
const dialogEditUserVisible = ref(false)
// 对话框 小标题 占的长度
const formLabelWidth = '205px'


// 更新的用户的信息
const formEditUser = reactive({
  userName: '',
  nickName: '',
  roleId: '',
  // 需要知道 更新的用户的id
  userId:''
})

// 新增的用户的信息
const formAddUser = reactive({
  userName: '',
  nickName: '',
  password: '',
  confirmPassword: '',
  roleId: '',
})

// 重置的用户的密码
const formResetPassword = reactive({
    password: "",
    confirmPassword: "",
    // 需要知道重置的用户的id
    userId: ''
})




</script>
  
<style scoped>
.demo-pagination-block + .demo-pagination-block {
margin-top: 10px;
}
.demo-pagination-block .demonstration {
margin-bottom: 16px;
}

.el-button--text {
  margin-right: 15px;
}
.el-select {
  width: 300px;
}
.el-input {
  width: 300px;
}
.dialog-footer button:first-child {
  margin-right: 10px;
}



</style>
  