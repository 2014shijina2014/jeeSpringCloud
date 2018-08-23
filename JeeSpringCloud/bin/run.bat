@echo off
rem /**
rem  */
echo.
echo [信息] 运行工程文件。
echo.

cd /d %~dp0
cd ../target

java -jar JeeSpring-1.0.0-SNAPSHOT.war

cd bin
pause