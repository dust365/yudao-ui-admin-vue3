<template>

 <h1 class="page-title">日志管理</h1>
  <!-- 搜索工作栏 -->
  <ContentWrap>
    <el-form
      ref="queryFormRef"
      :inline="true"
      :model="queryParams"
      class="-mb-15px"
      label-width="68px"
    >
      <el-form-item>
        <el-button @click="handleQuery">
          <Icon class="mr-5px" icon="ep:search" />
          搜索
        </el-button>
        <el-button @click="resetQuery">
          <Icon class="mr-5px" icon="ep:refresh" />
          重置
        </el-button>
        <el-button
          v-hasPermi="['system:menu:create']"
          plain
          type="primary"
          @click="handleAdd"
        >
          <Icon class="mr-5px" icon="ep:plus" />
          新增
        </el-button>
        <el-button plain type="danger" @click="toggleExpandAll">
          <Icon class="mr-5px" icon="ep:sort" />
          展开/折叠
        </el-button>
      </el-form-item>
    </el-form>
  </ContentWrap>

 <!-- 列表的数据 -->
   <ContentWrap>
    <el-table :data="tasks" style="width: 100%">
      <el-table-column prop="id" label="任务ID" width="100" />
      <el-table-column prop="appName" label="App名称" width="150" />
      <el-table-column prop="userId" label="捞取用户UID" width="150" />
      <el-table-column prop="operator" label="操作者" width="150" />
      <el-table-column prop="operationTime" label="操作时间" width="200" />
      <el-table-column prop="status" label="任务状态"  width="150" />
      <el-table-column label="操作"   header-align="center" width="300">
        <template #default="scope">
          <el-button @click="handleFetch(scope.row)" size="mini">点击捞取</el-button>
          <el-button @click="handleDownload(scope.row)" size="mini">日志下载</el-button>
        </template>
      </el-table-column>
    </el-table>
  </ContentWrap>
</template>

<script lang="ts" setup>
import { ref } from 'vue';

const tasks = ref([
  {
    id: 74,
    appName: 'loole',
    userId: 2420686,
    operator: '陈辉',
    operationTime: '2025-02-13 22:12:23',
    status: '捞取成功'
  },
  {
    id: 73,
    appName: 'loole',
    userId: 732947,
    operator: '陈辉',
    operationTime: '2025-02-10 22:16:12',
    status: '捞取失败'
  },
  {
    id: 72,
    appName: 'loole',
    userId: 5962042,
    operator: '陈辉',
    operationTime: '2025-02-05 18:45:59',
    status: '捞取成功'
  }
]);

/** 搜索按钮操作 */
const handleQuery = () => {
  console.log('查询');
};

/** 重置按钮操作 */
const resetQuery = () => {
  handleQuery();
};

const handleAdd = () => {
  console.log('添加');
};

const handleFetch = (task) => {
  console.log(`点击捞取任务ID: ${task.id}`);
};

const handleDownload = (task) => {
  console.log(`日志下载任务ID: ${task.id}`);
};
</script>

<style scoped>
.task-list-container {
  font-family: Arial, sans-serif;
  padding: 20px;
  background-color: #2c3e50;
  color: white;
}

.page-title {
  font-size: 20px;
  margin-bottom: 20px;
  color: #fff; /* 将颜色改为白色 */
}

.header {
  display: flex;
  justify-content: space-between;
  margin-bottom: 20px;
}

.query-btn,
.add-btn {
  background-color: #3498db;
  color: white;
  border: none;
  border-radius: 5px;
  padding: 10px 20px;
  margin-right: 10px;
  cursor: pointer;
}

.query-btn:hover,
.add-btn:hover {
  background-color: #2980b9;
}

.task-table {
  width: 100%;
  border-collapse: collapse;
}

.task-table th,
.task-table td {
  border: 1px solid #ddd;
  padding: 8px;
  text-align: center;
}

.task-table th {
  background-color: #34495e;
}

.fetch-btn,
.download-btn {
  background-color: #f4f4f4;
  color: #333;
  border: none;
  border-radius: 5px;
  padding: 5px 10px;
  margin: 5px;
  cursor: pointer;
}

.fetch-btn:hover,
.download-btn:hover {
  background-color: #e0e0e0;
}
</style>