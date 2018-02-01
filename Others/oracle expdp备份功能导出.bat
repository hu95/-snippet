rem windows环境下Oracle数据库的自动备份脚本。
rem 可以将本批处理设成windows任务计划下自动执行。
@echo off
@echo ================================================
@echo  windows环境下Oracle数据库的自动备份脚本
@echo  说明：启动备份时，需要配置以下变量
@echo    1、ORACLE_USERNAME      指定备份所用的Oracle用户名
@echo    2、ORACLE_PASSWORD      指定备份所用的Oracle密码
@echo    3、ORACLE_DB            指定备份所用的Oracle连接名
@echo    4、BACK_OPTION          备份选项，可以为空，可以为full=y，可以为owner=a用户,b用户  等等....
@echo    5、RAR_CMD              指定RAR命令行压缩工具所在目录
@echo    6、DIR_NAME             指定要备份到哪个目录
@echo    6、DIR_PATH             备份目录路径
@echo    7、BACKUP_WAREHOUSE     历史备份文件存储路径
@echo    8、BACKFILE_NAME        备份文件名称（用户名_年月日时分秒.dmp）
@echo ================================================
set hh=%time:~0,2%

rem ***如果小时是一位的，那么在前面补零***
if /i %hh% LSS 10 (set hh=0%time:~1,1%)
set rq=%date:~0,4%%DATE:~5,2%%DATE:~8,2%
set sj=%hh%%time:~3,2%
set year=%date:~0,4%
set month=%date:~5,2%
set lastYear=%year%

rem 以下变量需要根据实际情况配置
set ORACLE_USERNAME=test
set ORACLE_PASSWORD=test
set ORACLE_DB=orcl
set BACK_OPTION="SCHEMAS=test"
set RAR_CMD="C:\Program Files\WinRAR\WinRAR.exe"
set DIR_NAME=DATA_PUMP_DIR
set DIR_PATH=E:\oracle\product\10.2.0\db_2\admin\orcl\dpdump\
set BACKUP_WAREHOUSE=D:\backup\oracle\expdp
rem for /f "tokens=1,2" %%a in ('date/t') do set TODAY=%%a
set BACKFILE_NAME=%ORACLE_USERNAME%_%rq%_%sj%
set BACKFILE_FULL_NAME=%BACKFILE_NAME%

rem 导出dmp文件
expdp %ORACLE_USERNAME%/%ORACLE_PASSWORD%@%ORACLE_DB% directory=%DIR_NAME% dumpfile=%BACKFILE_FULL_NAME%.dmp logfile=%BACKFILE_FULL_NAME%_exp.log %BACK_OPTION%

rem 压缩并删除原有文件
%RAR_CMD% a -df "%DIR_PATH%%BACKFILE_FULL_NAME%_back.rar" "%DIR_PATH%%BACKFILE_FULL_NAME%.dmp" "%DIR_PATH%%BACKFILE_FULL_NAME%_exp.log"

rem 移动压缩文件至备份目录
move %DIR_PATH%\%BACKFILE_FULL_NAME%_back.rar %BACKUP_WAREHOUSE%\

rem *** 输出目录下30天前的文件（forfiles命令xp系统中没有，需复制forfiles.exe文件到xp系统的system32文件夹中）
rem *** forfiles /p "d:\backup\oracle" /s /m *.txt /d -30 /c "cmd /c echo @path"
rem *** 删除目录下30天前的文件
rem *** forfiles /p "%BACKUP_WAREHOUSE%" /s /m *.* /d -30 /c "cmd /c del @path"

rem *通过window 2003 rktools工具包中的robocopy命令将本地文件夹镜像同步至异地服务器*
rem 需设置共享文件夹
rem *** robocopy.exe "D:\backup" "\\192.168.30.93\heda backup\oracle" /mir

 rem ***结束***
 rem ****************************************
pause
