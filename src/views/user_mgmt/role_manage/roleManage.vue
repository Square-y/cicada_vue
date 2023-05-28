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

  <el-table :data="roleData" v-loading="loading" style="width: 100%">
  <el-table-column label="角色名" width="180">
    <template #default="scope">
      <el-popover effect="light" trigger="hover" placement="top" width="auto">
        <template #default>
          <div>{{ scope.row.roleName }}</div>
          <!-- <div>address: {{ scope.row.address }}</div> -->
        </template>
        <template #reference>
          <el-tag>{{ scope.row.roleName }}</el-tag>
        </template>
      </el-popover>
    </template>
  </el-table-column>

  <!-- <el-table-column label="昵称" width="180">
    <template #default="scope">
      <div style="display: flex; align-items: center">
        <span style="margin-left: 10px">{{ scope.row.nick_name }}</span>
      </div>
    </template>
  </el-table-column>
  <el-table-column label="角色" width="180">
    <template #default="scope">
      <div style="display: flex; align-items: center">
        <span style="margin-left: 10px">{{ scope.row.role_name }}</span>
      </div>
    </template>
  </el-table-column>

  <el-table-column label="创建时间" width="180">
    <template #default="scope">
      <div style="display: flex; align-items: center">
        <el-icon><timer /></el-icon>
        <span style="margin-left: 10px">{{ scope.row.create_time }}</span>
      </div>
    </template>
  </el-table-column> -->

  <el-table-column label="Operations">
    <template #default="scope">
      <el-button size="small" @click="handleEdit(scope.$index, scope.row)"
        >Edit</el-button
      >
      <el-button
        size="small"
        type="danger"
        @click="handleDelete(scope.$index, scope.row)"
        >Delete</el-button>
    </template>
  </el-table-column>
</el-table>


<el-dialog v-model="dialogFormVisible" title="编辑角色权限" :before-close="handleBeforeClose">
  <el-form style="text-align: left;">
    <el-tree
    ref="treeRef"
    :data="authInfo"
    show-checkbox
    highlight-current
    node-key="id"
    :default-checked-keys="authIdList"
    :props="defaultProps"
  />
  </el-form>
  <template #footer>
    <span class="dialog-footer">
      <el-button @click="dialogCancel">取消</el-button>
      <el-button type="primary" @click="dialogFormVisiblePut">
        确认
      </el-button>
    </span>
  </template>
</el-dialog>


<el-dialog v-model="dialogAddAuthVisible" title="添加角色">
    <el-form  style="text-align: center;margin:" :model="formAddAuth">
      <el-form-item  label="角色名" :label-width="formLabelWidth">
        <el-input style="width: 50%;" v-model="formAddAuth.roleName" autocomplete="off" />
      </el-form-item>
      <!-- <el-form-item  label="昵称" :label-width="formLabelWidth">
        <el-input style="width: 50%;" v-model="formAddAuth.nickName" autocomplete="off" />
      </el-form-item>
      <el-form-item  label="密码" :label-width="formLabelWidth">
        <el-input style="width: 50%;" v-model="formAddAuth.password" autocomplete="off" />
      </el-form-item>
      <el-form-item  label="确认密码" :label-width="formLabelWidth">
        <el-input style="width: 50%;" v-model="formAddAuth.confirmPassword" autocomplete="off" />
      </el-form-item>
      <el-form-item label="角色" :label-width="formLabelWidth">
        <el-select v-model="formAddAuth.roleId" placeholder="请选择角色">
          <el-option v-for="(item,index) in roleData" :key="index" :label="item.roleName" :value="item.roleId"></el-option>
        </el-select>
      </el-form-item> -->
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="dialogAddAuthVisible = false">取消</el-button>
        <el-button type="primary" @click="dialogAddAuthRequest()">
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
import { reactive, ref } from 'vue'
import axios from "axios"
import type Node from 'element-plus/es/components/tree/src/model/node'
import { ElTree } from 'element-plus'
import { ElMessage } from 'element-plus'
import { Search } from '@element-plus/icons-vue'

// 对话框 小标题 占的长度
const formLabelWidth = '205px'
const treeRef = ref<InstanceType<typeof ElTree>>()
const queryParam = ref()
// 新增角色对话框
const dialogAddAuthVisible = ref(false)

const queryParamSubmit = (param: string) => {
  console.log("查询参数：", param)
}

// 新增角色的信息
const formAddAuth = reactive({
  roleName: '',
})

// 点击新增按钮
const handleAdd = () => {
  console.log("handleAdd")
  dialogAddAuthVisible.value = true
}


