#!/bin/bash

# 修改下面的变量为实际的服务器信息
SERVER_USER="root"
SERVER_HOST="8.152.217.4"
DEPLOY_DIR="/work/projects/yudao-ui-admin"
SSH_PASSWORD="a7TnpNMdYB5@XGd"


echo "步骤 #1 清理 node_modules 和 dist "
rm -rf node_modules
rm -rf dist


# 安装依赖
echo "步骤 #2 安装依赖 "
npm install


echo "步骤 #3 打包开发环境产物"
npm run build:dev
echo "开发环境打包完成"



echo "步骤 #4 rsync 同步到线上服务器"
sshpass -p "$SSH_PASSWORD" rsync -avz --delete dist/ $SERVER_USER@$SERVER_HOST:$DEPLOY_DIR
echo "部署完成，文件已上传到服务器"




# 如果你使用的是其他方式，例如 FTP 或 Docker 部署，可以在此修改相应的命令
# 例如使用 docker 部署，可以在这里加入 Docker 部署步骤：
# docker build -t your-app .
# docker run -d -p 80:80 your-app

# 最后，如果你需要在服务器上启动或重新启动服务，可以添加命令：
# ssh $SERVER_USER@$SERVER_HOST "pm2 restart your-app"  # 假设使用 pm2 管理应用

echo "发布到生产环境完成"
