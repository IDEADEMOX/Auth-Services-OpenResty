local SESSION_SECRET =
"471e9161f714f5621992015f03a876c4e7f8e141aa7806d8867fd62ae21357c713174c44d2556e8b8333c111a3049bee6fa7a6bf84fc17360fa063f74e098952"

local jwt = require "resty.jwt"
local cjson = require "cjson"

local _M = {}

-- 生成token
function _M.generateToken(payload)
    --[[
        {
            header = { typ = "JWT", alg = "HS256" },
            payload = { foo = "bar" }
        }
    ]]
    local jwt_token = jwt:sign(SESSION_SECRET, {
        header = {
            typ = "JWT",
            alg = "HS256" -- 明确指定算法
        },
        payload = payload
    })
    return jwt_token
end

-- 验证token
function _M.verifyToken(token)
    local result, err = jwt:verify(SESSION_SECRET, token)
    ngx.log(ngx.INFO, cjson.encode(result))
    return result, err
end

return _M
