<template>
  <Dialog :title="dialogTitle" v-model="dialogVisible">
    <el-form
      ref="formRef"
      :model="formData"
      :rules="formRules"
      label-width="100px"
      v-loading="formLoading"
    >
      <el-form-item label="应用名称" prop="appName">
        <el-input v-model="formData.appName" placeholder="请输入应用名称" />
      </el-form-item>
      <el-form-item label="用户id" prop="userUid">
        <el-input v-model="formData.userUid" placeholder="请输入用户id" />
      </el-form-item>
      <el-form-item label="操作者" prop="operator">
        <el-date-picker
          v-model="formData.operator"
          type="date"
          value-format="x"
          placeholder="选择操作者"
        />
      </el-form-item>
      <el-form-item label="操作时间" prop="operationTime">
        <el-date-picker
          v-model="formData.operationTime"
          type="date"
          value-format="x"
          placeholder="选择操作时间"
        />
      </el-form-item>
      <el-form-item label="任务状态" prop="taskStatus">
        <el-select v-model="formData.taskStatus" placeholder="请选择任务状态">
          <el-option label="请选择字典生成" value="" />
        </el-select>
      </el-form-item>
      <el-form-item label="日志结果链接" prop="resultUrl">
        <el-input v-model="formData.resultUrl" placeholder="请输入日志结果链接" />
      </el-form-item>
    </el-form>
    <template #footer>
      <el-button @click="submitForm" type="primary" :disabled="formLoading">确 定</el-button>
      <el-button @click="dialogVisible = false">取 消</el-button>
    </template>
  </Dialog>
</template>
<script setup lang="ts">
import { LogTaskApi, LogTaskVO } from '@/api/client/logtask'

/** 日志捞取建 表单 */
defineOptions({ name: 'LogTaskForm' })

const { t } = useI18n() // 国际化
const message = useMessage() // 消息弹窗

const dialogVisible = ref(false) // 弹窗的是否展示
const dialogTitle = ref('') // 弹窗的标题
const formLoading = ref(false) // 表单的加载中：1）修改时的数据加载；2）提交的按钮禁用
const formType = ref('') // 表单的类型：create - 新增；update - 修改
const formData = ref({
  taskId: undefined,
  appName: undefined,
  userUid: undefined,
  operator: undefined,
  operationTime: undefined,
  taskStatus: undefined,
  resultUrl: undefined
})
const formRules = reactive({
  appName: [{ required: true, message: '应用名称不能为空', trigger: 'blur' }],
  userUid: [{ required: true, message: '用户id不能为空', trigger: 'blur' }],
  operator: [{ required: true, message: '操作者不能为空', trigger: 'blur' }],
  operationTime: [{ required: true, message: '操作时间不能为空', trigger: 'blur' }]
})
const formRef = ref() // 表单 Ref

/** 打开弹窗 */
const open = async (type: string, id?: number) => {
  dialogVisible.value = true
  dialogTitle.value = t('action.' + type)
  formType.value = type
  resetForm()
  // 修改时，设置数据
  if (id) {
    formLoading.value = true
    try {
      formData.value = await LogTaskApi.getLogTask(id)
    } finally {
      formLoading.value = false
    }
  }
}
defineExpose({ open }) // 提供 open 方法，用于打开弹窗

/** 提交表单 */
const emit = defineEmits(['success']) // 定义 success 事件，用于操作成功后的回调
const submitForm = async () => {
  // 校验表单
  await formRef.value.validate()
  // 提交请求
  formLoading.value = true
  try {
    const data = formData.value as unknown as LogTaskVO
    if (formType.value === 'create') {
      await LogTaskApi.createLogTask(data)
      message.success(t('common.createSuccess'))
    } else {
      await LogTaskApi.updateLogTask(data)
      message.success(t('common.updateSuccess'))
    }
    dialogVisible.value = false
    // 发送操作成功的事件
    emit('success')
  } finally {
    formLoading.value = false
  }
}

/** 重置表单 */
const resetForm = () => {
  formData.value = {
    taskId: undefined,
    appName: undefined,
    userUid: undefined,
    operator: undefined,
    operationTime: undefined,
    taskStatus: undefined,
    resultUrl: undefined
  }
  formRef.value?.resetFields()
}
</script>