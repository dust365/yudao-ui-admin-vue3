import request from '@/config/axios'

// 日志捞取建 VO
export interface LogTaskVO {
  taskId: number // 任务id
  appName: string // 应用名称
  userUid: number // 用户id
  operator: string // 操作者
  operationTime: Date // 操作时间
  taskStatus: number // 任务状态
  resultUrl: string // 日志结果链接
}
// 日志捞取建 API
export const LogTaskApi = {
  // 查询日志捞取建分页
  getLogTaskPage: async (params: any) => {
    return await request.get({ url: '/client/log-task/query', params })
  },

  // 查询日志捞取建详情
  getLogTask: async (id: number) => {
    return await request.get({ url: `/client/log-task/get?id=` + id })
  },

  // 新增日志捞取建
  createLogTask: async (data: LogTaskVO) => {
    return await request.post({ url: `/client/log-task/create`, data })
  },

  // 修改日志捞取建
  updateLogTask: async (data: LogTaskVO) => {
    return await request.put({ url: `/client/log-task/update`, data })
  },

  // 删除日志捞取建
  deleteLogTask: async (id: number) => {
    return await request.delete({ url: `/client/log-task/delete?id=` + id })
  },

  // 导出日志捞取建 Excel
  exportLogTask: async (params) => {
    return await request.download({ url: `/client/log-task/export-excel`, params })
  }
}