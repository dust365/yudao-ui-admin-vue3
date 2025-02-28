<template>
  <ContentWrap>
    <!-- 搜索工作栏 -->
    <el-form
      class="-mb-15px"
      :model="queryParams"
      ref="queryFormRef"
      :inline="true"
      label-width="68px"
    >
      <el-form-item label="应用名称" prop="appName">
        <el-input
          v-model="queryParams.appName"
          placeholder="请输入应用名称"
          clearable
          @keyup.enter="handleQuery"
          class="!w-240px"
        />
      </el-form-item>
      <el-form-item label="用户id" prop="userUid">
        <el-input
          v-model="queryParams.userUid"
          placeholder="请输入用户id"
          clearable
          @keyup.enter="handleQuery"
          class="!w-240px"
        />
      </el-form-item>
      <el-form-item label="操作者" prop="operator">
        <el-date-picker
          v-model="queryParams.operator"
          value-format="YYYY-MM-DD"
          type="date"
          placeholder="选择操作者"
          clearable
          class="!w-240px"
        />
      </el-form-item>
      <el-form-item label="操作时间" prop="operationTime">
        <el-date-picker
          v-model="queryParams.operationTime"
          value-format="YYYY-MM-DD HH:mm:ss"
          type="daterange"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
          :default-time="[new Date('1 00:00:00'), new Date('1 23:59:59')]"
          class="!w-220px"
        />
      </el-form-item>

      <el-form-item label="任务状态" prop="taskStatus">
        <el-select
          v-model="queryParams.taskStatus"
          placeholder="请选择任务状态"
          clearable
          class="!w-240px"
        >
          <el-option label="全部" value="" />
          <el-option label="进行中" value="1" />
          <el-option label="完成" value="2" />
          <el-option label="失败/超时" value="3" />
        </el-select>
      </el-form-item>
      
      <el-form-item label="日志结果链接" prop="resultUrl">
        <el-input
          v-model="queryParams.resultUrl"
          placeholder="请输入日志结果链接"
          clearable
          @keyup.enter="handleQuery"
          class="!w-240px"
        />
      </el-form-item>
      <el-form-item>
        <el-button @click="handleQuery"><Icon icon="ep:search" class="mr-5px" /> 搜索</el-button>
        <el-button @click="resetQuery"><Icon icon="ep:refresh" class="mr-5px" /> 重置</el-button>
        <el-button type="primary" plain @click="openForm('create')">
          <Icon icon="ep:plus" class="mr-5px" /> 新增
        </el-button>
        <el-button
          type="success"
          plain
          @click="handleExport"
          :loading="exportLoading"
          v-hasPermi="['client:log-task:export']"
        >
          <Icon icon="ep:download" class="mr-5px" /> 导出
        </el-button>
      </el-form-item>
    </el-form>
  </ContentWrap>

  <!-- 列表 -->
  <ContentWrap>
    <el-table v-loading="loading" :data="list" :stripe="true" :show-overflow-tooltip="true">
      <el-table-column label="任务id" align="center" prop="taskId" />
      <el-table-column label="应用名称" align="center" prop="appName" />
      <el-table-column label="用户id" align="center" prop="userUid" />
      <el-table-column label="操作者" align="center" prop="operator" />
      <el-table-column
        label="操作时间"
        align="center"
        prop="operationTime"
        :formatter="dateFormatter"
        width="180px"
      />
      <el-table-column label="任务状态" align="center" prop="taskStatus" />
      <el-table-column label="日志结果链接" align="center" prop="resultUrl" />
      <el-table-column label="操作" align="center" min-width="120px">
        <template #default="scope">
          <el-button
            link
            type="primary"
            @click="openForm('update', scope.row.id)"
            v-hasPermi="['client:log-task:update']"
          >
            编辑
          </el-button>
          <el-button
            link
            type="danger"
            @click="handleDelete(scope.row.id)"
            v-hasPermi="['client:log-task:delete']"
          >
            删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    <!-- 分页 -->
    <Pagination
      :total="total"
      v-model:page="queryParams.pageNo"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />
  </ContentWrap>

  <!-- 表单弹窗：添加/修改 -->
  <LogTaskForm ref="formRef" @success="getList" />
</template>

<script setup lang="ts">
import { dateFormatter } from '@/utils/formatTime'
import download from '@/utils/download'
import { LogTaskApi, LogTaskVO } from '@/api/client/logtask'
import LogTaskForm from './LogTaskForm.vue'

/** 日志捞取建 列表 */
defineOptions({ name: 'LogTask' })

const message = useMessage() // 消息弹窗
const { t } = useI18n() // 国际化

const loading = ref(true) // 列表的加载中
const list = ref<LogTaskVO[]>([]) // 列表的数据
const total = ref(0) // 列表的总页数
const queryParams = reactive({
  pageNo: 1,
  pageSize: 10,
  appName: undefined,
  userUid: undefined,
  operator: undefined,
  operator: [],
  operationTime: [],
  taskStatus: undefined,
  resultUrl: undefined
})
const queryFormRef = ref() // 搜索的表单
const exportLoading = ref(false) // 导出的加载中

/** 查询列表 */
const getList = async () => {
  loading.value = true
  try {
    const data = await LogTaskApi.getLogTaskPage(queryParams)
    list.value = data.list
    total.value = data.total
  } finally {
    loading.value = false
  }
}

/** 搜索按钮操作 */
const handleQuery = () => {
  queryParams.pageNo = 1
  getList()
}

/** 重置按钮操作 */
const resetQuery = () => {
  queryFormRef.value.resetFields()
  handleQuery()
}

/** 添加/修改操作 */
const formRef = ref()
const openForm = (type: string, id?: number) => {
  formRef.value.open(type, id)
}

/** 删除按钮操作 */
const handleDelete = async (id: number) => {
  try {
    // 删除的二次确认
    await message.delConfirm()
    // 发起删除
    await LogTaskApi.deleteLogTask(id)
    message.success(t('common.delSuccess'))
    // 刷新列表
    await getList()
  } catch {}
}

/** 导出按钮操作 */
const handleExport = async () => {
  try {
    // 导出的二次确认
    await message.exportConfirm()
    // 发起导出
    exportLoading.value = true
    const data = await LogTaskApi.exportLogTask(queryParams)
    download.excel(data, '日志捞取建.xls')
  } catch {
  } finally {
    exportLoading.value = false
  }
}

/** 初始化 **/
onMounted(() => {
  getList()
})
</script>
