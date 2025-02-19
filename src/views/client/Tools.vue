<template>
  <div class="client-tools-page">
    <h1 class="page-title">客户端工具</h1>
    <div class="tools-grid">
      <div v-for="(tool, index) in tools" :key="index" class="tool-card">
        <i :class="tool.icon" class="tool-icon"></i>
        <h2 class="tool-name">{{ tool.name }}</h2>
        <p class="tool-description">{{ tool.description }}</p>
        <button class="tool-button" @click="openTool(tool.url)">打开工具</button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "ClientTools",
  data() {
    return {
      tools: [
        {
          name: "代码编辑器",
          description: "强大的代码编辑工具。",
          icon: "iconfont icon-code",
          url: "https://example.com/code-editor"
        },
        {
          name: "图片处理工具",
          description: "在线图片编辑和处理。",
          icon: "iconfont icon-image",
          url: "https://example.com/image-editor"
        },
        {
          name: "PDF 转换器",
          description: "将文件转换为 PDF 格式。",
          icon: "iconfont icon-pdf",
          url: "https://example.com/pdf-converter"
        },
        {
          name: "压缩工具",
          description: "文件压缩与解压。",
          icon: "iconfont icon-archive",
          url: "https://example.com/compression-tool"
        },
        {
          name: "数据可视化",
          description: "生成图表和数据报告。",
          icon: "iconfont icon-chart",
          url: "https://example.com/data-visualization"
        },
        {
          name: "终端模拟器",
          description: "在线命令行终端模拟器。",
          icon: "iconfont icon-terminal",
          url: "https://example.com/terminal-emulator"
        }
      ]
    };
  },
  methods: {
    openTool(url) {
      if (url) {
        window.open(url, "_blank");
      } else {
        alert("工具链接未配置！");
      }
    }
  }
};
</script>

<style scoped>
.client-tools-page {
  font-family: Arial, sans-serif;
  padding: 20px;
  text-align: center;
}

.page-title {
  font-size: 28px;
  margin-bottom: 20px;
  color: #fff;
}

.tools-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 20px;
  justify-items: center;
}

.tool-card {
  background-color: #333;
  border: 1px solid #444;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  width: 100%;
  max-width: 250px;
  padding: 15px;
  text-align: center;
  transition: transform 0.2s ease-in-out;
}

.tool-card:hover {
  transform: scale(1.05);
}

.tool-icon {
  font-size: 50px;
  color: #fff;
  margin-bottom: 10px;
}

.tool-name {
  font-size: 18px;
  margin: 10px 0;
  color: #fff;
}

.tool-description {
  font-size: 14px;
  color: #ccc;
  margin-bottom: 15px;
}

.tool-button {
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  padding: 8px 16px;
  font-size: 14px;
  cursor: pointer;
  transition: background-color 0.2s ease-in-out;
}

.tool-button:hover {
  background-color: #0056b3;
}
</style>