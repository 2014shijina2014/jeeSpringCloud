@echo off
rem /**
rem  */
echo.
echo [��Ϣ] �������ļ���
echo.
pause
echo.

cd /d %~dp0
cd..

call mvn clean

cd bin
pause