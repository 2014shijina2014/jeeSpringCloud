@echo off
rem /**
rem  */
echo.
echo [��Ϣ] ����package�ļ���
echo.

cd /d %~dp0
cd..

call mvn package

cd bin
pause