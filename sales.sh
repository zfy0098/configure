#!/bin/bash

riqi=`date +%F-%T`

echo '更新业务员项目'

echo '进入 rhjf-root 目录'
cd /home/zfy/test/rhjf-root/

echo '更新svn 代码'
svn update

echo 'maven 打包命令'
mvn clean
mvn install



echo '进入 rhjf-modle 目录'
cd /home/zfy/test/rhjf-modle/

echo '更新svn代码'
svn update

echo 'maven 打包命令'
mvn clean
mvn install



echo '进入 salesman-core 目录'
cd /home/zfy/test/salesman-core/

echo '更新 svn 代码'
svn update

echo 'maven 打包命令'
mvn clean
mvn install




echo '进入 salesman-service 目录'
cd /home/zfy/test/salesman-service/

echo '更新 svn 代码'
svn update

echo 'maven 打包命令'
mvn clean
mvn install



echo '进入 salesman-web 目录'
cd /home/zfy/test/salesman-web/

echo '更新 svn 代码'
svn update

echo 'maven 打包命令'
mvn clean
mvn install


service="/usr/local/middlepay/salesman-service/webapps/salesman-service.war"
web="/usr/local/middlepay/salesman-web/webapps/salesman-web.war"


newservice="/home/zfy/sales/salesman-service.war${riqi}"
newweb="/home/zfy/sales/salesman-web.war${riqi}"


echo ' 拷贝 service 项目  , 将 tomcat 下的项目文件' $service ' copy  到' $newservice
cp $service $newservice

echo ' 拷贝 web 项目 ,  将 tomcat 下的项目文件' $web ' copy  到' $newweb
cp $web $newweb


#exit 1


salesmanService="/home/zfy/test/salesman-service/target/salesman-service.war"
salesmanWeb="/home/zfy/test/salesman-web/target/salesman-web.war"


webtomcat="/usr/local/middlepay/salesman-web/webapps/"

echo '关闭 salesman-web tomcat'
/usr/local/middlepay/salesman-web/bin/shutdown.sh

#echo '脚本暂停 3 秒'
#sleep 3 
#echo '脚本继续执行'

echo '删除 salesman-web tomcat 下的项目文件'
rm -rf /usr/local/middlepay/salesman-web/webapps/salesman-web*





servicetmcat="/usr/local/middlepay/salesman-service/webapps/"

echo '关闭 salesman-servie tomcat'
/usr/local/middlepay/salesman-service/bin/shutdown.sh 

echo '脚本暂停 5 秒'
sleep 5
echo '脚本继续执行'

echo '删除tomcat下的项目 salesman-servie'
rm -rf /usr/local/middlepay/salesman-service/webapps/salesman-service*

echo '拷贝项目： 将' $salesmanService '拷贝到:' $servicetmcat
cp $salesmanService $servicetmcat




servicetomcatPid=`ps -ef | grep tomcat | grep /usr/local/middlepay/salesman-service | awk '{print $2}'`


if  [ ! -n "$servicetomcatPid" ] ;then
    echo "service tomcat 已经停了"
else
    echo "service tomcat 还没有停 pid 为：" $servicetomcatPid

    kill -9 $servicetomcatPid
fi





echo '启动 salesman-servie tomcat'
/usr/local/middlepay/salesman-service/bin/startup.sh


echo '脚本暂停 3 秒'
sleep 3
echo '脚本继续执行'



echo '拷贝项目： 将'$salesmanWeb '拷贝到' $webtomcat
cp $salesmanWeb $webtomcat

echo '启动 salesman-web tomcat'
/usr/local/middlepay/salesman-web/bin/startup.sh

echo '到最后了'



