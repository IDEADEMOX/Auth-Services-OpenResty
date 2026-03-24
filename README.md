## 项目介绍

这是一个基于OpenResty的认证服务项目，用于处理用户认证相关的鉴权中间层。

## 项目启动

```bash
./nginx.exe -p `pwd` -c conf/nginx.conf
```

## 项目结构

```
├── conf  # 配置文件目录
│   ├── nginx.conf
├── logs  # 日志目录
│   ├── error.log
├── services  # 服务目录
│   ├── *.lua
```
