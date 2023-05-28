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
<el-table
    :data="tableData"
    style="width: 100%; margin-bottom: 20px"
    row-key="id"
    border
    default-expand-all
    @selection-change="handleSelectionChange"
  >
    <el-table-column type="selection" width="45" />
    <el-table-column prop="title" label="菜单" sortable />
    <el-table-column prop="icon" label="图标" sortable />
    <el-table-column prop="type" label="类型" sortable />
    <el-table-column prop="component" label="组件" sortable />
    <el-table-column  label="操作" sortable> 
      <template #default="scope">
      <el-button size="small" @click="handleEdit(scope.$index, scope.row)"
        >Edit</el-button
      >
      <el-button
        size="small"
        type="danger"
        @click="handleDelete(scope.$index, scope.row)"
        >Delete</el-button
      >
    </template>
  </el-table-column>
  </el-table>



<el-dialog v-model="dialogFormVisible" title="用户修改">
  <el-form :model="form">
    <el-form-item label="用户" :label-width="formLabelWidth">
      <el-input v-model="form.name" autocomplete="off" />
    </el-form-item>
    <el-form-item label="昵称" :label-width="formLabelWidth">
      <el-input v-model="form.name" autocomplete="off" />
    </el-form-item>
    <el-form-item label="角色" :label-width="formLabelWidth">
      <el-select v-model="form.region" placeholder="请选择角色">
        <el-option label="用户" value="user" />
        <el-option label="管理员" value="admin" />
      </el-select>
    </el-form-item>
  </el-form>
  <template #footer>
    <span class="dialog-footer">
      <el-button @click="dialogFormVisible = false">取消</el-button>
      <el-button type="primary" @click="dialogFormVisible = false">
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


const currentPage4 = ref(4)
const pageSize4 = ref(100)
const small = ref(false)
const background = ref(false)
const disabled = ref(false)

const queryParam = ref()

interface Auth {
  user_name: string
  nick_name: string
  role_name: string
  create_time: string
  children?: Auth[]
}

const multipleSelection = ref<Auth[]>([])

const handleSelectionChange = (val: Auth[]) => {
  multipleSelection.value = val
}

const handleSizeChange = (val: number) => {
console.log(`${val} items per page`)
}
const handleCurrentChange = (val: number) => {
console.log(`current page: ${val}`)
}

// 新增角色对话框
const dialogAddAuthVisible = ref(false)

const queryParamSubmit = (param: string) => {
  console.log("查询参数：", param)
}

import { Timer } from '@element-plus/icons-vue'

// 点击新增按钮
const handleAdd = () => {
  console.log("handleAdd")
  dialogAddAuthVisible.value = true
}

const handleEdit = (index: number, row: Auth) => {
console.log(index, row)
dialogFormVisible.value = true
}
const handleDelete = (index: number, row: Auth) => {
console.log(index, row)
}


const getAuthInfo = () => {
      console.log("===>>>", sessionStorage.getItem("userId"), sessionStorage.getItem("token"))
      const header = {'headers':{'Authorization': sessionStorage.getItem("token")}}
      if (sessionStorage.getItem("userId") && sessionStorage.getItem("token")) {
        axios.get("/api/auths", header)
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

getAuthInfo()
const tableData = ref([])




const dialogTableVisible = ref(false)
const dialogFormVisible = ref(false)
const formLabelWidth = '140px'

const form = reactive({
name: '',
region: '',
date1: '',
date2: '',
delivery: false,
type: [],
resource: '',
desc: '',
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
