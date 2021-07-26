local module_info = {_DESCRIPTION = "Fennel-cljlib - functions from Clojure's core.clj implemented on top\nof Fennel.\n\nThis library contains a set of functions providing functions that\nbehave similarly to Clojure's equivalents.  Library itself has nothing\nFennel specific so it should work on Lua, e.g:\n\n``` lua\nLua 5.3.5  Copyright (C) 1994-2018 Lua.org, PUC-Rio\n> clj = require\"cljlib\"\n> table.concat(clj.mapv(function (x) return x * x end, {1, 2, 3}), \" \")\n-- 1 4 9\n```\n\nThis example is mapping an anonymous `function' over a table,\nproducing new table and concatenating it with `\" \"`.\n\nHowever this library also provides Fennel-specific set of\n[macros](./macros.md), that provides additional facilities like\n`defn' or `defmulti' which extend the language allowing writing code\nthat looks and works mostly like Clojure.\n\nEach function in this library is created with `defn', which is a\nspecial macros for creating multi-arity functions.  So when you see\nfunction signature like `(foo [x])`, this means that this is function\n`foo', that accepts exactly one argument `x'.  In contrary, functions\ncreated with `fn' will produce `(foo x)` signature (`x' is not inside\nbrackets).\n\nFunctions, which signatures look like `(foo ([x]) ([x y]) ([x y &\nzs]))`, it is a multi-arity function, which accepts either one, two,\nor three-or-more arguments.  Each `([...])` represents different body\nof a function which is chosen by checking amount of arguments passed\nto the function.  See [Clojure's doc section on multi-arity\nfunctions](https://clojure.org/guides/learn/functions#_multi_arity_functions).\n\n## Compatibility\nThis library is mainly developed with Lua 5.4, and tested against\nLua 5.2, 5.3, 5.4, and LuaJIT 2.1.0-beta3.  Note, that in lua 5.2 and\nLuaJIT equality semantics are a bit different from Lua 5.3 and Lua 5.4.\nMain difference is that when comparing two tables, they must have\nexactly the same `__eq` metamethods, so comparing hash sets with hash\nsets will work, but comparing sets with other tables works only in\nLua5.3+.  Another difference is that Lua 5.2 and LuaJIT don't have\ninbuilt UTF-8 library, therefore `seq' function will not work for\nnon-ASCII strings.", _MODULE_NAME = "cljlib"}
local core = {}
local insert = table.insert
local _unpack = (table.unpack or _G.unpack)
local apply
do
  local function apply0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 2) then
      local _let_0_ = {...}
      local f = _let_0_[1]
      local args = _let_0_[2]
      return f(_unpack(args))
    elseif (len_0_ == 3) then
      local _let_0_ = {...}
      local f = _let_0_[1]
      local a = _let_0_[2]
      local args = _let_0_[3]
      return f(a, _unpack(args))
    elseif (len_0_ == 4) then
      local _let_0_ = {...}
      local f = _let_0_[1]
      local a = _let_0_[2]
      local b = _let_0_[3]
      local args = _let_0_[4]
      return f(a, b, _unpack(args))
    elseif (len_0_ == 5) then
      local _let_0_ = {...}
      local f = _let_0_[1]
      local a = _let_0_[2]
      local b = _let_0_[3]
      local c = _let_0_[4]
      local args = _let_0_[5]
      return f(a, b, c, _unpack(args))
    elseif (len_0_ >= 5) then
      local _let_0_ = {...}
      local f = _let_0_[1]
      local a = _let_0_[2]
      local b = _let_0_[3]
      local c = _let_0_[4]
      local d = _let_0_[5]
      local args = {(table.unpack or unpack)(_let_0_, 6)}
      local flat_args = setmetatable({}, {["cljlib/type"] = "seq"})
      for i = 1, (#args - 1) do
        insert(flat_args, args[i])
      end
      for _, a0 in ipairs(args[#args]) do
        insert(flat_args, a0)
      end
      return f(a, b, c, d, _unpack(flat_args))
    else
      return error("wrong argument amount for apply", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(apply0, "fnl/arglist", {"..."}, "fnl/docstring", "Apply `f' to the argument list formed by prepending intervening\narguments to `args', and `f' must support variadic amount of\narguments.\n\n# Examples\nApplying `add' to different amount of arguments:\n\n``` fennel\n(assert-eq (apply add [1 2 3 4]) 10)\n(assert-eq (apply add 1 [2 3 4]) 10)\n(assert-eq (apply add 1 2 3 4 5 6 [7 8 9]) 45)\n```") end)
  core.apply = apply0
  local value_0_ = core.apply
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"\n  ([f args])", "\n  ([f a args])", "\n  ([f a b args])", "\n  ([f a b c args])", "\n  ([f a b c d & args])"}, ["fnl/docstring"] = "Apply `f' to the argument list formed by prepending intervening\narguments to `args', and `f' must support variadic amount of\narguments.\n\n# Examples\nApplying `add' to different amount of arguments:\n\n``` fennel\n(assert-eq (apply add [1 2 3 4]) 10)\n(assert-eq (apply add 1 [2 3 4]) 10)\n(assert-eq (apply add 1 2 3 4 5 6 [7 8 9]) 45)\n```"}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  apply = value_0_
end
local add
do
  local function add0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      return a
    elseif (len_0_ == 2) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      local b = _let_0_[2]
      return (a + b)
    elseif (len_0_ == 3) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      local b = _let_0_[2]
      local c = _let_0_[3]
      return (a + b + c)
    elseif (len_0_ == 4) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      local b = _let_0_[2]
      local c = _let_0_[3]
      local d = _let_0_[4]
      return (a + b + c + d)
    elseif (len_0_ == 0) then
      local _let_0_ = {...}
      return 0
    elseif (len_0_ >= 4) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      local b = _let_0_[2]
      local c = _let_0_[3]
      local d = _let_0_[4]
      local rest = {(table.unpack or unpack)(_let_0_, 5)}
      return apply(add0, (a + b + c + d), rest)
    end
  end
  pcall(function() require("fennel").metadata:setall(add0, "fnl/arglist", {"..."}, "fnl/docstring", "Sum arbitrary amount of numbers.") end)
  core.add = add0
  local value_0_ = core.add
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"([])", "([a])", "([a b])", "([a b c])", "([a b c d])", "([a b c d & rest])"}, ["fnl/docstring"] = "Sum arbitrary amount of numbers."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  add = value_0_
end
local sub
do
  local function sub0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      return ( - a)
    elseif (len_0_ == 2) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      local b = _let_0_[2]
      return (a - b)
    elseif (len_0_ == 3) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      local b = _let_0_[2]
      local c = _let_0_[3]
      return (a - b - c)
    elseif (len_0_ == 4) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      local b = _let_0_[2]
      local c = _let_0_[3]
      local d = _let_0_[4]
      return (a - b - c - d)
    elseif (len_0_ == 0) then
      local _let_0_ = {...}
      return 0
    elseif (len_0_ >= 4) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      local b = _let_0_[2]
      local c = _let_0_[3]
      local d = _let_0_[4]
      local rest = {(table.unpack or unpack)(_let_0_, 5)}
      return apply(sub0, (a - b - c - d), rest)
    end
  end
  pcall(function() require("fennel").metadata:setall(sub0, "fnl/arglist", {"..."}, "fnl/docstring", "Subtract arbitrary amount of numbers.") end)
  core.sub = sub0
  local value_0_ = core.sub
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"([])", "([a])", "([a b])", "([a b c])", "([a b c d])", "([a b c d & rest])"}, ["fnl/docstring"] = "Subtract arbitrary amount of numbers."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  sub = value_0_
end
local mul
do
  local function mul0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      return a
    elseif (len_0_ == 2) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      local b = _let_0_[2]
      return (a * b)
    elseif (len_0_ == 3) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      local b = _let_0_[2]
      local c = _let_0_[3]
      return (a * b * c)
    elseif (len_0_ == 4) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      local b = _let_0_[2]
      local c = _let_0_[3]
      local d = _let_0_[4]
      return (a * b * c * d)
    elseif (len_0_ == 0) then
      local _let_0_ = {...}
      return 1
    elseif (len_0_ >= 4) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      local b = _let_0_[2]
      local c = _let_0_[3]
      local d = _let_0_[4]
      local rest = {(table.unpack or unpack)(_let_0_, 5)}
      return apply(mul0, (a * b * c * d), rest)
    end
  end
  pcall(function() require("fennel").metadata:setall(mul0, "fnl/arglist", {"..."}, "fnl/docstring", "Multiply arbitrary amount of numbers.") end)
  core.mul = mul0
  local value_0_ = core.mul
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"([])", "([a])", "([a b])", "([a b c])", "([a b c d])", "([a b c d & rest])"}, ["fnl/docstring"] = "Multiply arbitrary amount of numbers."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  mul = value_0_
end
local div
do
  local function div0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      return (1 / a)
    elseif (len_0_ == 2) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      local b = _let_0_[2]
      return (a / b)
    elseif (len_0_ == 3) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      local b = _let_0_[2]
      local c = _let_0_[3]
      return (a / b / c)
    elseif (len_0_ == 4) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      local b = _let_0_[2]
      local c = _let_0_[3]
      local d = _let_0_[4]
      return (a / b / c / d)
    elseif (len_0_ >= 4) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      local b = _let_0_[2]
      local c = _let_0_[3]
      local d = _let_0_[4]
      local rest = {(table.unpack or unpack)(_let_0_, 5)}
      return apply(div0, (a / b / c / d), rest)
    else
      return error("wrong argument amount for div", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(div0, "fnl/arglist", {"..."}, "fnl/docstring", "Divide arbitrary amount of numbers.") end)
  core.div = div0
  local value_0_ = core.div
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"([a])", "([a b])", "([a b c])", "([a b c d])", "([a b c d & rest])"}, ["fnl/docstring"] = "Divide arbitrary amount of numbers."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  div = value_0_
end
local le
do
  local function le0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      return true
    elseif (len_0_ == 2) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      local b = _let_0_[2]
      return (a <= b)
    elseif (len_0_ >= 2) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      local b = _let_0_[2]
      local _let_1_ = {(table.unpack or unpack)(_let_0_, 3)}
      local c = _let_1_[1]
      local d = _let_1_[2]
      local more = {(table.unpack or unpack)(_let_1_, 3)}
      if (a <= b) then
        if d then
          return apply(le0, b, c, d, more)
        else
          return (b <= c)
        end
      else
        return false
      end
    else
      return error("wrong argument amount for le", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(le0, "fnl/arglist", {"..."}, "fnl/docstring", "Returns true if nums are in monotonically non-decreasing order") end)
  core.le = le0
  local value_0_ = core.le
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"([a])", "([a b])", "([a b & [c d & more]])"}, ["fnl/docstring"] = "Returns true if nums are in monotonically non-decreasing order"}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  le = value_0_
end
local lt
do
  local function lt0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      return true
    elseif (len_0_ == 2) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      local b = _let_0_[2]
      return (a < b)
    elseif (len_0_ >= 2) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      local b = _let_0_[2]
      local _let_1_ = {(table.unpack or unpack)(_let_0_, 3)}
      local c = _let_1_[1]
      local d = _let_1_[2]
      local more = {(table.unpack or unpack)(_let_1_, 3)}
      if (a < b) then
        if d then
          return apply(lt0, b, c, d, more)
        else
          return (b < c)
        end
      else
        return false
      end
    else
      return error("wrong argument amount for lt", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(lt0, "fnl/arglist", {"..."}, "fnl/docstring", "Returns true if nums are in monotonically decreasing order") end)
  core.lt = lt0
  local value_0_ = core.lt
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"([a])", "([a b])", "([a b & [c d & more]])"}, ["fnl/docstring"] = "Returns true if nums are in monotonically decreasing order"}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  lt = value_0_
end
local ge
do
  local function ge0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      return true
    elseif (len_0_ == 2) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      local b = _let_0_[2]
      return (a >= b)
    elseif (len_0_ >= 2) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      local b = _let_0_[2]
      local _let_1_ = {(table.unpack or unpack)(_let_0_, 3)}
      local c = _let_1_[1]
      local d = _let_1_[2]
      local more = {(table.unpack or unpack)(_let_1_, 3)}
      if (a >= b) then
        if d then
          return apply(ge0, b, c, d, more)
        else
          return (b >= c)
        end
      else
        return false
      end
    else
      return error("wrong argument amount for ge", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(ge0, "fnl/arglist", {"..."}, "fnl/docstring", "Returns true if nums are in monotonically non-increasing order") end)
  core.ge = ge0
  local value_0_ = core.ge
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"([a])", "([a b])", "([a b & [c d & more]])"}, ["fnl/docstring"] = "Returns true if nums are in monotonically non-increasing order"}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  ge = value_0_
end
local gt
do
  local function gt0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      return true
    elseif (len_0_ == 2) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      local b = _let_0_[2]
      return (a > b)
    elseif (len_0_ >= 2) then
      local _let_0_ = {...}
      local a = _let_0_[1]
      local b = _let_0_[2]
      local _let_1_ = {(table.unpack or unpack)(_let_0_, 3)}
      local c = _let_1_[1]
      local d = _let_1_[2]
      local more = {(table.unpack or unpack)(_let_1_, 3)}
      if (a > b) then
        if d then
          return apply(gt0, b, c, d, more)
        else
          return (b > c)
        end
      else
        return false
      end
    else
      return error("wrong argument amount for gt", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(gt0, "fnl/arglist", {"..."}, "fnl/docstring", "Returns true if nums are in monotonically increasing order") end)
  core.gt = gt0
  local value_0_ = core.gt
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"([a])", "([a b])", "([a b & [c d & more]])"}, ["fnl/docstring"] = "Returns true if nums are in monotonically increasing order"}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  gt = value_0_
end
local inc
do
  local function inc0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local x = _let_0_[1]
      return (x + 1)
    else
      return error("wrong argument amount for inc", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(inc0, "fnl/arglist", {"..."}, "fnl/docstring", "Increase number `x' by one") end)
  core.inc = inc0
  local value_0_ = core.inc
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Increase number `x' by one"}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  inc = value_0_
end
local dec
do
  local function dec0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local x = _let_0_[1]
      return (x - 1)
    else
      return error("wrong argument amount for dec", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(dec0, "fnl/arglist", {"..."}, "fnl/docstring", "Decrease number `x' by one") end)
  core.dec = dec0
  local value_0_ = core.dec
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Decrease number `x' by one"}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  dec = value_0_
end
local utility_doc_order = {"apply", "add", "sub", "mul", "div", "le", "lt", "ge", "gt", "inc", "dec"}
local function fast_table_type(tbl)
  local _0_0 = tbl
  if _0_0 then
    local _1_0 = getmetatable(_0_0)
    if _1_0 then
      return (_1_0)["cljlib/type"]
    else
      return _1_0
    end
  else
    return _0_0
  end
end
pcall(function() require("fennel").metadata:setall(fast_table_type, "fnl/arglist", {"tbl"}) end)
local map_3f
do
  local function map_3f0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local tbl = _let_0_[1]
      if (type(tbl) == "table") then
        local tmp_0_ = fast_table_type(tbl)
        if tmp_0_ then
          local t = tmp_0_
          return (t == "table")
        else
          local k, _ = next(tbl)
          return ((k ~= nil) and (k ~= 1))
        end
      end
    else
      return error("wrong argument amount for map?", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(map_3f0, "fnl/arglist", {"..."}, "fnl/docstring", "Check whether `tbl' is an associative table.\n\nNon empty associative tables are tested for two things:\n- `next' returns the key-value pair,\n- key, that is returned by the `next' is not equal to `1`.\n\nEmpty tables can't be analyzed with this method, and `map?' will\nreturn `false'.  If you need this test pass for empty table, see\n`hash-map' for creating tables that have additional\nmetadata attached for this test to work.\n\n# Examples\nNon empty tables:\n\n``` fennel\n(assert-is (map? {:a 1 :b 2}))\n\n(local some-table {:key :value})\n(assert-is (map? some-table))\n```\n\nEmpty tables:\n\n``` fennel\n(local some-table {})\n(assert-not (map? some-table))\n```\n\nEmpty tables created with `hash-map' will pass the test:\n\n``` fennel\n(local some-table (hash-map))\n(assert-is (map? some-table))\n```") end)
  core["map?"] = map_3f0
  local value_0_ = core["map?"]
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[tbl]"}, ["fnl/docstring"] = "Check whether `tbl' is an associative table.\n\nNon empty associative tables are tested for two things:\n- `next' returns the key-value pair,\n- key, that is returned by the `next' is not equal to `1`.\n\nEmpty tables can't be analyzed with this method, and `map?' will\nreturn `false'.  If you need this test pass for empty table, see\n`hash-map' for creating tables that have additional\nmetadata attached for this test to work.\n\n# Examples\nNon empty tables:\n\n``` fennel\n(assert-is (map? {:a 1 :b 2}))\n\n(local some-table {:key :value})\n(assert-is (map? some-table))\n```\n\nEmpty tables:\n\n``` fennel\n(local some-table {})\n(assert-not (map? some-table))\n```\n\nEmpty tables created with `hash-map' will pass the test:\n\n``` fennel\n(local some-table (hash-map))\n(assert-is (map? some-table))\n```"}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  map_3f = value_0_
end
local vector_3f
do
  local function vector_3f0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local tbl = _let_0_[1]
      if (type(tbl) == "table") then
        local tmp_0_ = fast_table_type(tbl)
        if tmp_0_ then
          local t = tmp_0_
          return (t == "seq")
        else
          local k, _ = next(tbl)
          return ((k ~= nil) and (k == 1))
        end
      end
    else
      return error("wrong argument amount for vector?", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(vector_3f0, "fnl/arglist", {"..."}, "fnl/docstring", "Check whether `tbl' is an sequential table.\n\nNon empty sequential tables are tested for two things:\n- `next' returns the key-value pair,\n- key, that is returned by the `next' is equal to `1`.\n\nEmpty tables can't be analyzed with this method, and `vector?' will\nalways return `false'.  If you need this test pass for empty table,\nsee `vector' for creating tables that have additional\nmetadata attached for this test to work.\n\n# Examples\nNon empty vector:\n\n``` fennel\n(assert-is (vector? [1 2 3 4]))\n\n(local some-table [1 2 3])\n(assert-is (vector? some-table))\n```\n\nEmpty tables:\n\n``` fennel\n(local some-table [])\n(assert-not (vector? some-table))\n```\n\nEmpty tables created with `vector' will pass the test:\n\n``` fennel\n(local some-table (vector))\n(assert-is (vector? some-table))\n```") end)
  core["vector?"] = vector_3f0
  local value_0_ = core["vector?"]
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[tbl]"}, ["fnl/docstring"] = "Check whether `tbl' is an sequential table.\n\nNon empty sequential tables are tested for two things:\n- `next' returns the key-value pair,\n- key, that is returned by the `next' is equal to `1`.\n\nEmpty tables can't be analyzed with this method, and `vector?' will\nalways return `false'.  If you need this test pass for empty table,\nsee `vector' for creating tables that have additional\nmetadata attached for this test to work.\n\n# Examples\nNon empty vector:\n\n``` fennel\n(assert-is (vector? [1 2 3 4]))\n\n(local some-table [1 2 3])\n(assert-is (vector? some-table))\n```\n\nEmpty tables:\n\n``` fennel\n(local some-table [])\n(assert-not (vector? some-table))\n```\n\nEmpty tables created with `vector' will pass the test:\n\n``` fennel\n(local some-table (vector))\n(assert-is (vector? some-table))\n```"}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  vector_3f = value_0_
end
local multifn_3f
do
  local function multifn_3f0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local mf = _let_0_[1]
      return (((getmetatable(mf) or {}))["cljlib/type"] == "multifn")
    else
      return error("wrong argument amount for multifn?", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(multifn_3f0, "fnl/arglist", {"..."}, "fnl/docstring", "Test if `mf' is an instance of `multifn'.\n\n`multifn' is a special kind of table, created with `defmulti' macros\nfrom `macros.fnl'.") end)
  core["multifn?"] = multifn_3f0
  local value_0_ = core["multifn?"]
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[mf]"}, ["fnl/docstring"] = "Test if `mf' is an instance of `multifn'.\n\n`multifn' is a special kind of table, created with `defmulti' macros\nfrom `macros.fnl'."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  multifn_3f = value_0_
end
local set_3f
do
  local function set_3f0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local s = _let_0_[1]
      local _0_0 = ((getmetatable(s) or {}))["cljlib/type"]
      if (_0_0 == "cljlib/ordered-set") then
        return "cljlib/ordered-set"
      elseif (_0_0 == "cljlib/hash-set") then
        return "cljlib/hash-set"
      else
        local _ = _0_0
        return false
      end
    else
      return error("wrong argument amount for set?", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(set_3f0, "fnl/arglist", {"..."}, "fnl/docstring", "Test if `s` is either instance of a `hash-set' or `ordered-set'.") end)
  core["set?"] = set_3f0
  local value_0_ = core["set?"]
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[s]"}, ["fnl/docstring"] = "Test if `s` is either instance of a `hash-set' or `ordered-set'."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  set_3f = value_0_
end
local nil_3f
do
  local function nil_3f0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local x = _let_0_[1]
      return (x == nil)
    elseif (len_0_ == 0) then
      local _let_0_ = {...}
      return true
    else
      return error("wrong argument amount for nil?", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(nil_3f0, "fnl/arglist", {"..."}, "fnl/docstring", "Test if `x' is nil.") end)
  core["nil?"] = nil_3f0
  local value_0_ = core["nil?"]
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"([])", "([x])"}, ["fnl/docstring"] = "Test if `x' is nil."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  nil_3f = value_0_
end
local zero_3f
do
  local function zero_3f0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local x = _let_0_[1]
      return (x == 0)
    else
      return error("wrong argument amount for zero?", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(zero_3f0, "fnl/arglist", {"..."}, "fnl/docstring", "Test if `x' is equal to zero.") end)
  core["zero?"] = zero_3f0
  local value_0_ = core["zero?"]
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Test if `x' is equal to zero."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  zero_3f = value_0_
end
local pos_3f
do
  local function pos_3f0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local x = _let_0_[1]
      return (x > 0)
    else
      return error("wrong argument amount for pos?", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(pos_3f0, "fnl/arglist", {"..."}, "fnl/docstring", "Test if `x' is greater than zero.") end)
  core["pos?"] = pos_3f0
  local value_0_ = core["pos?"]
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Test if `x' is greater than zero."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  pos_3f = value_0_
end
local neg_3f
do
  local function neg_3f0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local x = _let_0_[1]
      return (x < 0)
    else
      return error("wrong argument amount for neg?", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(neg_3f0, "fnl/arglist", {"..."}, "fnl/docstring", "Test if `x' is less than zero.") end)
  core["neg?"] = neg_3f0
  local value_0_ = core["neg?"]
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Test if `x' is less than zero."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  neg_3f = value_0_
end
local even_3f
do
  local function even_3f0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local x = _let_0_[1]
      return ((x % 2) == 0)
    else
      return error("wrong argument amount for even?", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(even_3f0, "fnl/arglist", {"..."}, "fnl/docstring", "Test if `x' is even.") end)
  core["even?"] = even_3f0
  local value_0_ = core["even?"]
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Test if `x' is even."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  even_3f = value_0_
end
local odd_3f
do
  local function odd_3f0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local x = _let_0_[1]
      return not even_3f(x)
    else
      return error("wrong argument amount for odd?", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(odd_3f0, "fnl/arglist", {"..."}, "fnl/docstring", "Test if `x' is odd.") end)
  core["odd?"] = odd_3f0
  local value_0_ = core["odd?"]
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Test if `x' is odd."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  odd_3f = value_0_
end
local string_3f
do
  local function string_3f0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local x = _let_0_[1]
      return (type(x) == "string")
    else
      return error("wrong argument amount for string?", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(string_3f0, "fnl/arglist", {"..."}, "fnl/docstring", "Test if `x' is a string.") end)
  core["string?"] = string_3f0
  local value_0_ = core["string?"]
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Test if `x' is a string."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  string_3f = value_0_
end
local boolean_3f
do
  local function boolean_3f0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local x = _let_0_[1]
      return (type(x) == "boolean")
    else
      return error("wrong argument amount for boolean?", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(boolean_3f0, "fnl/arglist", {"..."}, "fnl/docstring", "Test if `x' is a Boolean") end)
  core["boolean?"] = boolean_3f0
  local value_0_ = core["boolean?"]
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Test if `x' is a Boolean"}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  boolean_3f = value_0_
end
local true_3f
do
  local function true_3f0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local x = _let_0_[1]
      return (x == true)
    else
      return error("wrong argument amount for true?", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(true_3f0, "fnl/arglist", {"..."}, "fnl/docstring", "Test if `x' is `true'") end)
  core["true?"] = true_3f0
  local value_0_ = core["true?"]
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Test if `x' is `true'"}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  true_3f = value_0_
end
local false_3f
do
  local function false_3f0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local x = _let_0_[1]
      return (x == false)
    else
      return error("wrong argument amount for false?", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(false_3f0, "fnl/arglist", {"..."}, "fnl/docstring", "Test if `x' is `false'") end)
  core["false?"] = false_3f0
  local value_0_ = core["false?"]
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Test if `x' is `false'"}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  false_3f = value_0_
end
local int_3f
do
  local function int_3f0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local x = _let_0_[1]
      return ((type(x) == "number") and (x == math.floor(x)))
    else
      return error("wrong argument amount for int?", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(int_3f0, "fnl/arglist", {"..."}, "fnl/docstring", "Test if `x' is a number without floating point data.\n\nNumber is rounded with `math.floor' and compared with original number.") end)
  core["int?"] = int_3f0
  local value_0_ = core["int?"]
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Test if `x' is a number without floating point data.\n\nNumber is rounded with `math.floor' and compared with original number."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  int_3f = value_0_
end
local pos_int_3f
do
  local function pos_int_3f0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local x = _let_0_[1]
      return (int_3f(x) and pos_3f(x))
    else
      return error("wrong argument amount for pos-int?", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(pos_int_3f0, "fnl/arglist", {"..."}, "fnl/docstring", "Test if `x' is a positive integer.") end)
  core["pos-int?"] = pos_int_3f0
  local value_0_ = core["pos-int?"]
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Test if `x' is a positive integer."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  pos_int_3f = value_0_
end
local neg_int_3f
do
  local function neg_int_3f0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local x = _let_0_[1]
      return (int_3f(x) and neg_3f(x))
    else
      return error("wrong argument amount for neg-int?", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(neg_int_3f0, "fnl/arglist", {"..."}, "fnl/docstring", "Test if `x' is a negative integer.") end)
  core["neg-int?"] = neg_int_3f0
  local value_0_ = core["neg-int?"]
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Test if `x' is a negative integer."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  neg_int_3f = value_0_
end
local double_3f
do
  local function double_3f0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local x = _let_0_[1]
      return ((type(x) == "number") and (x ~= math.floor(x)))
    else
      return error("wrong argument amount for double?", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(double_3f0, "fnl/arglist", {"..."}, "fnl/docstring", "Test if `x' is a number with floating point data.") end)
  core["double?"] = double_3f0
  local value_0_ = core["double?"]
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Test if `x' is a number with floating point data."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  double_3f = value_0_
end
local empty_3f
do
  local function empty_3f0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local x = _let_0_[1]
      local _0_0 = type(x)
      if (_0_0 == "table") then
        return (next(x) == nil)
      elseif (_0_0 == "string") then
        return (x == "")
      else
        local _ = _0_0
        return error("empty?: unsupported collection")
      end
    else
      return error("wrong argument amount for empty?", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(empty_3f0, "fnl/arglist", {"..."}, "fnl/docstring", "Check if collection is empty.") end)
  core["empty?"] = empty_3f0
  local value_0_ = core["empty?"]
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Check if collection is empty."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  empty_3f = value_0_
end
local not_empty
do
  local function not_empty0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local x = _let_0_[1]
      if not empty_3f(x) then
        return x
      end
    else
      return error("wrong argument amount for not-empty", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(not_empty0, "fnl/arglist", {"..."}, "fnl/docstring", "If `x' is empty, returns `nil', otherwise `x'.") end)
  core["not-empty"] = not_empty0
  local value_0_ = core["not-empty"]
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "If `x' is empty, returns `nil', otherwise `x'."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  not_empty = value_0_
end
local predicate_doc_order = {"map?", "vector?", "multifn?", "set?", "nil?", "zero?", "pos?", "neg?", "even?", "odd?", "string?", "boolean?", "true?", "false?", "int?", "pos-int?", "neg-int?", "double?", "empty?", "not-empty"}
local vector
do
  local function vector0(...)
    local len_0_ = select("#", ...)
    if (len_0_ >= 0) then
      local _let_0_ = {...}
      local args = {(table.unpack or unpack)(_let_0_, 1)}
      return setmetatable(args, {["cljlib/type"] = "seq"})
    end
  end
  pcall(function() require("fennel").metadata:setall(vector0, "fnl/arglist", {"..."}, "fnl/docstring", "Constructs sequential table out of it's arguments.\n\nSets additional metadata for function `vector?' to work.\n\n# Examples\n\n``` fennel\n(local v (vector 1 2 3 4))\n(assert-eq v [1 2 3 4])\n```") end)
  core.vector = vector0
  local value_0_ = core.vector
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[&", "args]"}, ["fnl/docstring"] = "Constructs sequential table out of it's arguments.\n\nSets additional metadata for function `vector?' to work.\n\n# Examples\n\n``` fennel\n(local v (vector 1 2 3 4))\n(assert-eq v [1 2 3 4])\n```"}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  vector = value_0_
end
local seq
do
  local function seq0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local col = _let_0_[1]
      local res = setmetatable({}, {["cljlib/type"] = "seq"})
      local _0_0 = type(col)
      if (_0_0 == "table") then
        local m = (getmetatable(col) or {})
        local tmp_0_ = (m["cljlib/next"] or next)(col)
        if (tmp_0_ == nil) then
          return nil
        else
          local _ = tmp_0_
          local assoc_3f = false
          local assoc_res = setmetatable({}, {["cljlib/type"] = "seq"})
          for k, v in pairs(col) do
            if (not assoc_3f and map_3f(col)) then
              assoc_3f = true
            end
            insert(res, v)
            insert(assoc_res, {k, v})
          end
          if assoc_3f then
            return assoc_res
          else
            return res
          end
        end
      elseif (_0_0 == "string") then
        if _G.utf8 then
          local char = _G.utf8.char
          for _, b in _G.utf8.codes(col) do
            insert(res, char(b))
          end
          return res
        else
          (io.stderr):write("WARNING: utf8 module unavailable, seq function will not work for non-unicode strings\n")
          for b in col:gmatch(".") do
            insert(res, b)
          end
          return res
        end
      elseif (_0_0 == "nil") then
        return nil
      else
        local _ = _0_0
        return error(("expected table, string or nil, got " .. type(col)), 2)
      end
    else
      return error("wrong argument amount for seq", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(seq0, "fnl/arglist", {"..."}, "fnl/docstring", "Create sequential table.\n\nTransforms original table to sequential table of key value pairs\nstored as sequential tables in linear time.  If `col' is an\nassociative table, returns sequential table of vectors with key and\nvalue.  If `col' is sequential table, returns its shallow copy.  If\n`col' is string, return sequential table of its codepoints.\n\n# Examples\nSequential tables remain as is:\n\n``` fennel\n(seq [1 2 3 4])\n;; [1 2 3 4]\n```\n\nAssociative tables are transformed to format like this `[[key1 value1]\n... [keyN valueN]]` and order is non deterministic:\n\n``` fennel\n(seq {:a 1 :b 2 :c 3})\n;; [[:b 2] [:a 1] [:c 3]]\n```\n\nSee `into' macros for transforming this back to associative table.\nAdditionally you can use `conj' and `apply' with\n`hash-map':\n\n``` fennel\n(apply conj (hash-map) [:c 3] [[:a 1] [:b 2]])\n;; => {:a 1 :b 2 :c 3}\n```") end)
  core.seq = seq0
  local value_0_ = core.seq
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[col]"}, ["fnl/docstring"] = "Create sequential table.\n\nTransforms original table to sequential table of key value pairs\nstored as sequential tables in linear time.  If `col' is an\nassociative table, returns sequential table of vectors with key and\nvalue.  If `col' is sequential table, returns its shallow copy.  If\n`col' is string, return sequential table of its codepoints.\n\n# Examples\nSequential tables remain as is:\n\n``` fennel\n(seq [1 2 3 4])\n;; [1 2 3 4]\n```\n\nAssociative tables are transformed to format like this `[[key1 value1]\n... [keyN valueN]]` and order is non deterministic:\n\n``` fennel\n(seq {:a 1 :b 2 :c 3})\n;; [[:b 2] [:a 1] [:c 3]]\n```\n\nSee `into' macros for transforming this back to associative table.\nAdditionally you can use `conj' and `apply' with\n`hash-map':\n\n``` fennel\n(apply conj (hash-map) [:c 3] [[:a 1] [:b 2]])\n;; => {:a 1 :b 2 :c 3}\n```"}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  seq = value_0_
end
local kvseq
do
  local function kvseq0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local col = _let_0_[1]
      local res = setmetatable({}, {["cljlib/type"] = "seq"})
      local _0_0 = type(col)
      if (_0_0 == "table") then
        local m = (getmetatable(col) or {})
        local tmp_0_ = (m["cljlib/next"] or next)(col)
        if (tmp_0_ == nil) then
          return nil
        else
          local _ = tmp_0_
          for k, v in pairs(col) do
            insert(res, {k, v})
          end
          return res
        end
      elseif (_0_0 == "string") then
        if _G.utf8 then
          local char = _G.utf8.char
          for i, b in _G.utf8.codes(col) do
            insert(res, {i, char(b)})
          end
          return res
        else
          (io.stderr):write("WARNING: utf8 module unavailable, seq function will not work for non-unicode strings\n")
          for i = 1, #col do
            insert(res, {i, col:sub(i, i)})
          end
          return res
        end
      elseif (_0_0 == "nil") then
        return nil
      else
        local _ = _0_0
        return error(("expected table, string or nil, got " .. type(col)), 2)
      end
    else
      return error("wrong argument amount for kvseq", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(kvseq0, "fnl/arglist", {"..."}, "fnl/docstring", "Transforms any table `col' to key-value sequence.") end)
  core.kvseq = kvseq0
  local value_0_ = core.kvseq
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[col]"}, ["fnl/docstring"] = "Transforms any table `col' to key-value sequence."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  kvseq = value_0_
end
local first
do
  local function first0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local col = _let_0_[1]
      local tmp_0_ = seq(col)
      if (tmp_0_ == nil) then
        return nil
      else
        local col0 = tmp_0_
        return (col0)[1]
      end
    else
      return error("wrong argument amount for first", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(first0, "fnl/arglist", {"..."}, "fnl/docstring", "Return first element of a table. Calls `seq' on its argument.") end)
  core.first = first0
  local value_0_ = core.first
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[col]"}, ["fnl/docstring"] = "Return first element of a table. Calls `seq' on its argument."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  first = value_0_
end
local rest
do
  local function rest0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local col = _let_0_[1]
      local tmp_0_ = seq(col)
      if (tmp_0_ == nil) then
        return setmetatable({}, {["cljlib/type"] = "seq"})
      else
        local col0 = tmp_0_
        return vector(_unpack(col0, 2))
      end
    else
      return error("wrong argument amount for rest", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(rest0, "fnl/arglist", {"..."}, "fnl/docstring", "Returns table of all elements of a table but the first one. Calls\n  `seq' on its argument.") end)
  core.rest = rest0
  local value_0_ = core.rest
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[col]"}, ["fnl/docstring"] = "Returns table of all elements of a table but the first one. Calls\n  `seq' on its argument."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  rest = value_0_
end
local last
do
  local function last0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local col = _let_0_[1]
      local tmp_0_ = seq(col)
      if (tmp_0_ == nil) then
        return nil
      else
        local col0 = tmp_0_
        local i, v = next(col0)
        while i do
          local _i, _v = next(col0, i)
          if _i then
            v = _v
          end
          i = _i
        end
        return v
      end
    else
      return error("wrong argument amount for last", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(last0, "fnl/arglist", {"..."}, "fnl/docstring", "Returns the last element of a table. Calls `seq' on its argument.") end)
  core.last = last0
  local value_0_ = core.last
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[col]"}, ["fnl/docstring"] = "Returns the last element of a table. Calls `seq' on its argument."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  last = value_0_
end
local butlast
do
  local function butlast0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local col = _let_0_[1]
      local tmp_0_ = seq(col)
      if (tmp_0_ == nil) then
        return nil
      else
        local col0 = tmp_0_
        table.remove(col0, #col0)
        if not empty_3f(col0) then
          return col0
        end
      end
    else
      return error("wrong argument amount for butlast", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(butlast0, "fnl/arglist", {"..."}, "fnl/docstring", "Returns everything but the last element of a table as a new\n  table. Calls `seq' on its argument.") end)
  core.butlast = butlast0
  local value_0_ = core.butlast
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[col]"}, ["fnl/docstring"] = "Returns everything but the last element of a table as a new\n  table. Calls `seq' on its argument."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  butlast = value_0_
end
local conj
do
  local function conj0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local tbl = _let_0_[1]
      return tbl
    elseif (len_0_ == 2) then
      local _let_0_ = {...}
      local tbl = _let_0_[1]
      local x = _let_0_[2]
      do
        local tmp_0_ = x
        if (tmp_0_ == nil) then
        else
          local x0 = tmp_0_
          local tbl0 = (tbl or setmetatable({}, {["cljlib/type"] = "seq"}))
          if map_3f(tbl0) then
            tbl0[(x0)[1]] = (x0)[2]
          else
            tbl0[(1 + #tbl0)] = x0
          end
        end
      end
      return tbl
    elseif (len_0_ == 0) then
      local _let_0_ = {...}
      return setmetatable({}, {["cljlib/type"] = "seq"})
    elseif (len_0_ >= 2) then
      local _let_0_ = {...}
      local tbl = _let_0_[1]
      local x = _let_0_[2]
      local xs = {(table.unpack or unpack)(_let_0_, 3)}
      return apply(conj0, conj0(tbl, x), xs)
    end
  end
  pcall(function() require("fennel").metadata:setall(conj0, "fnl/arglist", {"..."}, "fnl/docstring", "Insert `x' as a last element of a table `tbl'.\n\nIf `tbl' is a sequential table or empty table, inserts `x' and\noptional `xs' as final element in the table.\n\nIf `tbl' is an associative table, that satisfies `map?' test,\ninsert `[key value]` pair into the table.\n\nMutates `tbl'.\n\n# Examples\nAdding to sequential tables:\n\n``` fennel\n(conj [] 1 2 3 4)\n;; => [1 2 3 4]\n(conj [1 2 3] 4 5)\n;; => [1 2 3 4 5]\n```\n\nAdding to associative tables:\n\n``` fennel\n(conj {:a 1} [:b 2] [:c 3])\n;; => {:a 1 :b 2 :c 3}\n```\n\nNote, that passing literal empty associative table `{}` will not work:\n\n``` fennel\n(conj {} [:a 1] [:b 2])\n;; => [[:a 1] [:b 2]]\n(conj (hash-map) [:a 1] [:b 2])\n;; => {:a 1 :b 2}\n```\n\nSee `hash-map' for creating empty associative tables.") end)
  core.conj = conj0
  local value_0_ = core.conj
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"([])", "([tbl])", "([tbl x])", "([tbl x & xs])"}, ["fnl/docstring"] = "Insert `x' as a last element of a table `tbl'.\n\nIf `tbl' is a sequential table or empty table, inserts `x' and\noptional `xs' as final element in the table.\n\nIf `tbl' is an associative table, that satisfies `map?' test,\ninsert `[key value]` pair into the table.\n\nMutates `tbl'.\n\n# Examples\nAdding to sequential tables:\n\n``` fennel\n(conj [] 1 2 3 4)\n;; => [1 2 3 4]\n(conj [1 2 3] 4 5)\n;; => [1 2 3 4 5]\n```\n\nAdding to associative tables:\n\n``` fennel\n(conj {:a 1} [:b 2] [:c 3])\n;; => {:a 1 :b 2 :c 3}\n```\n\nNote, that passing literal empty associative table `{}` will not work:\n\n``` fennel\n(conj {} [:a 1] [:b 2])\n;; => [[:a 1] [:b 2]]\n(conj (hash-map) [:a 1] [:b 2])\n;; => {:a 1 :b 2}\n```\n\nSee `hash-map' for creating empty associative tables."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  conj = value_0_
end
local disj
do
  local function disj0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local s = _let_0_[1]
      if set_3f(s) then
        return s
      else
        return error("expected either hash-set or ordered-set as first argument", 2)
      end
    elseif (len_0_ == 2) then
      local _let_0_ = {...}
      local s = _let_0_[1]
      local k = _let_0_[2]
      if set_3f(s) then
        local _0_0 = s
        _0_0[k] = nil
        return _0_0
      else
        return error("expected either hash-set or ordered-set as first argument", 2)
      end
    elseif (len_0_ >= 2) then
      local _let_0_ = {...}
      local s = _let_0_[1]
      local k = _let_0_[2]
      local ks = {(table.unpack or unpack)(_let_0_, 3)}
      return apply(disj0, disj0(s, k), ks)
    else
      return error("wrong argument amount for disj", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(disj0, "fnl/arglist", {"..."}, "fnl/docstring", "Remove key `k' from set `s'.") end)
  core.disj = disj0
  local value_0_ = core.disj
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"([s])", "([s k])", "([s k & ks])"}, ["fnl/docstring"] = "Remove key `k' from set `s'."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  disj = value_0_
end
local function consj(...)
  local _let_0_ = {...}
  local tbl = _let_0_[1]
  local x = _let_0_[2]
  local xs = {(table.unpack or unpack)(_let_0_, 3)}
  if nil_3f(x) then
    return tbl
  else
    local _1_
    do
      local _0_0 = tbl
      insert(_0_0, 1, x)
      _1_ = _0_0
    end
    return consj(_1_, _unpack(xs))
  end
