local _M = {}
local jwtVerify = require "jwt_verify"
local ck = require "resty.cookie"

function _M.go()
    local cookie, err = ck:new()
    if not cookie then
        return ngx.exit(500)
    end

    -- 1. 获取 accessToken
    local access_token = cookie:get("accessToken")
    if not access_token then
        ngx.log(ngx.ERR, "accessToken empty")
        return ngx.exit(400)
    end

    -- 2. 验证 accessToken
    local result = jwtVerify.verifyToken(access_token)
    if result.verified then
        ngx.req.set_header("X-Auth-Passed", "true")
        return ngx.exec("@proxy_to_frontend")
    end

    -- 3. accessToken 失效 → 用 refreshToken
    local refresh_token = cookie:get("refreshToken")
    if not refresh_token then
        ngx.log(ngx.ERR, "refreshToken empty")
        return ngx.exit(400)
    end

    -- 4. 验证 refreshToken 本身
    local refresh_result = jwtVerify.verifyToken(refresh_token)
    if not refresh_result.verified then
        ngx.log(ngx.ERR, "refreshToken verify failed")
        return ngx.exit(401)
    end

    -- 6. 全部验证通过
    ngx.req.set_header("X-Auth-Passed", "true")
    return ngx.exec("@proxy_to_frontend")
end

return _M
