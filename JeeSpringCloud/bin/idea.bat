@echo off
rem /**
rem  */
echo.
echo [��Ϣ] ����Eclipse�����ļ���
echo.

cd /d %~dp0
cd..

call mvn idea:idea

cd bin
pause