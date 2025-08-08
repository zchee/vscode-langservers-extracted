#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# prepare
mkdir -p "${DIR}/../tmp"
mkdir -p "${DIR}/../dist"

# clone
cd "${DIR}/../tmp" || exit
git clone --depth=1 git@github.com:microsoft/vscode vscode

# pull
cd "${DIR}/../tmp/vscode" || exit
git clean -fd
git checkout .
git pull --rebase

# npm install
cd "${DIR}/../tmp/vscode" || exit
npm install
npm run compile

# copy to dist
cd "${DIR}/.." || exit

mkdir -p ./dist/css-language-server
cp -r ./tmp/vscode/extensions/css-language-features/server/out/* ./dist/css-language-server/
npx -y babel ./dist/css-language-server --out-dir ./lib/css-language-server/

mkdir -p ./dist/html-language-server
cp -r ./tmp/vscode/extensions/html-language-features/server/out/* ./dist/html-language-server/
npx -y babel ./dist/html-language-server --out-dir ./lib/html-language-server/

mkdir -p ./dist/json-language-server
cp -r ./tmp/vscode/extensions/json-language-features/server/out/* ./dist/json-language-server/
npx -y babel ./dist/json-language-server --out-dir ./lib/json-language-server/

mkdir -p ./dist/markdown-language-server
cp -r ./tmp/vscode/extensions/markdown-language-features/server/out/* ./dist/markdown-language-server/
npx -y babel ./dist/markdown-language-server --out-dir ./lib/markdown-language-server/
