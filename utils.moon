getDoMsuffix=do
  suffixes={"st","nd","rd",default:"th"}
  (day)->
    suffixes[day % 10] or suffixes.default

formatDate=do
  months={"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"}
  (ymdstr,_dm,_y)->
    y,m,d=ymdstr\match "(%d%d%d%d)-(%d%d?)-(%d%d?)"
    (_dm and d..getDoMsuffix(d).." "..months[tonumber m] or "")..(_dm and _y and " " or "")..(_y and y or "")

getAge=(ymdstr)->
  y,m,d=ymdstr\match "(%d%d%d%d)-(%d%d?)-(%d%d?)"
  span=os.time()-os.time{year:y,month:m,day:d}
  (tonumber(os.date("%Y", span)) - 1970)

blankify_links=(htmlstr)->
  (htmlstr\gsub "<a href", "<a target=\"_blank\" href")

strip_html=(str)->
  (str\gsub "<[A-Za-z/!$][A-Za-z/!$ %-%_\"]*>", "")

{:getDoMsuffix, :formatDate, :getAge, :blankify_links, :strip_html}
