---@meta

---@type fun(a: unknown, b: unknown): boolean
local same = nil

local func = require("pl.func") ---@type pl.func
local List = require("pl.List") ---@type pl.ListClass

local _0 = func._0
local _1 = func._1

local ls = List({ 10, 20, 30 })

local b = _1.something()
local result = ls:map(b)

assert(same(result, { 11, 21, 31 }))

local p = func.bind(print, "start>", _0)
p(10, 20, 30) --> start>   10   20   30
