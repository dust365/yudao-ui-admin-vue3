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



echo "步骤 #4 rsync 同步打包产物到线上服务器"
sshpass -p "$SSH_PASSWORD" rsync -avz --delete dist/ $SERVER_USER@$SERVER_HOST:$DEPLOY_DIR
echo "部署完成，文件已上传到服务器"


echo "发布到生产环境完成"
echo "请访问如下地址：8.152.217.4:80"
