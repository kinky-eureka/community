html = require "lapis.html"
config = (require "lapis.config").get!
appname=config.appname or "KinkyEureka"

import staticUrl from require "utils"

class Favicon extends html.Widget
  content: =>
    link rel:"apple-touch-icon", sizes:"57x57",   href: staticUrl"/favicon/apple-touch-icon-57x57.png"
    link rel:"apple-touch-icon", sizes:"60x60",   href: staticUrl"/favicon/apple-touch-icon-60x60.png"
    link rel:"apple-touch-icon", sizes:"72x72",   href: staticUrl"/favicon/apple-touch-icon-72x72.png"
    link rel:"apple-touch-icon", sizes:"76x76",   href: staticUrl"/favicon/apple-touch-icon-76x76.png"
    link rel:"apple-touch-icon", sizes:"114x114", href: staticUrl"/favicon/apple-touch-icon-114x114.png"
    link rel:"apple-touch-icon", sizes:"120x120", href: staticUrl"/favicon/apple-touch-icon-120x120.png"
    link rel:"apple-touch-icon", sizes:"144x144", href: staticUrl"/favicon/apple-touch-icon-144x144.png"
    link rel:"apple-touch-icon", sizes:"152x152", href: staticUrl"/favicon/apple-touch-icon-152x152.png"
    link rel:"apple-touch-icon", sizes:"180x180", href: staticUrl"/favicon/apple-touch-icon-180x180.png"
    
    link rel:"icon", type:"image/png", href: staticUrl"/favicon/favicon-32x32.png",          sizes:"32x32"
    link rel:"icon", type:"image/png", href: staticUrl"/favicon/android-chrome-192x192.png", sizes:"192x192"
    link rel:"icon", type:"image/png", href: staticUrl"/favicon/favicon-96x96.png",          sizes:"96x96"
    link rel:"icon", type:"image/png", href: staticUrl"/favicon/favicon-16x16.png",          sizes:"16x16"
    
    link rel:"manifest", href: staticUrl"/favicon/manifest.json"
    
    link rel:"mask-icon", href: staticUrl"/favicon/safari-pinned-tab.svg", color:"#171010"
    
    link rel:"shortcut icon", href: staticUrl"/favicon/favicon.ico"
    
    meta name:"apple-mobile-web-app-title", content:appname
    meta name:"application-name",           content:appname
    
    meta name:"msapplication-TileColor", content:"#000000"
    meta name:"msapplication-TileImage", content: staticUrl"/favicon/mstile-144x144.png"
    meta name:"msapplication-config",    content: staticUrl"/favicon/browserconfig.xml"
    
    meta name:"theme-color", content:"#171010"
