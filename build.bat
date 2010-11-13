del dist\*.html /q /s
del dist\*.js /q /s
del dist\*.png /q /s
del dist\*.css /q /s
del dist\*.jpg /q /s
del dist\*.gif /q /s
xcopy file dist /s
java -jar .\build\saxon9he.jar jQueryAPI.en_US.xml index.zh_CN.xsl>dist\index.html
pause