end
pcall(function() require("fennel").metadata:setall(consj, "fnl/arglist", {"..."}, "fnl/docstring", "Like conj but joins at the front. Modifies `tbl'.") end)
local cons
do
  local function cons0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 2) then
      local _let_0_ = {...}
      local x = _let_0_[1]
      local tbl = _let_0_[2]
      local tmp_0_ = x
      if (tmp_0_ == nil) then
        return tbl
      else
        local x0 = tmp_0_
        local _0_0 = (seq(tbl) or setmetatable({}, {["cljlib/type"] = "seq"}))
        insert(_0_0, 1, x0)
        return _0_0
      end
    else
      return error("wrong argument amount for cons", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(cons0, "fnl/arglist", {"..."}, "fnl/docstring", "Insert `x' to `tbl' at the front.  Calls `seq' on `tbl'.") end)
  core.cons = cons0
  local value_0_ = core.cons
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[x", "tbl]"}, ["fnl/docstring"] = "Insert `x' to `tbl' at the front.  Calls `seq' on `tbl'."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  cons = value_0_
end
local concat
do
  local function concat0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local x = _let_0_[1]
      return (seq(x) or setmetatable({}, {["cljlib/type"] = "seq"}))
    elseif (len_0_ == 2) then
      local _let_0_ = {...}
      local x = _let_0_[1]
      local y = _let_0_[2]
      local to = (seq(x) or setmetatable({}, {["cljlib/type"] = "seq"}))
      local from = (seq(y) or setmetatable({}, {["cljlib/type"] = "seq"}))
      for _, v in ipairs(from) do
        insert(to, v)
      end
      return to
    elseif (len_0_ == 0) then
      local _let_0_ = {...}
      return nil
    elseif (len_0_ >= 2) then
      local _let_0_ = {...}
      local x = _let_0_[1]
      local y = _let_0_[2]
      local xs = {(table.unpack or unpack)(_let_0_, 3)}
      return apply(concat0, concat0(x, y), xs)
    end
  end
  pcall(function() require("fennel").metadata:setall(concat0, "fnl/arglist", {"..."}, "fnl/docstring", "Concatenate tables.") end)
  core.concat = concat0
  local value_0_ = core.concat
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"([])", "([x])", "([x y])", "([x y & xs])"}, ["fnl/docstring"] = "Concatenate tables."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  concat = value_0_
end
local reduce
do
  local function reduce0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 2) then
      local _let_0_ = {...}
      local f = _let_0_[1]
      local col = _let_0_[2]
      local col0 = (seq(col) or setmetatable({}, {["cljlib/type"] = "seq"}))
      local _0_0 = #col0
      if (_0_0 == 0) then
        return f()
      elseif (_0_0 == 1) then
        return (col0)[1]
      elseif (_0_0 == 2) then
        return f((col0)[1], (col0)[2])
      else
        local _ = _0_0
        local _let_1_ = col0
        local a = _let_1_[1]
        local b = _let_1_[2]
        local rest0 = {(table.unpack or unpack)(_let_1_, 3)}
        return reduce0(f, f(a, b), rest0)
      end
    elseif (len_0_ == 3) then
      local _let_0_ = {...}
      local f = _let_0_[1]
      local val = _let_0_[2]
      local col = _let_0_[3]
      local m = getmetatable(val)
      if (m and m["cljlib/reduced"] and (m["cljlib/reduced"].status == "ready")) then
        return m["cljlib/reduced"].val
      else
        local col0 = (seq(col) or setmetatable({}, {["cljlib/type"] = "seq"}))
        local _let_1_ = col0
        local x = _let_1_[1]
        local xs = {(table.unpack or unpack)(_let_1_, 2)}
        if nil_3f(x) then
          return val
        else
          return reduce0(f, f(val, x), xs)
        end
      end
    else
      return error("wrong argument amount for reduce", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(reduce0, "fnl/arglist", {"..."}, "fnl/docstring", "Reduce collection `col' using function `f' and optional initial value `val'.\n\n`f' should be a function of 2 arguments.  If val is not supplied,\nreturns the result of applying f to the first 2 items in coll, then\napplying f to that result and the 3rd item, etc.  If coll contains no\nitems, f must accept no arguments as well, and reduce returns the\nresult of calling f with no arguments.  If coll has only 1 item, it is\nreturned and f is not called.  If val is supplied, returns the result\nof applying f to val and the first item in coll, then applying f to\nthat result and the 2nd item, etc.  If coll contains no items, returns\nval and f is not called.  Calls `seq' on `col'.\n\nEarly termination is possible with the use of `reduced'\nfunction.\n\n# Examples\nReduce sequence of numbers with `add'\n\n``` fennel\n(reduce add [1 2 3 4])\n;; => 10\n(reduce add 10 [1 2 3 4])\n;; => 20\n```") end)
  core.reduce = reduce0
  local value_0_ = core.reduce
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"([f col])", "([f val col])"}, ["fnl/docstring"] = "Reduce collection `col' using function `f' and optional initial value `val'.\n\n`f' should be a function of 2 arguments.  If val is not supplied,\nreturns the result of applying f to the first 2 items in coll, then\napplying f to that result and the 3rd item, etc.  If coll contains no\nitems, f must accept no arguments as well, and reduce returns the\nresult of calling f with no arguments.  If coll has only 1 item, it is\nreturned and f is not called.  If val is supplied, returns the result\nof applying f to val and the first item in coll, then applying f to\nthat result and the 2nd item, etc.  If coll contains no items, returns\nval and f is not called.  Calls `seq' on `col'.\n\nEarly termination is possible with the use of `reduced'\nfunction.\n\n# Examples\nReduce sequence of numbers with `add'\n\n``` fennel\n(reduce add [1 2 3 4])\n;; => 10\n(reduce add 10 [1 2 3 4])\n;; => 20\n```"}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  reduce = value_0_
end
local reduced
do
  local function reduced0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local x = _let_0_[1]
      return setmetatable({}, {["cljlib/reduced"] = {status = "ready", val = x}})
    else
      return error("wrong argument amount for reduced", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(reduced0, "fnl/arglist", {"..."}, "fnl/docstring", "Wraps `x' in such a way so `reduce' will terminate early\nwith this value.\n\n# Examples\nStop reduction is result is higher than `10`:\n\n``` fennel\n(reduce (fn [res x]\n          (if (>= res 10)\n              (reduced res)\n              (+ res x)))\n        [1 2 3])\n;; => 6\n\n(reduce (fn [res x]\n          (if (>= res 10)\n              (reduced res)\n              (+ res x)))\n        [1 2 3 4 :nil])\n;; => 10\n```\n\nNote that in second example we had `:nil` in the array, which is not a\nvalid number, but we've terminated right before we've reached it.") end)
  core.reduced = reduced0
  local value_0_ = core.reduced
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Wraps `x' in such a way so `reduce' will terminate early\nwith this value.\n\n# Examples\nStop reduction is result is higher than `10`:\n\n``` fennel\n(reduce (fn [res x]\n          (if (>= res 10)\n              (reduced res)\n              (+ res x)))\n        [1 2 3])\n;; => 6\n\n(reduce (fn [res x]\n          (if (>= res 10)\n              (reduced res)\n              (+ res x)))\n        [1 2 3 4 :nil])\n;; => 10\n```\n\nNote that in second example we had `:nil` in the array, which is not a\nvalid number, but we've terminated right before we've reached it."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  reduced = value_0_
end
local reduce_kv
do
  local function reduce_kv0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 3) then
      local _let_0_ = {...}
      local f = _let_0_[1]
      local val = _let_0_[2]
      local tbl = _let_0_[3]
      local res = val
      for _, _0_0 in ipairs((kvseq(tbl) or setmetatable({}, {["cljlib/type"] = "seq"}))) do
        local _each_0_ = _0_0
        local k = _each_0_[1]
        local v = _each_0_[2]
        res = f(res, k, v)
        local _1_0 = getmetatable(res)
        if (nil ~= _1_0) then
          local m = _1_0
          if (m["cljlib/reduced"] and (m["cljlib/reduced"].status == "ready")) then
            res = m["cljlib/reduced"].val
            break
          end
        end
      end
      return res
    else
      return error("wrong argument amount for reduce-kv", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(reduce_kv0, "fnl/arglist", {"..."}, "fnl/docstring", "Reduces an associative table using function `f' and initial value `val'.\n\n`f' should be a function of 3 arguments.  Returns the result of\napplying `f' to `val', the first key and the first value in `tbl',\nthen applying `f' to that result and the 2nd key and value, etc.  If\n`tbl' contains no entries, returns `val' and `f' is not called.  Note\nthat reduce-kv is supported on sequential tables and strings, where\nthe keys will be the ordinals.\n\nEarly termination is possible with the use of `reduced'\nfunction.\n\n# Examples\nReduce associative table by adding values from all keys:\n\n``` fennel\n(local t {:a1 1\n          :b1 2\n          :a2 2\n          :b2 3})\n\n(reduce-kv #(+ $1 $3) 0 t)\n;; => 8\n```\n\nReduce table by adding values from keys that start with letter `a':\n\n``` fennel\n(local t {:a1 1\n          :b1 2\n          :a2 2\n          :b2 3})\n\n(reduce-kv (fn [res k v] (if (= (string.sub k 1 1) :a) (+ res v) res))\n           0 t)\n;; => 3\n```") end)
  core["reduce-kv"] = reduce_kv0
  local value_0_ = core["reduce-kv"]
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[f", "val", "tbl]"}, ["fnl/docstring"] = "Reduces an associative table using function `f' and initial value `val'.\n\n`f' should be a function of 3 arguments.  Returns the result of\napplying `f' to `val', the first key and the first value in `tbl',\nthen applying `f' to that result and the 2nd key and value, etc.  If\n`tbl' contains no entries, returns `val' and `f' is not called.  Note\nthat reduce-kv is supported on sequential tables and strings, where\nthe keys will be the ordinals.\n\nEarly termination is possible with the use of `reduced'\nfunction.\n\n# Examples\nReduce associative table by adding values from all keys:\n\n``` fennel\n(local t {:a1 1\n          :b1 2\n          :a2 2\n          :b2 3})\n\n(reduce-kv #(+ $1 $3) 0 t)\n;; => 8\n```\n\nReduce table by adding values from keys that start with letter `a':\n\n``` fennel\n(local t {:a1 1\n          :b1 2\n          :a2 2\n          :b2 3})\n\n(reduce-kv (fn [res k v] (if (= (string.sub k 1 1) :a) (+ res v) res))\n           0 t)\n;; => 3\n```"}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  reduce_kv = value_0_
end
local mapv
do
  local function mapv0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 2) then
      local _let_0_ = {...}
      local f = _let_0_[1]
      local col = _let_0_[2]
      local res = setmetatable({}, {["cljlib/type"] = "seq"})
      for _, v in ipairs((seq(col) or setmetatable({}, {["cljlib/type"] = "seq"}))) do
        local tmp_0_ = f(v)
        if (tmp_0_ == nil) then
        else
          local tmp = tmp_0_
          insert(res, tmp)
        end
      end
      return res
    elseif (len_0_ == 3) then
      local _let_0_ = {...}
      local f = _let_0_[1]
      local col1 = _let_0_[2]
      local col2 = _let_0_[3]
      local res = setmetatable({}, {["cljlib/type"] = "seq"})
      local col10 = (seq(col1) or setmetatable({}, {["cljlib/type"] = "seq"}))
      local col20 = (seq(col2) or setmetatable({}, {["cljlib/type"] = "seq"}))
      local i1, v1 = next(col10)
      local i2, v2 = next(col20)
      while (i1 and i2) do
        do
          local tmp_0_ = f(v1, v2)
          if (tmp_0_ == nil) then
          else
            local tmp = tmp_0_
            insert(res, tmp)
          end
        end
        i1, v1 = next(col10, i1)
        i2, v2 = next(col20, i2)
      end
      return res
    elseif (len_0_ == 4) then
      local _let_0_ = {...}
      local f = _let_0_[1]
      local col1 = _let_0_[2]
      local col2 = _let_0_[3]
      local col3 = _let_0_[4]
      local res = setmetatable({}, {["cljlib/type"] = "seq"})
      local col10 = (seq(col1) or setmetatable({}, {["cljlib/type"] = "seq"}))
      local col20 = (seq(col2) or setmetatable({}, {["cljlib/type"] = "seq"}))
      local col30 = (seq(col3) or setmetatable({}, {["cljlib/type"] = "seq"}))
      local i1, v1 = next(col10)
      local i2, v2 = next(col20)
      local i3, v3 = next(col30)
      while (i1 and i2 and i3) do
        do
          local tmp_0_ = f(v1, v2, v3)
          if (tmp_0_ == nil) then
          else
            local tmp = tmp_0_
            insert(res, tmp)
          end
        end
        i1, v1 = next(col10, i1)
        i2, v2 = next(col20, i2)
        i3, v3 = next(col30, i3)
      end
      return res
    elseif (len_0_ >= 4) then
      local _let_0_ = {...}
      local f = _let_0_[1]
      local col1 = _let_0_[2]
      local col2 = _let_0_[3]
      local col3 = _let_0_[4]
      local cols = {(table.unpack or unpack)(_let_0_, 5)}
      local step
      local function step0(cols0)
        local function _0_(_241, _242)
          return (_241 and _242)
        end
        local function _1_(_241)
          return (next(_241) ~= nil)
        end
        if reduce(_0_, mapv0(_1_, cols0)) then
          local function _2_(_241)
            return ((seq(_241) or setmetatable({}, {["cljlib/type"] = "seq"})))[1]
          end
          local function _3_(_241)
            return {_unpack(_241, 2)}
          end
          return cons(mapv0(_2_, cols0), step0(mapv0(_3_, cols0)))
        else
          return setmetatable({}, {["cljlib/type"] = "seq"})
        end
      end
      pcall(function() require("fennel").metadata:setall(step0, "fnl/arglist", {"cols"}) end)
      step = step0
      local res = setmetatable({}, {["cljlib/type"] = "seq"})
      for _, v in ipairs(step(consj(cols, col3, col2, col1))) do
        local tmp_0_ = apply(f, v)
        if (tmp_0_ == nil) then
        else
          local tmp = tmp_0_
          insert(res, tmp)
        end
      end
      return res
    else
      return error("wrong argument amount for mapv", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(mapv0, "fnl/arglist", {"..."}, "fnl/docstring", "Maps function `f' over one or more collections.\n\nAccepts arbitrary amount of collections, calls `seq' on each of it.\nFunction `f' must take the same amount of arguments as the amount of\ntables, passed to `mapv'. Applies `f' over first value of each\ntable. Then applies `f' to second value of each table. Continues until\nany of the tables is exhausted. All remaining values are\nignored. Returns a sequential table of results.\n\n# Examples\nMap `string.upcase' over the string:\n\n``` fennel\n(mapv string.upper \"string\")\n;; => [\"S\" \"T\" \"R\" \"I\" \"N\" \"G\"]\n```\n\nMap `mul' over two tables:\n\n``` fennel\n(mapv mul [1 2 3 4] [1 0 -1])\n;; => [1 0 -3]\n```\n\nBasic `zipmap' implementation:\n\n``` fennel\n(import-macros {: into} :init-macros)\n(fn zipmap [keys vals]\n  (into {} (mapv vector keys vals)))\n\n(zipmap [:a :b :c] [1 2 3 4])\n;; => {:a 1 :b 2 :c 3}\n```") end)
  core.mapv = mapv0
  local value_0_ = core.mapv
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"\n  ([f col])", "\n  ([f col1 col2])", "\n  ([f col1 col2 col3])", "\n  ([f col1 col2 col3 & cols])"}, ["fnl/docstring"] = "Maps function `f' over one or more collections.\n\nAccepts arbitrary amount of collections, calls `seq' on each of it.\nFunction `f' must take the same amount of arguments as the amount of\ntables, passed to `mapv'. Applies `f' over first value of each\ntable. Then applies `f' to second value of each table. Continues until\nany of the tables is exhausted. All remaining values are\nignored. Returns a sequential table of results.\n\n# Examples\nMap `string.upcase' over the string:\n\n``` fennel\n(mapv string.upper \"string\")\n;; => [\"S\" \"T\" \"R\" \"I\" \"N\" \"G\"]\n```\n\nMap `mul' over two tables:\n\n``` fennel\n(mapv mul [1 2 3 4] [1 0 -1])\n;; => [1 0 -3]\n```\n\nBasic `zipmap' implementation:\n\n``` fennel\n(import-macros {: into} :init-macros)\n(fn zipmap [keys vals]\n  (into {} (mapv vector keys vals)))\n\n(zipmap [:a :b :c] [1 2 3 4])\n;; => {:a 1 :b 2 :c 3}\n```"}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  mapv = value_0_
end
local filter
do
  local function filter0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 2) then
      local _let_0_ = {...}
      local pred = _let_0_[1]
      local col = _let_0_[2]
      local tmp_0_ = seq(col)
      if tmp_0_ then
        local col0 = tmp_0_
        local f = (col0)[1]
        local r = {_unpack(col0, 2)}
        if pred(f) then
          return cons(f, filter0(pred, r))
        else
          return filter0(pred, r)
        end
      else
        return setmetatable({}, {["cljlib/type"] = "seq"})
      end
    else
      return error("wrong argument amount for filter", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(filter0, "fnl/arglist", {"..."}, "fnl/docstring", "Returns a sequential table of the items in `col' for which `pred'\n  returns logical true.") end)
  core.filter = filter0
  local value_0_ = core.filter
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[pred", "col]"}, ["fnl/docstring"] = "Returns a sequential table of the items in `col' for which `pred'\n  returns logical true."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  filter = value_0_
end
local every_3f
do
  local function every_3f0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 2) then
      local _let_0_ = {...}
      local pred = _let_0_[1]
      local tbl = _let_0_[2]
      if empty_3f(tbl) then
        return true
      elseif pred(tbl[1]) then
        return every_3f0(pred, {_unpack(tbl, 2)})
      else
        return false
      end
    else
      return error("wrong argument amount for every?", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(every_3f0, "fnl/arglist", {"..."}, "fnl/docstring", "Test if every item in `tbl' satisfies the `pred'.") end)
  core["every?"] = every_3f0
  local value_0_ = core["every?"]
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[pred", "tbl]"}, ["fnl/docstring"] = "Test if every item in `tbl' satisfies the `pred'."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  every_3f = value_0_
end
local some
do
  local function some0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 2) then
      local _let_0_ = {...}
      local pred = _let_0_[1]
      local tbl = _let_0_[2]
      local tmp_0_ = seq(tbl)
      if tmp_0_ then
        local tbl0 = tmp_0_
        return (pred((tbl0)[1]) or some0(pred, {_unpack(tbl0, 2)}))
      end
    else
      return error("wrong argument amount for some", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(some0, "fnl/arglist", {"..."}, "fnl/docstring", "Test if any item in `tbl' satisfies the `pred'.") end)
  core.some = some0
  local value_0_ = core.some
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[pred", "tbl]"}, ["fnl/docstring"] = "Test if any item in `tbl' satisfies the `pred'."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  some = value_0_
end
local not_any_3f
do
  local function not_any_3f0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 2) then
      local _let_0_ = {...}
      local pred = _let_0_[1]
      local tbl = _let_0_[2]
      local function _0_(_241)
        return not pred(_241)
      end
      return some(_0_, tbl)
    else
      return error("wrong argument amount for not-any?", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(not_any_3f0, "fnl/arglist", {"..."}, "fnl/docstring", "Test if no item in `tbl' satisfy the `pred'.") end)
  core["not-any?"] = not_any_3f0
  local value_0_ = core["not-any?"]
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[pred", "tbl]"}, ["fnl/docstring"] = "Test if no item in `tbl' satisfy the `pred'."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  not_any_3f = value_0_
end
local range
do
  local function range0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local upper = _let_0_[1]
      return range0(0, upper, 1)
    elseif (len_0_ == 2) then
      local _let_0_ = {...}
      local lower = _let_0_[1]
      local upper = _let_0_[2]
      return range0(lower, upper, 1)
    elseif (len_0_ == 3) then
      local _let_0_ = {...}
      local lower = _let_0_[1]
      local upper = _let_0_[2]
      local step = _let_0_[3]
      local res = setmetatable({}, {["cljlib/type"] = "seq"})
      for i = lower, (upper - step), step do
        insert(res, i)
      end
      return res
    else
      return error("wrong argument amount for range", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(range0, "fnl/arglist", {"..."}, "fnl/docstring", "return range of of numbers from `lower' to `upper' with optional `step'.") end)
  core.range = range0
  local value_0_ = core.range
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"([upper])", "([lower upper])", "([lower upper step])"}, ["fnl/docstring"] = "return range of of numbers from `lower' to `upper' with optional `step'."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  range = value_0_
end
local reverse
do
  local function reverse0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local tbl = _let_0_[1]
      local tmp_0_ = seq(tbl)
      if (tmp_0_ == nil) then
        return nil
      else
        local tbl0 = tmp_0_
        return reduce(consj, setmetatable({}, {["cljlib/type"] = "seq"}), tbl0)
      end
    else
      return error("wrong argument amount for reverse", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(reverse0, "fnl/arglist", {"..."}, "fnl/docstring", "Returns table with same items as in `tbl' but in reverse order.") end)
  core.reverse = reverse0
  local value_0_ = core.reverse
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[tbl]"}, ["fnl/docstring"] = "Returns table with same items as in `tbl' but in reverse order."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  reverse = value_0_
end
local take
do
  local function take0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 2) then
      local _let_0_ = {...}
      local n = _let_0_[1]
      local col = _let_0_[2]
      if (n == 0) then
        return {}
      elseif pos_int_3f(n) then
        local tmp_0_ = seq(col)
        if tmp_0_ then
          local s = tmp_0_
          return cons(first(s), take0(dec(n), rest(s)))
        else
          return nil
        end
      else
        return error("expected positive integer as first argument", 2)
      end
    else
      return error("wrong argument amount for take", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(take0, "fnl/arglist", {"..."}, "fnl/docstring", "Returns a sequence of the first `n' items in `col', or all items if\nthere are fewer than `n'.") end)
  core.take = take0
  local value_0_ = core.take
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[n", "col]"}, ["fnl/docstring"] = "Returns a sequence of the first `n' items in `col', or all items if\nthere are fewer than `n'."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  take = value_0_
end
local nthrest
do
  local function nthrest0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 2) then
      local _let_0_ = {...}
      local col = _let_0_[1]
      local n = _let_0_[2]
      return {_unpack(col, inc(n))}
    else
      return error("wrong argument amount for nthrest", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(nthrest0, "fnl/arglist", {"..."}, "fnl/docstring", "Returns the nth rest of `col', `col' when `n' is 0.\n\n# Examples\n\n``` fennel\n(assert-eq (nthrest [1 2 3 4] 3) [4])\n(assert-eq (nthrest [1 2 3 4] 2) [3 4])\n(assert-eq (nthrest [1 2 3 4] 1) [2 3 4])\n(assert-eq (nthrest [1 2 3 4] 0) [1 2 3 4])\n```") end)
  core.nthrest = nthrest0
  local value_0_ = core.nthrest
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[col", "n]"}, ["fnl/docstring"] = "Returns the nth rest of `col', `col' when `n' is 0.\n\n# Examples\n\n``` fennel\n(assert-eq (nthrest [1 2 3 4] 3) [4])\n(assert-eq (nthrest [1 2 3 4] 2) [3 4])\n(assert-eq (nthrest [1 2 3 4] 1) [2 3 4])\n(assert-eq (nthrest [1 2 3 4] 0) [1 2 3 4])\n```\n"}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  nthrest = value_0_
end
local partition
do
  local function partition0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 2) then
      local _let_0_ = {...}
      local n = _let_0_[1]
      local col = _let_0_[2]
      return partition0(n, n, col)
    elseif (len_0_ == 3) then
      local _let_0_ = {...}
      local n = _let_0_[1]
      local step = _let_0_[2]
      local col = _let_0_[3]
      local tmp_0_ = seq(col)
      if tmp_0_ then
        local s = tmp_0_
        local p = take(n, s)
        if (n == #p) then
          return cons(p, partition0(n, step, nthrest(s, step)))
        else
          return nil
        end
      else
        return nil
      end
    elseif (len_0_ == 4) then
      local _let_0_ = {...}
      local n = _let_0_[1]
      local step = _let_0_[2]
      local pad = _let_0_[3]
      local col = _let_0_[4]
      local tmp_0_ = seq(col)
      if tmp_0_ then
        local s = tmp_0_
        local p = take(n, s)
        if (n == #p) then
          return cons(p, partition0(n, step, pad, nthrest(s, step)))
        else
          return {take(n, concat(p, pad))}
        end
      else
        return nil
      end
    else
      return error("wrong argument amount for partition", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(partition0, "fnl/arglist", {"..."}, "fnl/docstring", "Returns a sequence of sequences of `n' items each, at offsets step\napart. If `step' is not supplied, defaults to `n', i.e. the partitions\ndo not overlap. If a `pad' collection is supplied, use its elements as\nnecessary to complete last partition up to `n' items. In case there\nare not enough padding elements, return a partition with less than `n'\nitems.\n\n# Examples\nPartition sequence into sub-sequences of size 3:\n\n``` fennel\n(assert-eq (partition 3 [1 2 3 4 5 6]) [[1 2 3] [4 5 6]])\n```\n\nWhen collection doesn't have enough elements, partition will not include those:\n\n``` fennel\n(assert-eq (partition 3 [1 2 3 4]) [[1 2 3]])\n```\n\nPartitions can overlap if step is supplied:\n\n``` fennel\n(assert-eq (partition 2 1 [1 2 3 4]) [[1 2] [2 3] [3 4]])\n```\n\nAdditional padding can be used to supply insufficient elements:\n\n``` fennel\n(assert-eq (partition 3 3 [3 2 1] [1 2 3 4]) [[1 2 3] [4 3 2]])\n```") end)
  core.partition = partition0
  local value_0_ = core.partition
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"([n col])", "([n step col])", "([n step pad col])"}, ["fnl/docstring"] = "Returns a sequence of sequences of `n' items each, at offsets step\napart. If `step' is not supplied, defaults to `n', i.e. the partitions\ndo not overlap. If a `pad' collection is supplied, use its elements as\nnecessary to complete last partition up to `n' items. In case there\nare not enough padding elements, return a partition with less than `n'\nitems.\n\n# Examples\nPartition sequence into sub-sequences of size 3:\n\n``` fennel\n(assert-eq (partition 3 [1 2 3 4 5 6]) [[1 2 3] [4 5 6]])\n```\n\nWhen collection doesn't have enough elements, partition will not include those:\n\n``` fennel\n(assert-eq (partition 3 [1 2 3 4]) [[1 2 3]])\n```\n\nPartitions can overlap if step is supplied:\n\n``` fennel\n(assert-eq (partition 2 1 [1 2 3 4]) [[1 2] [2 3] [3 4]])\n```\n\nAdditional padding can be used to supply insufficient elements:\n\n``` fennel\n(assert-eq (partition 3 3 [3 2 1] [1 2 3 4]) [[1 2 3] [4 3 2]])\n```"}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  partition = value_0_
end
local sequence_doc_order = {"vector", "seq", "kvseq", "first", "rest", "last", "butlast", "conj", "disj", "cons", "concat", "reduce", "reduced", "reduce-kv", "mapv", "filter", "every?", "some", "not-any?", "range", "reverse", "take", "nthrest", "partition"}
local eq = nil
local function deep_index(tbl, key)
  local res = nil
  for k, v in pairs(tbl) do
    if eq(k, key) then
      res = v
      break
    end
  end
  return res
end
pcall(function() require("fennel").metadata:setall(deep_index, "fnl/arglist", {"tbl", "key"}, "fnl/docstring", "This function uses the pre-declared `eq', which we set later on,\nbecause `eq' requires this function internally.  Several other\nfunctions also reuse this indexing method, such as sets.") end)
local _eq
do
  local value_0_
  local function _eq0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local x = _let_0_[1]
      return true
    elseif (len_0_ == 2) then
      local _let_0_ = {...}
      local x = _let_0_[1]
      local y = _let_0_[2]
      if (x == y) then
        return true
      elseif ((type(x) == "table") and (type(y) == "table")) then
        local _var_0_ = {true, 0, 0}
        local res = _var_0_[1]
        local count_a = _var_0_[2]
        local count_b = _var_0_[3]
        for k, v in pairs(x) do
          res = eq(v, deep_index(y, k))
          count_a = (count_a + 1)
          if not res then
            break
          end
        end
        if res then
          for _, _0 in pairs(y) do
            count_b = (count_b + 1)
          end
          res = (count_a == count_b)
        end
        return res
      elseif "else" then
        return false
      end
    elseif (len_0_ >= 2) then
      local _let_0_ = {...}
      local x = _let_0_[1]
      local y = _let_0_[2]
      local xs = {(table.unpack or unpack)(_let_0_, 3)}
      return (eq(x, y) and apply(eq, x, xs))
    else
      return error("wrong argument amount for _eq", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(_eq0, "fnl/arglist", {"..."}, "fnl/docstring", "Deep compare values.\n\n# Examples\n\n`eq' can compare both primitive types, tables, and user defined types\nthat have `__eq` metamethod.\n\n``` fennel\n(assert-is (eq 42 42))\n(assert-is (eq [1 2 3] [1 2 3]))\n(assert-is (eq (hash-set :a :b :c) (hash-set :a :b :c)))\n(assert-is (eq (hash-set :a :b :c) (ordered-set :c :b :a)))\n```\n\nDeep comparison is used for tables which use tables as keys:\n\n``` fennel\n(assert-is (eq {[1 2 3] {:a [1 2 3]} {:a 1} {:b 2}}\n               {{:a 1} {:b 2} [1 2 3] {:a [1 2 3]}}))\n(assert-is (eq {{{:a 1} {:b 1}} {{:c 3} {:d 4}} [[1] [2 [3]]] {:a 2}}\n               {[[1] [2 [3]]] {:a 2} {{:a 1} {:b 1}} {{:c 3} {:d 4}}}))\n```") end)
  value_0_ = _eq0
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"([x])", "([x y])", "([x y & xs])"}, ["fnl/docstring"] = "Deep compare values.\n\n# Examples\n\n`eq' can compare both primitive types, tables, and user defined types\nthat have `__eq` metamethod.\n\n``` fennel\n(assert-is (eq 42 42))\n(assert-is (eq [1 2 3] [1 2 3]))\n(assert-is (eq (hash-set :a :b :c) (hash-set :a :b :c)))\n(assert-is (eq (hash-set :a :b :c) (ordered-set :c :b :a)))\n```\n\nDeep comparison is used for tables which use tables as keys:\n\n``` fennel\n(assert-is (eq {[1 2 3] {:a [1 2 3]} {:a 1} {:b 2}}\n               {{:a 1} {:b 2} [1 2 3] {:a [1 2 3]}}))\n(assert-is (eq {{{:a 1} {:b 1}} {{:c 3} {:d 4}} [[1] [2 [3]]] {:a 2}}\n               {[[1] [2 [3]]] {:a 2} {{:a 1} {:b 1}} {{:c 3} {:d 4}}}))\n```"}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  _eq = value_0_
end
eq = _eq
core.eq = _eq
local identity
do
  local function identity0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local x = _let_0_[1]
      return x
    else
      return error("wrong argument amount for identity", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(identity0, "fnl/arglist", {"..."}, "fnl/docstring", "Returns its argument.") end)
  core.identity = identity0
  local value_0_ = core.identity
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Returns its argument."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  identity = value_0_
end
local comp
do
  local function comp0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local f = _let_0_[1]
      return f
    elseif (len_0_ == 2) then
      local _let_0_ = {...}
      local f = _let_0_[1]
      local g = _let_0_[2]
      local value_0_
      local function _0_(...)
        local len_0_0 = select("#", ...)
        if (len_0_0 == 1) then
          local _let_1_ = {...}
          local x = _let_1_[1]
          return f(g(x))
        elseif (len_0_0 == 2) then
          local _let_1_ = {...}
          local x = _let_1_[1]
          local y = _let_1_[2]
          return f(g(x, y))
        elseif (len_0_0 == 3) then
          local _let_1_ = {...}
          local x = _let_1_[1]
          local y = _let_1_[2]
          local z = _let_1_[3]
          return f(g(x, y, z))
        elseif (len_0_0 == 0) then
          local _let_1_ = {...}
          return f(g())
        elseif (len_0_0 >= 3) then
          local _let_1_ = {...}
          local x = _let_1_[1]
          local y = _let_1_[2]
          local z = _let_1_[3]
          local args = {(table.unpack or unpack)(_let_1_, 4)}
          return f(g(x, y, z, _unpack(args)))
        end
      end
      pcall(function() require("fennel").metadata:setall(_0_, "fnl/arglist", {"..."}) end)
      value_0_ = _0_
      local res_0_, fennel_0_ = pcall(require, "fennel")
      if res_0_ then
        for k_0_, v_0_ in pairs({["fnl/arglist"] = {"([])", "([x])", "([x y])", "([x y z])", "([x y z & args])"}}) do
          (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
        end
      end
      return value_0_
    elseif (len_0_ == 0) then
      local _let_0_ = {...}
      return identity
    elseif (len_0_ >= 2) then
      local _let_0_ = {...}
      local f = _let_0_[1]
      local g = _let_0_[2]
      local fs = {(table.unpack or unpack)(_let_0_, 3)}
      return reduce(comp0, consj(fs, g, f))
    end
  end
  pcall(function() require("fennel").metadata:setall(comp0, "fnl/arglist", {"..."}, "fnl/docstring", "Compose functions.") end)
  core.comp = comp0
  local value_0_ = core.comp
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"([])", "([f])", "([f g])", "([f g & fs])"}, ["fnl/docstring"] = "Compose functions."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  comp = value_0_
end
local complement
do
  local function complement0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local f = _let_0_[1]
      local value_0_
      local function _0_(...)
        local len_0_0 = select("#", ...)
        if (len_0_0 == 1) then
          local _let_1_ = {...}
          local a = _let_1_[1]
          return not f(a)
        elseif (len_0_0 == 2) then
          local _let_1_ = {...}
          local a = _let_1_[1]
          local b = _let_1_[2]
          return not f(a, b)
        elseif (len_0_0 == 0) then
          local _let_1_ = {...}
          return not f()
        elseif (len_0_0 >= 2) then
          local _let_1_ = {...}
          local a = _let_1_[1]
          local b = _let_1_[2]
          local cs = {(table.unpack or unpack)(_let_1_, 3)}
          return not apply(f, a, b, cs)
        end
      end
      pcall(function() require("fennel").metadata:setall(_0_, "fnl/arglist", {"..."}) end)
      value_0_ = _0_
      local res_0_, fennel_0_ = pcall(require, "fennel")
      if res_0_ then
        for k_0_, v_0_ in pairs({["fnl/arglist"] = {"([])", "([a])", "([a b])", "([a b & cs])"}}) do
          (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
        end
      end
      return value_0_
    else
      return error("wrong argument amount for complement", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(complement0, "fnl/arglist", {"..."}, "fnl/docstring", "Takes a function `f' and returns the function that takes the same\namount of arguments as `f', has the same effect, and returns the\noppisite truth value.") end)
  core.complement = complement0
  local value_0_ = core.complement
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[f]"}, ["fnl/docstring"] = "Takes a function `f' and returns the function that takes the same\namount of arguments as `f', has the same effect, and returns the\noppisite truth value."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  complement = value_0_
end
local constantly
do
  local function constantly0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local x = _let_0_[1]
      local function _0_()
        return x
      end
      pcall(function() require("fennel").metadata:setall(_0_, "fnl/arglist", {}) end)
      return _0_
    else
      return error("wrong argument amount for constantly", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(constantly0, "fnl/arglist", {"..."}, "fnl/docstring", "Returns a function that takes any number of arguments and returns `x'.") end)
  core.constantly = constantly0
  local value_0_ = core.constantly
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[x]"}, ["fnl/docstring"] = "Returns a function that takes any number of arguments and returns `x'."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  constantly = value_0_
end
local memoize
do
  local function memoize0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local f = _let_0_[1]
      local memo = setmetatable({}, {__index = deep_index})
      local function _0_(...)
        local args = {...}
        local tmp_0_ = memo[args]
        if (tmp_0_ == nil) then
          local res = f(...)
          memo[args] = res
          return res
        else
          local res = tmp_0_
          return res
        end
      end
      pcall(function() require("fennel").metadata:setall(_0_, "fnl/arglist", {"..."}) end)
      return _0_
    else
      return error("wrong argument amount for memoize", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(memoize0, "fnl/arglist", {"..."}, "fnl/docstring", "Returns a memoized version of a referentially transparent function.\nThe memoized version of the function keeps a cache of the mapping from\narguments to results and, when calls with the same arguments are\nrepeated often, has higher performance at the expense of higher memory\nuse.") end)
  core.memoize = memoize0
  local value_0_ = core.memoize
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[f]"}, ["fnl/docstring"] = "Returns a memoized version of a referentially transparent function.\nThe memoized version of the function keeps a cache of the mapping from\narguments to results and, when calls with the same arguments are\nrepeated often, has higher performance at the expense of higher memory\nuse."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  memoize = value_0_
end
local function_manipulation_doc_order = {"identity", "comp", "complement", "constantly", "memoize"}
local assoc
do
  local function assoc0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 3) then
      local _let_0_ = {...}
      local tbl = _let_0_[1]
      local k = _let_0_[2]
      local v = _let_0_[3]
      assert(not nil_3f(k), "attempt to use nil as key")
      local _1_
      do
        local _0_0 = tbl
        _0_0[k] = v
        _1_ = _0_0
      end
      return setmetatable(_1_, {["cljlib/type"] = "table"})
    elseif (len_0_ >= 3) then
      local _let_0_ = {...}
      local tbl = _let_0_[1]
      local k = _let_0_[2]
      local v = _let_0_[3]
      local kvs = {(table.unpack or unpack)(_let_0_, 4)}
      assert(((#kvs % 2) == 0), ("no value supplied for key " .. kvs[#kvs]))
      assert(not nil_3f(k), "attempt to use nil as key")
      tbl[k] = v
      local _var_0_ = {nil, nil}
      local k0 = _var_0_[1]
      local v0 = _var_0_[2]
      local i, k1 = next(kvs)
      while i do
        i, v0 = next(kvs, i)
        tbl[k1] = v0
        i, k1 = next(kvs, i)
      end
      return setmetatable(tbl, {["cljlib/type"] = "table"})
    else
      return error("wrong argument amount for assoc", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(assoc0, "fnl/arglist", {"..."}, "fnl/docstring", "Associate key `k' with value `v' in `tbl'.") end)
  core.assoc = assoc0
  local value_0_ = core.assoc
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"([tbl k v])", "([tbl k v & kvs])"}, ["fnl/docstring"] = "Associate key `k' with value `v' in `tbl'."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  assoc = value_0_
end
local hash_map
do
  local function hash_map0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 0) then
      local _let_0_ = {...}
      return setmetatable({}, {["cljlib/type"] = "table"})
    elseif (len_0_ >= 0) then
      local _let_0_ = {...}
      local kvs = {(table.unpack or unpack)(_let_0_, 1)}
      return apply(assoc, {}, kvs)
    end
  end
  pcall(function() require("fennel").metadata:setall(hash_map0, "fnl/arglist", {"..."}, "fnl/docstring", "Create associative table from `kvs' represented as sequence of keys\nand values") end)
  core["hash-map"] = hash_map0
  local value_0_ = core["hash-map"]
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"([])", "([& kvs])"}, ["fnl/docstring"] = "Create associative table from `kvs' represented as sequence of keys\nand values"}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  hash_map = value_0_
end
local get
do
  local function get0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 2) then
      local _let_0_ = {...}
      local tbl = _let_0_[1]
      local key = _let_0_[2]
      return get0(tbl, key, nil)
    elseif (len_0_ == 3) then
      local _let_0_ = {...}
      local tbl = _let_0_[1]
      local key = _let_0_[2]
      local not_found = _let_0_[3]
      local tmp_0_ = tbl[key]
      if (tmp_0_ == nil) then
        return not_found
      else
        local res = tmp_0_
        return res
      end
    else
      return error("wrong argument amount for get", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(get0, "fnl/arglist", {"..."}, "fnl/docstring", "Get value from the table by accessing it with a `key'.\nAccepts additional `not-found' as a marker to return if value wasn't\nfound in the table.") end)
  core.get = get0
  local value_0_ = core.get
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"([tbl key])", "([tbl key not-found])"}, ["fnl/docstring"] = "Get value from the table by accessing it with a `key'.\nAccepts additional `not-found' as a marker to return if value wasn't\nfound in the table."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  get = value_0_
end
local get_in
do
  local function get_in0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 2) then
      local _let_0_ = {...}
      local tbl = _let_0_[1]
      local keys = _let_0_[2]
      return get_in0(tbl, keys, nil)
    elseif (len_0_ == 3) then
      local _let_0_ = {...}
      local tbl = _let_0_[1]
      local keys = _let_0_[2]
      local not_found = _let_0_[3]
      local res = tbl
      local t = tbl
      for _, k in ipairs(keys) do
        local tmp_0_ = t[k]
        if (tmp_0_ == nil) then
          res = not_found
        else
          local v = tmp_0_
          local _set_0_ = {v, v}
          res = _set_0_[1]
          t = _set_0_[2]
        end
      end
      return res
    else
      return error("wrong argument amount for get-in", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(get_in0, "fnl/arglist", {"..."}, "fnl/docstring", "Get value from nested set of tables by providing key sequence.\nAccepts additional `not-found' as a marker to return if value wasn't\nfound in the table.") end)
  core["get-in"] = get_in0
  local value_0_ = core["get-in"]
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"([tbl keys])", "([tbl keys not-found])"}, ["fnl/docstring"] = "Get value from nested set of tables by providing key sequence.\nAccepts additional `not-found' as a marker to return if value wasn't\nfound in the table."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  get_in = value_0_
end
local keys
do
  local function keys0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local tbl = _let_0_[1]
      local res = {}
      for k, _ in pairs(tbl) do
        insert(res, k)
      end
      return res
    else
      return error("wrong argument amount for keys", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(keys0, "fnl/arglist", {"..."}, "fnl/docstring", "Returns a sequence of the table's keys, in the same order as `seq'.") end)
  core.keys = keys0
  local value_0_ = core.keys
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[tbl]"}, ["fnl/docstring"] = "Returns a sequence of the table's keys, in the same order as `seq'."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  keys = value_0_
end
local vals
do
  local function vals0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local tbl = _let_0_[1]
      local res = {}
      for _, v in pairs(tbl) do
        insert(res, v)
      end
      return res
    else
      return error("wrong argument amount for vals", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(vals0, "fnl/arglist", {"..."}, "fnl/docstring", "Returns a sequence of the table's values, in the same order as `seq'.") end)
  core.vals = vals0
  local value_0_ = core.vals
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[tbl]"}, ["fnl/docstring"] = "Returns a sequence of the table's values, in the same order as `seq'."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  vals = value_0_
end
local find
do
  local function find0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 2) then
      local _let_0_ = {...}
      local tbl = _let_0_[1]
      local key = _let_0_[2]
      local tmp_0_ = tbl[key]
      if (tmp_0_ == nil) then
        return nil
      else
        local v = tmp_0_
        return {key, v}
      end
    else
      return error("wrong argument amount for find", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(find0, "fnl/arglist", {"..."}, "fnl/docstring", "Returns the map entry for `key', or `nil' if key not present in `tbl'.") end)
  core.find = find0
  local value_0_ = core.find
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[tbl", "key]"}, ["fnl/docstring"] = "Returns the map entry for `key', or `nil' if key not present in `tbl'."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  find = value_0_
end
local dissoc
do
  local function dissoc0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local tbl = _let_0_[1]
      return tbl
    elseif (len_0_ == 2) then
      local _let_0_ = {...}
      local tbl = _let_0_[1]
      local key = _let_0_[2]
      local _0_0 = tbl
      _0_0[key] = nil
      return _0_0
    elseif (len_0_ >= 2) then
      local _let_0_ = {...}
      local tbl = _let_0_[1]
      local key = _let_0_[2]
      local keys0 = {(table.unpack or unpack)(_let_0_, 3)}
      return apply(dissoc0, dissoc0(tbl, key), keys0)
    else
      return error("wrong argument amount for dissoc", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(dissoc0, "fnl/arglist", {"..."}, "fnl/docstring", "Remove `key' from table `tbl'.  Optionally takes more `keys`.") end)
  core.dissoc = dissoc0
  local value_0_ = core.dissoc
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"([tbl])", "([tbl key])", "([tbl key & keys])"}, ["fnl/docstring"] = "Remove `key' from table `tbl'.  Optionally takes more `keys`."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  dissoc = value_0_
end
local hash_table_doc_order = {"assoc", "hash-map", "get", "get-in", "keys", "vals", "find", "dissoc"}
local remove_method
do
  local function remove_method0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 2) then
      local _let_0_ = {...}
      local multimethod = _let_0_[1]
      local dispatch_value = _let_0_[2]
      if multifn_3f(multimethod) then
        multimethod[dispatch_value] = nil
      else
        error((tostring(multimethod) .. " is not a multifn"), 2)
      end
      return multimethod
    else
      return error("wrong argument amount for remove-method", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(remove_method0, "fnl/arglist", {"..."}, "fnl/docstring", "Remove method from `multimethod' for given `dispatch-value'.") end)
  core["remove-method"] = remove_method0
  local value_0_ = core["remove-method"]
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[multimethod", "dispatch-value]"}, ["fnl/docstring"] = "Remove method from `multimethod' for given `dispatch-value'."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  remove_method = value_0_
end
local remove_all_methods
do
  local function remove_all_methods0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local multimethod = _let_0_[1]
      if multifn_3f(multimethod) then
        for k, _ in pairs(multimethod) do
          multimethod[k] = nil
        end
      else
        error((tostring(multimethod) .. " is not a multifn"), 2)
      end
      return multimethod
    else
      return error("wrong argument amount for remove-all-methods", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(remove_all_methods0, "fnl/arglist", {"..."}, "fnl/docstring", "Removes all of the methods of `multimethod'") end)
  core["remove-all-methods"] = remove_all_methods0
  local value_0_ = core["remove-all-methods"]
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[multimethod]"}, ["fnl/docstring"] = "Removes all of the methods of `multimethod'"}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  remove_all_methods = value_0_
end
local methods
do
  local function methods0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 1) then
      local _let_0_ = {...}
      local multimethod = _let_0_[1]
      if multifn_3f(multimethod) then
        local m = {}
        for k, v in pairs(multimethod) do
          m[k] = v
        end
        return m
      else
        return error((tostring(multimethod) .. " is not a multifn"), 2)
      end
    else
      return error("wrong argument amount for methods", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(methods0, "fnl/arglist", {"..."}, "fnl/docstring", "Given a `multimethod', returns a map of dispatch values -> dispatch fns") end)
  core.methods = methods0
  local value_0_ = core.methods
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[multimethod]"}, ["fnl/docstring"] = "Given a `multimethod', returns a map of dispatch values -> dispatch fns"}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  methods = value_0_
end
local get_method
do
  local function get_method0(...)
    local len_0_ = select("#", ...)
    if (len_0_ == 2) then
      local _let_0_ = {...}
      local multimethod = _let_0_[1]
      local dispatch_value = _let_0_[2]
      if multifn_3f(multimethod) then
        return (multimethod[dispatch_value] or multimethod.default)
      else
        return error((tostring(multimethod) .. " is not a multifn"), 2)
      end
    else
      return error("wrong argument amount for get-method", 2)
    end
  end
  pcall(function() require("fennel").metadata:setall(get_method0, "fnl/arglist", {"..."}, "fnl/docstring", "Given a `multimethod' and a `dispatch-value', returns the dispatch\n`fn' that would apply to that value, or `nil' if none apply and no\ndefault.") end)
  core["get-method"] = get_method0
  local value_0_ = core["get-method"]
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[multimethod", "dispatch-value]"}, ["fnl/docstring"] = "Given a `multimethod' and a `dispatch-value', returns the dispatch\n`fn' that would apply to that value, or `nil' if none apply and no\ndefault."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  get_method = value_0_
end
local multimethods_doc_order = {"remove-method", "remove-all-methods", "methods", "get-method"}
local function viewset(Set, view, inspector, indent)
  if inspector.seen[Set] then
    return ("@set" .. inspector.seen[Set] .. "{...}")
  else
    local prefix
    local _0_
    if inspector["visible-cycle?"](Set) then
      _0_ = inspector.seen[Set]
    else
      _0_ = ""
    end
    prefix = ("@set" .. _0_ .. "{")
    local set_indent = #prefix
    local indent_str = string.rep(" ", set_indent)
    local lines
    do
      local tbl_0_ = {}
      for v in pairs(Set) do
        tbl_0_[(#tbl_0_ + 1)] = (indent_str .. view(v, inspector, (indent + set_indent), true))
      end
      lines = tbl_0_
    end
    lines[1] = (prefix .. string.gsub((lines[1] or ""), "^%s+", ""))
    lines[#lines] = (lines[#lines] .. "}")
    return lines
  end
end
pcall(function() require("fennel").metadata:setall(viewset, "fnl/arglist", {"Set", "view", "inspector", "indent"}) end)
local function ordered_set_newindex(Set)
  local function _0_(t, k, v)
    if (nil == v) then
      local k0 = Set[k]
      for key, index in pairs(Set) do
        if (index == k0) then
          Set[key] = nil
        elseif (index > k0) then
          Set[key] = (index - 1)
        end
      end
      return nil
    else
      if not Set[v] then
        Set[v] = (1 + #t)
        return nil
      end
    end
  end
  pcall(function() require("fennel").metadata:setall(_0_, "fnl/arglist", {"t", "k", "v"}) end)
  return _0_
end
pcall(function() require("fennel").metadata:setall(ordered_set_newindex, "fnl/arglist", {"Set"}, "fnl/docstring", "`__newindex` metamethod for ordered-set.\n\nUpdates order of all items when some key removed from set.") end)
local function hash_set_newindex(Set)
  local function _0_(t, k, v)
    if (nil == v) then
      for key, _ in pairs(Set) do
        if eq(key, k) then
          Set[key] = nil
          break
        end
      end
      return nil
    else
      if not Set[v] then
        Set[v] = true
        return nil
      end
    end
  end
  pcall(function() require("fennel").metadata:setall(_0_, "fnl/arglist", {"t", "k", "v"}) end)
  return _0_
end
pcall(function() require("fennel").metadata:setall(hash_set_newindex, "fnl/arglist", {"Set"}, "fnl/docstring", "`__newindex` metamethod for hash-set.") end)
local function set_length(Set)
  local function _0_()
    local len = 0
    for _, _0 in pairs(Set) do
      len = (1 + len)
    end
    return len
  end
  pcall(function() require("fennel").metadata:setall(_0_, "fnl/arglist", {}) end)
  return _0_
end
pcall(function() require("fennel").metadata:setall(set_length, "fnl/arglist", {"Set"}, "fnl/docstring", "`__len` metamethod for set data structure.") end)
local function set_eq(s1, s2)
  local _var_0_ = {0, true}
  local size = _var_0_[1]
  local res = _var_0_[2]
  for i, k in pairs(s1) do
    size = (size + 1)
    if res then
      res = (s2)[k]
    else
      break
    end
  end
  return (res and (size == #s2))
end
pcall(function() require("fennel").metadata:setall(set_eq, "fnl/arglist", {"s1", "s2"}, "fnl/docstring", "`__eq` metamethod for set data structure.") end)
local function set__3eiseq(Set)
  local tbl_0_ = {}
  for v, k in pairs(Set) do
    local _0_0, _1_0 = k, v
    if ((nil ~= _0_0) and (nil ~= _1_0)) then
      local k_0_ = _0_0
      local v_0_ = _1_0
      tbl_0_[k_0_] = v_0_
    end
  end
  return tbl_0_
end
pcall(function() require("fennel").metadata:setall(set__3eiseq, "fnl/arglist", {"Set"}) end)
local function ordered_set_pairs(Set)
  local function _0_()
    local i = 0
    local iseq = nil
    local function set_next(t, _)
      if not iseq then
        iseq = set__3eiseq(Set)
      end
      i = (i + 1)
      local v = iseq[i]
      return v, v
    end
    pcall(function() require("fennel").metadata:setall(set_next, "fnl/arglist", {"t", "_"}) end)
    return set_next, Set, nil
  end
  pcall(function() require("fennel").metadata:setall(_0_, "fnl/arglist", {}) end)
  return _0_
end
pcall(function() require("fennel").metadata:setall(ordered_set_pairs, "fnl/arglist", {"Set"}, "fnl/docstring", "Returns stateless `ipairs' iterator for ordered sets.") end)
local function hash_set_pairs(Set)
  local function _0_()
    local function iter(t, k)
      local v = next(t, k)
      return v, v
    end
    pcall(function() require("fennel").metadata:setall(iter, "fnl/arglist", {"t", "k"}) end)
    return iter, Set, nil
  end
  pcall(function() require("fennel").metadata:setall(_0_, "fnl/arglist", {}) end)
  return _0_
