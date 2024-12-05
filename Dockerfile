# 使用官方 Node.js 镜像作为基础镜像
#FROM node:16.20.2-alpine
#
## 设置工作目录
#WORKDIR /app
#
## 复制 package.json 和 package-lock.json (或 yarn.lock)
#COPY package*.json ./
#
## 安装依赖
#RUN npm install
#
## 复制项目文件
#COPY . .
#
## 构建 Vue 项目
#RUN npm run build
#
## 安装 serve 来提供静态文件服务
#RUN npm install -g serve
#
## 启动服务，监听 6000 端口
#CMD ["serve", "-s", "dist", "-l", "6000"]
#
## 暴露 6000 端口
#EXPOSE 6000
