getDoMsuffix=do
  suffixes={"st","nd","rd",default:"th"}
  (day)->
    suffixes[day % 10] or suffixes.default

formatDate=do
  months={"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"}
  (ymdstr,_dm,_y)->
    y,m,d=ymdstr\match "(%d%d%d%d)-(%d%d?)-(%d%d?)"
    (_dm and d..getDoMsuffix(d).." of "..months[tonumber m] or "")..(_dm and _y and " " or "")..(_y and y or "")

getAge=(ymdstr)->
  y,m,d=ymdstr\match "(%d%d%d%d)-(%d%d?)-(%d%d?)"
  span=os.time()-os.time{year:y,month:m,day:d}
  (tonumber(os.date("%Y", span)) - 1970)

blankifyLinks=(htmlstr)->
  (htmlstr\gsub "<a href", "<a target=\"_blank\" href")

stripHtml=(str)->
  (str\gsub "<[A-Za-z/!$][A-Za-z/!$ %-%_\"]*>", "")

abbrCaps=(str)->
  ( str\gsub "[^%u]*(%u?)(%u*)[^%u]*", (a,b) -> a .. b\lower! )

staticUrl = do
  config = require"lapis.config".get!
  (str) -> ( config.static_url_prefix or "/static" ) .. str

gsplit = (sep, plain)=> -- if you want to split to table, just [s for s in *gsplit]
  @=tostring @
  start = 1
  done = false
  pass=(i, j, ...)->
    if i
      seg = @\sub(start, i - 1)
      start = j + 1
      return seg, ...
    else
      done = true
      return @\sub(start)
  return ->
    return if done
    if sep == ''
      done = true
      return @
    return pass @\find sep, start, plain


unent = do
  char = string.char
  tail=(n, k)->
    local r
    u=''
    for i=1,k do
      n,r = math.floor(n/0x40), n%0x40
      u = char(r+0x80) .. u
    return u, n
  lookup=(a) ->
    local r,u
    n = tonumber(a)
    if n<0x80 then                        -- 1 byte
      return char(n)
    elseif n<0x800 then                   -- 2 byte
      u, n = tail(n, 1)
      return char(n+0xc0) .. u
    elseif n<0x10000 then                 -- 3 byte
      u, n = tail(n, 2)
      return char(n+0xe0) .. u
    elseif n<0x200000 then                -- 4 byte
      u, n = tail(n, 3)
      return char(n+0xf0) .. u
    elseif n<0x4000000 then               -- 5 byte
      u, n = tail(n, 4)
      return char(n+0xf8) .. u
    else                                  -- 6 byte
      u, n = tail(n, 5)
      return char(n+0xfc) .. u
  (str) -> string.gsub(str, '&#(%d+);', lookup)


{:getDoMsuffix, :formatDate, :getAge, :blankifyLinks, :stripHtml, :abbrCaps, :staticUrl, :gsplit, :unent}
