# community
the main project

## setup

    git submodule update --init --recursive
    lib/lazuli/setup.zsh
    lib/lazuli/luarocks install markdown

then copy `config.moon` to `custom_config.moon`, edit it and run:

    lib/lazuli/mk <environment>
    lib/lazuli/lapis server <environment>

where `<environment>` is one of `development`, `test` or `production`.
