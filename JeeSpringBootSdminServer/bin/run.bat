@echo off
rem /**
rem  */
echo.
echo [��Ϣ] ���й����ļ���
echo.

cd /d %~dp0
cd ../target

java -jar springboot-admin-server-0.0.1-SNAPSHOT.jar

cd bin
pause