## 项目介绍

官网：[https://openresty.org](https://openresty.org/cn/)

这是一个基于OpenResty的认证服务项目，用于处理用户认证相关的鉴权中间层。

责任：

- 请求拦截，验证用户 Token 有效性和状态
- 根据用户角色和权限，动态调整访问控制
- 记录认证日志，方便调试和监控

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
