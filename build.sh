#!/bin/bash
set -e

echo "-- Cleanup previous build"
rm -f opus-volumio-plugin.zip
rm -rf serve-opus/opus-app
rm -rf serve-opus/public
mkdir serve-opus/public

echo "-- Fetch Opus app"
git clone https://github.com/kevwilde/opus-app.git serve-opus/opus-app/

echo "-- Build Opus app"
cd serve-opus/opus-app
npm i
bower install
ember build
cp -r dist/* ../public
cd ../..

echo "-- Prepare for packaging"
cd $(dirname "$0")
rm -rf serve-opus/opus-app
echo "-- Package plugin"
zip -r opus-volumio-plugin.zip *
echo "-- Done"
