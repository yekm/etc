-- https://github.com/Kagami/mpv_slicing/blob/master/slicing.lua
-- ^^^ inconceivably overengeneered

local msg = require "mp.msg"
local utils = require "mp.utils"

local cut_pos = nil
local copy_audio = true
function timestamp(duration)
    local hours = duration / 3600
    local minutes = duration % 3600 / 60
    local seconds = duration % 60
    return string.format("%02d:%02d:%02.03f", hours, minutes, seconds)
end

function osd(str)
    return mp.osd_message(str, 3)
end

function cut(shift, endpos)

    cmd = table.concat(
        { "/home/yekm/bin/mpv-slice.sh", '"' .. mp.get_property("stream-path") .. '"', shift, endpos - shift},
        " ")
    msg.info(cmd)
    os.execute(cmd)
end

function toggle_mark()
    local pos = mp.get_property_number("time-pos")
    if cut_pos then
        local shift, endpos = cut_pos, pos
        if shift > endpos then
            shift, endpos = endpos, shift
        end
        if shift == endpos then
            osd("Cut fragment is empty")
        else
            cut_pos = nil
            osd(string.format("Cut fragment: %s - %s",
                timestamp(shift),
                timestamp(endpos)))
            cut(shift, endpos)
        end
    else
        cut_pos = pos
        osd(string.format("Marked %s as start position", timestamp(pos)))
    end
end

mp.add_key_binding("c", "slicing_mark", toggle_mark)
