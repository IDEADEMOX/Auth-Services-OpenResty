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

## 配置说明

- 关闭 Lua 缓存，确保每次请求都重新编译 Lua 代码

```nginx
lua_code_cache off;
# off：关闭缓存，on：开启缓存（默认）
# 生产环境建议注释或者开启，避免缓存问题导致的性能问题
```

- 控制 Nginx 是否以守护进程（后台进程）方式运行，默认开启

```nginx
daemon off;
# off：关闭守护进程，on：开启守护进程（默认）
# 开发环境建议关闭，方便调试和监控
```

## 项目结构

```
├── conf  # 配置文件目录
│   ├── nginx.conf
├── logs  # 日志目录（自动生成）
│   ├── error.log
│   ├── access.log
├── services  # 服务目录
│   ├── *.lua
├── package  # 包目录
│   ├── *.lua
├── utils  # 工具目录
│   ├── *.lua
```
