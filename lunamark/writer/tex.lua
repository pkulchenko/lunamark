-- Generic TeX writer for lunamark

local gsub = string.gsub
local entities = require("lunamark.entities")

local TeX = {}

TeX.options = { containers = false }

TeX.sep = { interblock = {compact = "\n\n", default = "\n\n", minimal = "\n\n"},
             container = { compact = "\n", default = "\n", minimal = "\n"}
          }

TeX.interblocksep = TeX.sep.interblock.default

TeX.containersep = TeX.sep.container.default

TeX.linebreak = "\\\\"

TeX.space = " "

local escaped = {
   ["{"] = "\\{",
   ["}"] = "\\}",
   ["$"] = "\\$",
   ["%"] = "\\%",
   ["&"] = "\\&",
   ["_"] = "\\_",
   ["#"] = "\\#",
   ["^"] = "\\^{}",
   ["\\"] = "\\char92{}",
   ["~"] = "\\char126{}",
   ["|"] = "\\char124{}",
   ["<"] = "\\char60{}",
   [">"] = "\\char62{}",
   ["["] = "{[}", -- to avoid interpretation as optional argument
   ["]"] = "{]}",
   ["\160"] = "~",
   ["\0x2018"] = "`",
   ["\0x2019"] = "'",
   ["\0x201C"] = "``",
   ["\0x201D"] = "''",
 }

function TeX.string(s)
  return s:gsub(".",escaped)
end

function TeX.start_document()
  return ""
end

function TeX.stop_document()
  return ""
end

function TeX.inline_html(s)
end

function TeX.display_html(s)
end

function TeX.paragraph(s)
  return s
end

function TeX.plain(s)
  return s
end

local meta = {}
meta.__index =
  function(_, key)
    io.stderr:write(string.format("WARNING: Undefined writer function '%s'\n",key))
    return (function(...) return table.concat(arg," ") end)
  end
setmetatable(TeX, meta)

return TeX
