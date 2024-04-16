local M = {}

local function get_cmp()
    local cmp_ok, cmp = pcall(require, "cmp")
    return cmp_ok and cmp or {}
end

local function get_ls()
    local ls_ok, ls = pcall(require, "luasnip")
    return ls_ok and ls or {}
end

---@param select_opts? cmp.SelectOption
---@return cmp.Mapping
function M.supertab(select_opts)
    local cmp = get_cmp()
    local ls = get_ls()

    return cmp.mapping(function(fallback)
        local col = vim.fn.col(".") - 1

        if cmp.visible() then
            cmp.select_next_item(select_opts)
        elseif ls.expand_or_jumpable() then
            ls.expand_or_jump()
        elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
            fallback()
        else
            cmp.complete()
        end
    end, { "i", "s" })
end

---@param select_opts? cmp.SelectOption
---@return cmp.Mapping
function M.shift_supertab(select_opts)
    local cmp = get_cmp()
    local ls = get_ls()

    return cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item(select_opts)
        elseif ls.jumpable(-1) then
            ls.jump(-1)
        else
            fallback()
        end
    end, { "i", "s" })
end

---@return cmp.Mapping
function M.jump_backward()
    local cmp = get_cmp()
    local ls = get_ls()

    return cmp.mapping(function(fallback)
        if ls.jumpable(-1) then
            ls.jump(-1)
        else
            fallback()
        end
    end, { "i", "s" })
end

---@return cmp.Mapping
function M.jump_forward()
    local cmp = get_cmp()
    local ls = get_ls()

    return cmp.mapping(function(fallback)
        if ls.jumpable(1) then
            ls.jump(1)
        else
            fallback()
        end
    end, { "i", "s" })
end

return M
