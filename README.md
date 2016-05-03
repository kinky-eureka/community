# KinkyEureka community
[![Issues Ready](https://badge.waffle.io/kinky-eureka/community.svg?label=ready&title=Issues%20Ready)](http://waffle.io/kinky-eureka/community) [![In Progress](https://badge.waffle.io/kinky-eureka/community.svg?label=in%20progress&title=In%20Progress)](http://waffle.io/kinky-eureka/community)

## setup

    git submodule update --init --recursive
    lib/lazuli/setup.zsh
    lib/lazuli/luarocks install markdown

then copy `config.moon` to `custom_config.moon`, edit it and run:

    lib/lazuli/mk <environment>
    lib/lazuli/lapis server <environment>

where `<environment>` is one of `development`, `test` or `production`.


## gitflow

    gitflow.branch.master=deploy
    gitflow.branch.develop=master
    gitflow.prefix.feature=feature/
    gitflow.prefix.release=release/
    gitflow.prefix.hotfix=hotfix/
    gitflow.prefix.support=support/
    gitflow.prefix.versiontag=v

