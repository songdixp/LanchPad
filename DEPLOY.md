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
2. 执行makefile命令
   - 打开另外一个终端窗口 cd c2n-contracts
   - make ido

make ido
1. cd c2n-contracts
2. npm i 
3. 配置.env
4. 部署token(奖励token和质押token使用同一个）：npx hardhat run scripts/deployment/deploy_c2n_token.js --network sepolia 
演示token地址
   0x1AC6D55962844659f6290F0a62159318363135b0
5. 更新deploy_farm 参数 startTS，奖励发放开始时间戳
6. 部署farm合约：npx hardhat run scripts/deployment/deploy_farm.js --network sepolia


# 前端部署
1. push 前端代码到github
2. vercel注册账号进行import
3. Framework preset 选择 next.js
4. 选择根目录：c2n-fe
5. 点击deploy
> c2n-fe/src/config/farms.js  进行token的地址设置


前端参数修改，重新build



## 合约部署

合约部署使用 c2n-contracts/Makefile 对合约进行了快速部署，相关业务参数使用了可以快速启动的缺省值
npx hardhat node
make ido

## 后端部署

需要确保在开发环境中安装好 jdk8, maven(3.6.3+) && docker(20.10.17+) 和 docker compose
使用 c2n-be/deploy.sh 完成部署
sh deploy.sh

## 前端部署

前端使用 yarn 进行构建和启动
yarn install
yarn dev
