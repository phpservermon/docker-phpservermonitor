
# PHPServerMonitor in Docker (`develop` Branch)



### Last update : 01/03/2017
#### Please open issues on [github](https://github.com/Quentinvarquet/docker-phpservermonitor/issues)


### PHPServerMonitor

[PHPServerMonitor](http://www.phpservermonitor.org/) is a script that checks whether your websites and servers are up and running. It comes with a web based user interface where you can manage your services and websites, and you can manage users for each server with a mobile number and email address.

### Docker

[Docker](https://www.docker.com/) allows you to package an application with all of its dependencies into a standardized unit for software development.

More information:

* [What is docker](https://www.docker.com/what-docker)
* [How to Create a Docker Business Case](https://www.brianchristner.io/how-to-create-a-docker-business-case/)

### Information

This is the unofficial (updated when I can !) repository for PHPServerMonitor

I will update the repository every time there is a new version of PHPServerMonitor available



### Supported tags and respective Dockerfile links


#### Example

```bash
docker run --name phpservermonitor -p 80:80 -d quentinv/phpservermonitor:latest
```


* **latest** : Last version of PHPServerMonitor

#### Tags

**For now, the only available tag is "latest"**

 [```latest```](https://github.com/Quentinvarquet/docker-phpservermonitor/blob/master/dockerfile/3.1.1/Dockerfile)


### Docker Compose

I created a docker-compose.yml with two containers : PhpServerMonitor and MySQL


#### Docker Compose files


[```latest```](https://github.com/Quentinvarquet/docker-phpservermonitor/blob/master/docker-compose/phpservermonitor-3.1.1/docker-compose.yml)


#### Database configuration


If you used my docker-compose.yml file you have to:

1 - Go on phpmyadmin : http://ip_of_your_server:81  (If you don't want to use phpmyadmin for security reasons you can just delete the container in my docker-compose.yml file and create your database with the command line from the container MySQL.)
2 - Create a database : monitor (you can use another name)
3 - Go on PhpServerMonitor : http://ip_of_your_server

![install](https://raw.githubusercontent.com/Quentinvarquet/docker-phpservermonitor/master/img/install.png)

* **Database Host:** mysql_container_name
* **Database Name:** monitor
* **Database User:** root
* **Data Password:** your_password
* **Table Previx:** psm_
