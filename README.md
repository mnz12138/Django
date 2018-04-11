# Django
Django编写Web应用程序。

#### 启动服务

```
python manage.py runserver
```

指定IP和端口

```
python manage.py runserver 0.0.0.0:8080
```
0.0.0.0:8080任意的IP`settings.py`文件`ALLOWED_HOSTS = ['localhost', '127.0.0.1', '10.51.0.253']` 

#### 调试命令
```
python manage.py shell
```

#### 创建app
创建blog

```
python manage.py startapp blog
```

#### 迁移数据库
`settings.py`设置数据库连接

```
python manage.py makemigrations
python manage.py migrate
```

#### 查看所有命令

```
python manage.py
```
