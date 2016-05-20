html = require "lapis.html"
config = (require "lapis.config").get!
appname=config.appname or "KinkyEureka"

import gsplit,staticUrl,unent from require "utils"

import simple from require "lapis.nginx.http"

getcached = do
  local apicache
  ->
    unless apicache
      str,status=simple "https://partners.xhamster.com/2export.php?ch=!&pr=3&tcnt=1&ord=2&rt=2&url=mobile&em=3&dlm=%3B&tl=on&vid=on&ttl=on&chs=on&sz=on&dt=on"
      if status==200
        apicache=str
    apicache or nil

class Ads extends html.Widget
  buildAds: (csv,num=5)=>
    return nil unless csv
    for line in gsplit(csv,'\n')
      return if num <0
      num-=1
      if not line or line\sub(1,1)=="#"
        continue
      line = unent line
      div class: "advert", ->
        @buildAd [s for s in gsplit(line, ';')]
        br!
  buildAd: (ad)=>
    return nil unless ad
    {id, embed, thumb, url, title, tags, duration, date}=ad
    tags=[s for s in gsplit(tags, '|')]
    a href:url, target:'_blank', ->
      text title
      div class: 'info', ->
        if duration
          text duration .. " - "
        for tag in *tags[1,3]
          if tag
            i tag.." "
  content: =>
    script src: staticUrl"/js/ads.coffee.js"
    div class: "side-ads", id: "ads-right", ->
      span class: "adinfo", ->
        a href: "https://xhamster.com", target:"_blank", "Ads by xHamster"
      @buildAds getcached!
