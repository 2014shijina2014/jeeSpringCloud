@echo off
rem /**
rem  */
echo.
echo [��Ϣ] ����Eclipse�����ļ���
echo.

cd /d %~dp0
cd..

call mvn -Declipse.workspace=%cd% eclipse:eclipse

cd bin
pause