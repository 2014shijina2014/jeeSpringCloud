@echo off
rem /**
rem  */
echo.
echo [��Ϣ] ���й����ļ���
echo.

cd /d %~dp0
cd ../target

java -jar JeeSpring-1.0.0-SNAPSHOT.war

cd bin
pause