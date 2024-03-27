# datwaft`s neovim configuration

## How to install git hooks?

We are using [`husky`](https://typicode.github.io/husky/) for installing the git hooks.

Execute the following command to install the git hooks:

```sh
npx husky
```

### Dependencies

For these git hooks we are using hooks that require some node packages installed globally in your system:

```sh
npm install --global @commitlint/{cli,config-conventional}
```
