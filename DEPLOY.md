# 极简部署说明
本工程包含了farm和 ido 两个模块的部署，工程上ido部署包含了 farm的部署。因此本文档主要介绍部署 IDO 的核心步骤。
部署ido分成三个步骤
1. 合约部署
2. 后端部署
3. 前端部署

# 合约部署
合约部署使用 c2n-contracts/scripts/deployment 目录下包含了所有的合约部署脚本。为了部署方便制作了makefile文件，可以看到部署ido的运行脚本就包含了farm流程。
1. 启动本地链,需要配置好.env 以及不需要sepolia的化需要注释掉hardhat.config.ts 的配置
   - cd c2n-contracts 
   - npx hardhat node
   - 配置.env 的PRIVATE_KEY
2. 执行makefile命令
   - 打开另外一个终端窗口 cd c2n-contracts
   - make ido
   看到 ido sale deposited 日志信息（代币生成事件）就代表部署合约成功了。

`补充说明：`
在部署脚本中 const now = Math.round(new Date().getTime() / 1000); 关于时间是做了 Mock 的， 时间设置不对的话部署就会失败。？？？ 这里的失败我查询ds 说是推荐使用ethers.provider.send方法来进行设置区块链的时间。
？？？这个设置时间的逻辑是怎样的？


## 后端部署
- 打开docker
- 进入 c2n-be

## 修改配置文件
cp portal-api.env.example portal-api.env 
配置文件中包含了docker 启动的参数
## 打包后端服务
cd c2n-b2
mvn clean install -Dmaven.test.skip=true
打包好之后的文件会存放到 c2n-be/portal-api/target/目录下

`说明` 需要保证java环境是1.8，并且javac环境保持一致



需要确保在开发环境中安装好 jdk8, maven(3.6.3+) && docker(20.10.17+) 和 docker compose
使用 c2n-be/deploy.sh 完成部署
sh deploy.sh


## 前端部署

前端使用 yarn 进行构建和启动
yarn install
yarn dev
