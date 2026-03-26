local _M = {}
local jwtVerify = require "jwt_verify"
local ck = require "resty.cookie"

function _M.go()
    -- 获取cookie
    local cookie = ck:new()
    if not cookie then
        ngx.log(ngx.ERR, "cookie is nil")
        return ngx.exit(500)
    end

    local token = cookie:get("accessToken")
    if not token or token == "" then
        -- 记录错误日志
        ngx.log(ngx.ERR, "token is empty")
        -- 返回错误响应
        ngx.header["Status"] = 400
        return ngx.exit(400)
    end

    -- 验证token
    local result = jwtVerify.verifyToken(token)
    if result.verified == false then
        -- 记录错误日志
        ngx.log(ngx.ERR, "token verify failed")
        -- 返回错误响应
        ngx.header["Content-Type"] = "text/plain; charset=utf-8"
        ngx.header["Status"] = 401
        return ngx.exit(401)
    end

    -- 验证成功，添加标识头和用户信息
    ngx.req.set_header("X-Auth-Passed", "true")
    return ngx.exec("@proxy_to_frontend")
end

return _M
