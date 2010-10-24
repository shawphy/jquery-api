del dist /q /s
md dist
xcopy file dist /s
java -jar .\build\saxon9he.jar jQueryAPI.en_US.xml index.zh_CN.xsl>dist\index.html