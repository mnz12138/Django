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

#### 服务器端分页
注意服务器端数据的返回的格式

> [json]必须包含：total节点（总记录数），rows节点（分页后数据）  
> 即：{“total”:24,”rows”:[…]}s

#### 客户端分页
将sidePagination属性设为 “client”即可

服务器返回json数据必须包含data节点（展示数据）

> 当数据量较少，只有上千条数据时，一次性将所有数据返回给客户端，无论点下一页，或搜索条件时，不向服务端发请求，实现全文检索。