end
pcall(function() require("fennel").metadata:setall(hash_set_pairs, "fnl/arglist", {"Set"}, "fnl/docstring", "Returns stateful `ipairs' iterator for hashed sets.") end)
local function into_set(Set, tbl)
  for _, v in pairs((seq(tbl) or {})) do
    conj(Set, v)
  end
  return Set
end
pcall(function() require("fennel").metadata:setall(into_set, "fnl/arglist", {"Set", "tbl"}, "fnl/docstring", "Transform `tbl' into `Set`") end)
local ordered_set
do
  local function ordered_set0(...)
    local len_0_ = select("#", ...)
    if (len_0_ >= 0) then
      local _let_0_ = {...}
      local xs = {(table.unpack or unpack)(_let_0_, 1)}
      local Set = setmetatable({}, {__index = deep_index})
      local set_pairs = ordered_set_pairs(Set)
      local i = 1
      for _, val in ipairs(xs) do
        if not Set[val] then
          Set[val] = i
          i = (1 + i)
        end
      end
      local function _0_()
        return ordered_set0()
      end
      local function _1_(_241, _242)
        return next(Set, _242)
      end
      local function _2_(_241, _242)
        if Set[_242] then
          return _242
        else
          return nil
        end
      end
      local function _3_(_241, _242)
        if Set[_242] then
          return _242
        else
          return nil
        end
      end
      return setmetatable({}, {["cljlib/empty"] = _0_, ["cljlib/into"] = into_set, ["cljlib/next"] = _1_, ["cljlib/type"] = "cljlib/ordered-set", __call = _2_, __eq = set_eq, __fennelview = viewset, __index = _3_, __len = set_length(Set), __name = "ordered set", __newindex = ordered_set_newindex(Set), __pairs = set_pairs})
    end
  end
  pcall(function() require("fennel").metadata:setall(ordered_set0, "fnl/arglist", {"..."}, "fnl/docstring", "Create ordered set.\n\nSet is a collection of unique elements, which sore purpose is only to\ntell you if something is in the set or not.\n\n`ordered-set' is follows the argument insertion order, unlike sorted\nsets, which apply some sorting algorithm internally. New items added\nat the end of the set. Ordered set supports removal of items via\n`tset' and `disj'. To add element to the ordered set use\n`tset' or `conj'. Both operations modify the set.\n\n**Note**: Hash set prints as `@set{a b c}`, but this construct is not\nsupported by the Fennel reader, so you can't create sets with this\nsyntax. Use `ordered-set' function instead.\n\nBelow are some examples of how to create and manipulate sets.\n\n## Create ordered set:\nOrdered sets are created by passing any amount of elements desired to\nbe in the set:\n\n``` fennel\n(ordered-set)\n;; => @set{}\n(ordered-set :a :c :b)\n;; => @set{:a :c :b}\n```\n\nDuplicate items are not added:\n\n``` fennel\n(ordered-set :a :c :a :a :a :a :c :b)\n;; => @set{:a :c :b}\n```\n\n## Check if set contains desired value:\nSets are functions of their keys, so simply calling a set with a\ndesired key will either return the key, or `nil':\n\n``` fennel\n(local oset (ordered-set [:a :b :c] [:c :d :e] :e :f))\n(oset [:a :b :c])\n;; => [\"a\" \"b\" \"c\"]\n(. oset :e)\n;; \"e\"\n(oset [:a :b :f])\n;; => nil\n```\n\n## Add items to existing set:\nTo add element to the set use `conj' or `tset'\n\n``` fennel\n(local oset (ordered-set :a :b :c))\n(conj oset :d :e)\n;; => @set{:a :b :c :d :e}\n```\n\n### Remove items from the set:\nTo add element to the set use `disj' or `tset'\n\n``` fennel\n(local oset (ordered-set :a :b :c))\n(disj oset :b)\n;; => @set{:a :c}\n(tset oset :a nil)\noset\n;; => @set{:c}\n```\n\n## Equality semantics\nBoth `ordered-set' and `hash-set' implement `__eq` metamethod,\nand are compared for having the same keys without particular order and\nsame size:\n\n``` fennel\n(assert-eq (ordered-set :a :b) (ordered-set :b :a))\n(assert-ne (ordered-set :a :b) (ordered-set :b :a :c))\n(assert-eq (ordered-set :a :b) (hash-set :a :b))\n```") end)
  core["ordered-set"] = ordered_set0
  local value_0_ = core["ordered-set"]
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[&", "xs]"}, ["fnl/docstring"] = "Create ordered set.\n\nSet is a collection of unique elements, which sore purpose is only to\ntell you if something is in the set or not.\n\n`ordered-set' is follows the argument insertion order, unlike sorted\nsets, which apply some sorting algorithm internally. New items added\nat the end of the set. Ordered set supports removal of items via\n`tset' and `disj'. To add element to the ordered set use\n`tset' or `conj'. Both operations modify the set.\n\n**Note**: Hash set prints as `@set{a b c}`, but this construct is not\nsupported by the Fennel reader, so you can't create sets with this\nsyntax. Use `ordered-set' function instead.\n\nBelow are some examples of how to create and manipulate sets.\n\n## Create ordered set:\nOrdered sets are created by passing any amount of elements desired to\nbe in the set:\n\n``` fennel\n(ordered-set)\n;; => @set{}\n(ordered-set :a :c :b)\n;; => @set{:a :c :b}\n```\n\nDuplicate items are not added:\n\n``` fennel\n(ordered-set :a :c :a :a :a :a :c :b)\n;; => @set{:a :c :b}\n```\n\n## Check if set contains desired value:\nSets are functions of their keys, so simply calling a set with a\ndesired key will either return the key, or `nil':\n\n``` fennel\n(local oset (ordered-set [:a :b :c] [:c :d :e] :e :f))\n(oset [:a :b :c])\n;; => [\"a\" \"b\" \"c\"]\n(. oset :e)\n;; \"e\"\n(oset [:a :b :f])\n;; => nil\n```\n\n## Add items to existing set:\nTo add element to the set use `conj' or `tset'\n\n``` fennel\n(local oset (ordered-set :a :b :c))\n(conj oset :d :e)\n;; => @set{:a :b :c :d :e}\n```\n\n### Remove items from the set:\nTo add element to the set use `disj' or `tset'\n\n``` fennel\n(local oset (ordered-set :a :b :c))\n(disj oset :b)\n;; => @set{:a :c}\n(tset oset :a nil)\noset\n;; => @set{:c}\n```\n\n## Equality semantics\nBoth `ordered-set' and `hash-set' implement `__eq` metamethod,\nand are compared for having the same keys without particular order and\nsame size:\n\n``` fennel\n(assert-eq (ordered-set :a :b) (ordered-set :b :a))\n(assert-ne (ordered-set :a :b) (ordered-set :b :a :c))\n(assert-eq (ordered-set :a :b) (hash-set :a :b))\n```"}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  ordered_set = value_0_
end
local hash_set
do
  local function hash_set0(...)
    local len_0_ = select("#", ...)
    if (len_0_ >= 0) then
      local _let_0_ = {...}
      local xs = {(table.unpack or unpack)(_let_0_, 1)}
      local Set = setmetatable({}, {__index = deep_index})
      local set_pairs = hash_set_pairs(Set)
      for _, val in ipairs(xs) do
        if not Set[val] then
          Set[val] = true
        end
      end
      local function _0_()
        return hash_set0()
      end
      local function _1_(_241, _242)
        return next(Set, _242)
      end
      local function _2_(_241, _242)
        if Set[_242] then
          return _242
        else
          return nil
        end
      end
      local function _3_(_241, _242)
        if Set[_242] then
          return _242
        else
          return nil
        end
      end
      return setmetatable({}, {["cljlib/empty"] = _0_, ["cljlib/into"] = into_set, ["cljlib/next"] = _1_, ["cljlib/type"] = "cljlib/hash-set", __call = _2_, __eq = set_eq, __fennelview = viewset, __index = _3_, __len = set_length(Set), __name = "hash set", __newindex = hash_set_newindex(Set), __pairs = set_pairs})
    end
  end
  pcall(function() require("fennel").metadata:setall(hash_set0, "fnl/arglist", {"..."}, "fnl/docstring", "Create hash set.\n\nSet is a collection of unique elements, which sore purpose is only to\ntell you if something is in the set or not.\n\nHash set differs from ordered set in that the keys are do not have any\nparticular order. New items are added at the arbitrary position by\nusing `conj' or `tset' functions, and items can be removed\nwith `disj' or `tset' functions. Rest semantics are the same\nas for `ordered-set'\n\n**Note**: Hash set prints as `@set{a b c}`, but this construct is not\nsupported by the Fennel reader, so you can't create sets with this\nsyntax. Use `hash-set' function instead.") end)
  core["hash-set"] = hash_set0
  local value_0_ = core["hash-set"]
  local res_0_, fennel_0_ = pcall(require, "fennel")
  if res_0_ then
    for k_0_, v_0_ in pairs({["fnl/arglist"] = {"[&", "xs]"}, ["fnl/docstring"] = "Create hash set.\n\nSet is a collection of unique elements, which sore purpose is only to\ntell you if something is in the set or not.\n\nHash set differs from ordered set in that the keys are do not have any\nparticular order. New items are added at the arbitrary position by\nusing `conj' or `tset' functions, and items can be removed\nwith `disj' or `tset' functions. Rest semantics are the same\nas for `ordered-set'\n\n**Note**: Hash set prints as `@set{a b c}`, but this construct is not\nsupported by the Fennel reader, so you can't create sets with this\nsyntax. Use `hash-set' function instead."}) do
      (fennel_0_.metadata):set(value_0_, k_0_, v_0_)
    end
  end
  hash_set = value_0_
end
local set_doc_order = {"ordered-set", "hash-set"}
module_info._DOC_ORDER = concat(utility_doc_order, {"eq"}, predicate_doc_order, sequence_doc_order, function_manipulation_doc_order, hash_table_doc_order, multimethods_doc_order, set_doc_order)
return setmetatable(core, {__index = module_info})
