# 虎妞网个人blog #

**系统**
Ubuntu 14.04

**start**

1. `git clone git@github.com:xiaozi0lei/dianying.git`
2. `sudo apt-get install postgresql libpq-dev ImageMagick libmagickcore-dev libmagickwand-dev default-jre`
3. `cd dianying; bundle install`
4. `sudo vi /etc/postgresql/9.3/main/pg_hba.conf`
  update the `local   all             postgres                                peer` to `local   all             postgres                                trust`
5. `sudo service postgresql restart`
6. `echo "ALTER USER postgres WITH PASSWORD 'postgres'" | psql -U postgres`
7. `source bin/dev_env`
8. `rake db:create`
9. `rake db:migrate`
10. `rake sunspot:solr:start`
11. `rails s`


配置sunspot注意事项：
sunspot_solr默认是在开发的时候使用的，如果需要在生产环境用这个gem自带的solr server，需要注意配置文件中(RAILS_PATH/config/sunspot.xml，这个配置文件我推测是指导sunspot_rails连接solr的配置)的一些细节

start solr:

rake sunspot:solr:start

stop solr:

rake sunspot:solr:stop

reindex solr:

rake sunspot:solr:reindex


```xml
production:
  solr:
  hostname: localhost\(<%=ENV['OPENSHIFT_INTERNAL_IP']%> for example: OPENSHIFT_RUBY_IP 如果在openshift上使用sunspot，此处一定要改变为openshift允许使用的内部IP，env | grep IP 得到的\)
    port: 8983
    log_level: WARNING
    path: /solr/default\(sunspot_solr默认的配置为production目录，但是提供的只有default目录。。。网上有人说坑die，我＋1吧\)
```

1. 启动指定IP地址和端口的solr daemon
cd app-root/repo; bundle exec sunspot-solr start -b $OPENSHIFT_INTERNAL_IP RAILS_ENV=production

关闭solr daemon的命令
cd app-root/repo; bundle exec sunspot-solr stop -b $OPENSHIFT_INTERNAL_IP RAILS_ENV=production

2. 重新生成index
cd app-root/repo; bundle exec rake sunspot:solr:reindex RAILS_ENV=production

3. 重启Rails程序，使配置生效

4. 需要在config目录下创建application.yml，添加github的id和key，重启app
