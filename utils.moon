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


{:getDoMsuffix, :formatDate, :getAge, :blankifyLinks, :stripHtml, :abbrCaps, :staticUrl}
