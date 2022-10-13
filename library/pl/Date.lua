---@meta

local class = require("pl.class")

---# Class [`pl.Date`](https://lunarmodules.github.io/Penlight/classes/pl.Date.html)
---
---Date and Date Format classes.
---
---See [the Guide](https://lunarmodules.github.io/Penlight/manual/05-dates.md.html#).
---
---NOTE: the date module is deprecated! see https://github.com/lunarmodules/Penlight/issues/285
---
---Dependencies:
--- [`pl.class`](https://lunarmodules.github.io/Penlight/libraries/pl.class.html#)
--- [`pl.stringx`](https://lunarmodules.github.io/Penlight/libraries/pl.stringx.html#)
--- [`pl.utils`](https://lunarmodules.github.io/Penlight/libraries/pl.utils.html#)
---@class PLDate : PLClass
---@operator sub(PLDate): PLDateInterval
---@overload fun(t?: number|PLDate|osdate, is_utc?: boolean): PLDate
---@overload fun(year: integer, month: integer, day: integer, hour?: integer, min?: integer, sec?: integer): PLDate
local Date = class()

---Date constructor.
---@param t? number|PLDate|osdate -- this can be either
---
--- * `nil` or empty - use current date and time
--- * `number` - seconds since epoch (as returned by os.time). Resulting time is UTC
--- * `Date` - make a copy of this date
--- * `table` - table containing year, month, etc as for os.time. You may leave out year, month or day, in which case current values will be used.
--- * year (will be followed by month, day etc)
---
---@param is_utc? boolean -- `true` if Universal Coordinated Time
---@diagnostic disable-next-line:duplicate-set-field
function Date:_init(t, is_utc) end

---@param year integer 
---@param month integer
---@param day integer
---@param hour? integer
---@param min? integer
---@param sec? integer
---@diagnostic disable-next-line:duplicate-set-field
function Date:_init(year, month, day, hour, min, sec) end

---set the current time of this Date object.
---@param t integer -- seconds since epoch
function Date:set(t) end

---get the time zone offset from UTC.
---@param ts integer -- seconds ahead of UTC
---@return integer
---@nodiscard
function Date.tzone(ts) end

---convert this date to UTC.
---@return PLDate
---@nodiscard
function Date:toUTC() end

---convert this UTC date to local.
---@return PLDate
---@nodiscard
function Date:toLocal() end

---set the year.
---@param y integer -- Four-digit year
---@return PLDate self
---@diagnostic disable-next-line:duplicate-set-field
function Date:year(y) end

---set the month.
---@param m integer -- month
---@return PLDate self
---@diagnostic disable-next-line:duplicate-set-field
function Date:month(m) end

---set the day.
---@param d integer -- day
---@return PLDate self
---@diagnostic disable-next-line:duplicate-set-field
function Date:day(d) end

---set the hour.
---@param h integer -- hour
---@return PLDate self
---@diagnostic disable-next-line:duplicate-set-field
function Date:hour(h) end

---set the minutes.
---@param min integer -- minutes
---@return PLDate self
---@diagnostic disable-next-line:duplicate-set-field
function Date:min(min) end

---set the seconds.
---@param sec integer -- seconds
---@return PLDate self
---@diagnostic disable-next-line:duplicate-set-field
function Date:sec(sec) end

---set the day of year.
---@param yday integer -- day of year
---@return PLDate self
---@diagnostic disable-next-line:duplicate-set-field
function Date:yday(yday) end

---get the year.
---@return integer
---@diagnostic disable-next-line:duplicate-set-field
function Date:year() end

---get the month.
---@return integer
---@diagnostic disable-next-line:duplicate-set-field
function Date:month() end

---get the day.
---@return integer
---@nodiscard
---@diagnostic disable-next-line:duplicate-set-field
function Date:day() end

---get the hour.
---@return integer
---@nodiscard
---@diagnostic disable-next-line:duplicate-set-field
function Date:hour() end

---get the minutes.
---@return integer
---@nodiscard
---@diagnostic disable-next-line:duplicate-set-field
function Date:min() end

---get the seconds.
---@return integer
---@nodiscard
---@diagnostic disable-next-line:duplicate-set-field
function Date:sec() end

---get the day of year.
---@return integer
---@nodiscard
---@diagnostic disable-next-line:duplicate-set-field
function Date:yday() end

---name of day of week.
---@param full boolean -- abbreviated if true, full otherwise.
---@return string -- name
---@nodiscard
function Date:weekday_name(full) end

---name of month.
---@param full boolean -- abbreviated if true, full otherwise.
---@return string -- name
---@nodiscard
function Date:month_name(full) end

---is this day on a weekend?
---@return boolean
---@nodiscard
function Date:is_weekend() end

---add to a date object.
---@param t osdate -- a table containing one of the following keys and a value: one of `year`, `month`, `day`, `hour`, `min`, `sec`
---@return PLDate self -- this date
function Date:add(t) end

---last day of the month.
---@return integer -- day
---@nodiscard
function Date:last_day() end

---difference between two `Date` objects.
---@param other PLDate -- Date object
---@return PLDateInterval -- object
---@nodiscard
function Date:diff(other) end

---long numerical ISO data format version of this date.
---@return string
---@nodiscard
function Date:__tostring() end

---equality between Date objects.
---@param other PLDate
---@return boolean
---@nodiscard
function Date:__eq(other) end

---ordering between Date objects.
---@param other PLDate
---@return boolean
---@nodiscard
function Date:__lt(other) end

---difference between Date objects.
---@param other PLDate
---@return PLDateInterval
function Date:__sub(other) end

---add a date and an interval.
---@param other PLDateInterval|osdate -- either a `PLDateInterval` object or a table such as passed to `Date:add`
---@return PLDate
function Date:__add(other) end

---@class PLDateInterval : PLClass
---@overload fun(t: integer): PLDateInterval
---Date.Interval constructor
---
--- @*param* `t` — an interval in seconds
local PLDateInterval = class()

---If it's an interval then the format is '2 hours 29 sec' etc.
---@return string
function PLDateInterval:__tostring() end

Date.Interval = PLDateInterval

---@class PLDateFormat : PLClass
---@overload fun(fmt: string): PLDateFormat
--- @*param* `fmt` — A string where the following fields are significant:
---
--- * `d`: day (either d or dd)
--- * `y`: year (either yy or yyy)
--- * `m`: month (either m or mm)
--- * `H`: hour (either H or HH)
--- * `M`: minute (either M or MM)
--- * `S`: second (either S or SS)
---
---Alternatively, if `fmt` is nil then this returns a flexible date parser that 
---tries various date/time schemes in turn:
---
--- * ISO 8601, like `2010-05-10 12:35:23Z` or `2008-10-03T14:30+02`
--- * times like 15:30 or 8.05pm (assumed to be today's date)
--- * dates like 28/10/02 (European order!) or 5 Feb 2012
--- * month name like march or Mar (case-insensitive, first 3 letters); here the day will be 1 and the year this current year
---
---A date in format 3 can be optionally followed by a time in format 2. Please see test-date.lua in the tests folder for more examples.
---
---Usage:
---
---```lua
---df = Date.Format("yyyy-mm-dd HH:MM:SS")
---```
local PLDateFormat = class()

---parse a string into a Date object.
---@param str string -- a date string
---@return PLDate -- date object
function PLDateFormat:parse(str) end

---convert a Date object into a string.
---@param d PLDate|integer -- a date object, or a time value as returned by os.time
---@return string
function PLDateFormat:tostring(d) end

---force US order in dates like 9/11/2001
---@param yesno boolean -- whether US order in dates are forced
function PLDateFormat:US_order(yesno) end

Date.Format = PLDateFormat

return Date