// 新增用户请求
const dialogAddAuthRequest = () => {
  console.log("新增角色>>>>", formAddAuth)
  dialogAddAuthVisible.value = false
  const header = {'headers':{'Authorization': sessionStorage.getItem("token")}}
  // 发送请求给后端 新增用户
  axios.post("/api/roles", formAddAuth, header)
  .then(
    function(data){
      if (data.data.retCode == "000") {
        console.log("新增角色成功")
        ElMessage({
                  message: data.data.retMsg,
                  type: 'success',
                })
        getRoleData()
      } else {
        console.log("新增角色失败")
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

const defaultProps = {
  children: 'children',
  label: 'component',
}

const getAuthInfo = () => {
  // console.log("===>>>", sessionStorage.getItem("userId"), sessionStorage.getItem("token"))
        const header = {'headers':{'Authorization': sessionStorage.getItem("token")}}
        if (sessionStorage.getItem("userId") && sessionStorage.getItem("token")) {
          axios.get("/api/authsTree", header)
          .then(
            function(data) {
                if (data.data.retCode == "000"){
                    console.log("getAuthInfo>>>", data.data)
                    authInfo.value = data.data.result
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


interface Auth {
  id: string,
   component: string,  // 一级菜单名称
   children: Auth[]

}


const authInfo  = ref()



const authIdList = ref()





const getAuthIdList = (roleId: any) => {
  console.log("===>>>", sessionStorage.getItem("userId"), sessionStorage.getItem("token"))
        const header = {'headers':{'Authorization': sessionStorage.getItem("token")}}
        if (sessionStorage.getItem("userId") && sessionStorage.getItem("token")) {
          axios.get("/api/authId?roleId=" + roleId, header)
          .then(
            function(data) {
                if (data.data.retCode == "000"){
                   
                    authIdList.value = data.data.result
                    console.log("authIdList>>>", authIdList.value)

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



const currentPage4 = ref(4)
const pageSize4 = ref(100)
const small = ref(false)
const background = ref(false)
const disabled = ref(false)

const handleSizeChange = (val: number) => {
console.log(`${val} items per page`)
}
const handleCurrentChange = (val: number) => {
console.log(`current page: ${val}`)
}


interface Tree {
  roleName: string
  roleId: string
  authName: Tree[]
}


const handleEdit = (index: number, row: Tree) => {
  console.log(index, row)
  dialogFormVisible.value = true
  formEditRole.roleId = row.roleId
  getAuthIdList(row.roleId)
  console.log("===>>>", formEditRole)
  

}
const handleDelete = (index: number, row: Tree) => {
  console.log(index, row) 
}


const getRoleData = () => {
      console.log("===>>>", sessionStorage.getItem("userId"), sessionStorage.getItem("token"))
      const header = {'headers':{'Authorization': sessionStorage.getItem("token")}}
      if (sessionStorage.getItem("userId") && sessionStorage.getItem("token")) {
        axios.get("/api/roles", header)
        .then(
          function(data) {
              if (data.data.retCode == "000"){
                  console.log("data.data>>>", data.data)
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

getRoleData()
// 获取角色信息
const roleData = ref([])

getAuthInfo()

// const dialogTableVisible = ref(false)
const dialogFormVisible = ref(false)
// const formLabelWidth = '140px'

const getCheckedKeys = () => {
  // console.log(treeRef.value!.getCheckedKeys(false))
  // console.log(treeRef.value!.getHalfCheckedKeys())
  const checkedKey = treeRef.value!.getCheckedKeys(false).concat(treeRef.value!.getHalfCheckedKeys()) 
  return checkedKey
}

const dialogCancel = () => {
  
  treeRef.value!.setCheckedKeys([], false)
  dialogFormVisible.value = false
}

const handleBeforeClose = () => {
  treeRef.value!.setCheckedKeys([], false)
  dialogFormVisible.value = false
}


const dialogFormVisiblePut = () => {
  const checkedId = getCheckedKeys()
  formEditRole.checkedId = checkedId
  console.log("===authIdList>>>", authIdList)
      const header = {'headers':{'Authorization': sessionStorage.getItem("token")}}
      if (sessionStorage.getItem("userId") && sessionStorage.getItem("token")) {
        axios.put("/api/roles",formEditRole ,header)
        .then(
          function(data) {
              if (data.data.retCode == "000"){
                  console.log("data.data>>>", data.data)
                  dialogFormVisible.value = false
                  getRoleData()

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

// 更新的用户的信息
const formEditRole = reactive({
  // 需要知道 更新的角色的id
  roleId: '',
  checkedId: ref()
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
