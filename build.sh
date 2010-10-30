rm -f -r dist
cp -r file dist
java -jar ./build/saxon9he.jar jQueryAPI.en_US.xml index.zh_CN.xsl>dist/index.html
