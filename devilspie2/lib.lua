local M = {}
local NO_FULLSCREEN_FILE = "/usr/local/etc/devilspie2/nofullscreen"

local function no_fullscreen_requested()
    local f = io.open(NO_FULLSCREEN_FILE, "r")
    if f then
        f:close()
        return true
    end
    return false
end

function M.is_normal()
    return get_window_type() == "WINDOW_TYPE_NORMAL"
end

function M.can_fullscreen()
   if no_fullscreen_requested() then
        return false
    end
    local actions = get_window_property('_NET_WM_ALLOWED_ACTIONS') or ""
    return actions:find('_NET_WM_ACTION_MAXIMIZE_HORZ', 1, true)
        and actions:find('_NET_WM_ACTION_MAXIMIZE_VERT', 1, true)
end

function M.is_minimized()
    return get_window_is_minimised()
end

function M.ensure_fullscreen()
    if M.can_fullscreen() and not get_window_fullscreen() then
        set_window_fullscreen(true)
    end
end

function M.anti_minimize()
    if M.is_minimized() then
        if M.is_normal() and get_window_fullscreen() then
            set_window_fullscreen(false)
        end
        unminimize()
        millisleep(30)
        if M.is_minimized() then
            unminimize()
        end
    end
    if M.is_normal() then
        M.ensure_fullscreen()
    end
end

return M
