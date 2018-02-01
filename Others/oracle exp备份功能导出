
rem **************************************
 rem 用于windows server 2003 做计划任务
 rem 使用Oracel exp备份功能导出
 rem *************************************
 @echo off
 rem ***备份库数据库文件到e:risen\backup\oracle数据库文件(%date:~0,10%).SQL
 rem ***注意数据库密码不要有特殊符号，例如“(”
 set hh=%time:~0,2%

 rem ***如果小时是一位的，那么在前面补零***
 if /i %hh% LSS 10 (set hh=0%time:~1,1%)
 set rq=%date:~0,4%%DATE:~5,2%%DATE:~8,2%
 set sj=%hh%%time:~3,2%
 set year=%date:~0,4%
 set month=%date:~5,2%
 set lastYear=%year%
 
 set name=sjcj
 set password=sjcj
 set owner=sjcj
 set filename=e:\risen\backup\oracle\%name%_%rq%_%sj%
 
 rem *** set /a lastMonth=%month%-1
 rem *** if /i %lastMonth% equ 0 (set /a lastMonth=12,lastYear=%year%-1)
 rem *** set lastFilename=e:risen\backup\oracle\govhrdb_%lastYear%%lastMonth%%DATE:~8,2%

E:\app\Administrator\product\11.2.0\dbhome_1\BIN\exp %name%/%password%@localhost/orcl file=%filename%.dmp owner=%owner% log=%filename%.log 

 rem ***启动WinRAR压缩*.dmp文件
 rem ***参数：-k:  锁定压缩文件
  rem  "C:\progra~1\winrar\winrar.exe" a -r -s -ibck %filename%.rar %filename%.dmp

 rem ***删除*.dmp文件和*.log文件
 rem *** 
 rem ***  del %filename%.dmp
 rem ***  del %lastFilename%.rar
 rem *** del e:risen\backup\oracle\nb_%rq%_%sj%.log

rem *** 输出目录下30天前的文件（forfiles命令xp系统中没有，需复制forfiles.exe文件到xp系统的system32文件夹中）
rem *** forfiles /p "e:risen\backup\oracle" /s /m *.txt /d -30 /c "cmd /c echo @path"
rem *** 删除目录下30天前的文件
rem *** forfiles /p "e:risen\backup\oracle" /s /m *.* /d -30 /c "cmd /c del @path"

rem  *通过window 2003 rktools工具包中的robocopy命令将本地文件夹镜像同步至异地服务器*
rem *** robocopy.exe "e:risen\backup\oracle" "\\JGQZWXXJH-QZJ\backup" /mir

rem ***结束***
rem ****************************************
rem ** pause
