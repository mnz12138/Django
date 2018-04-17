from django.shortcuts import render, render_to_response
from django.http import HttpResponse, HttpResponseRedirect, JsonResponse
from django.template import loader
from django.core.exceptions import ValidationError
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.views.decorators.csrf import csrf_exempt
from django.db import connection
from django.db.models import Q
from blog.models import Blog, Author
from django.forms.models import model_to_dict
from django.contrib.auth.decorators import login_required

from django.contrib.auth.models import User 
from django.contrib import auth
from django.contrib import messages
from django.template.context import RequestContext 

from .forms import LoginForm

def register(request):
    user = User.objects.create_user(username='admin',password='123456')
    if user is not None:
        return formatMessageJson(success=True, status=200, message="注册成功")
    else:
        return formatMessageJson(success=False, status=1004, message="注册失败")

def login(request):
    print('-----login')
    if request.method == 'GET':
        return formatMessageJson(success=False, message="请使用POST提交请求")
    else:
        username = request.POST.get('username','')
        password = request.POST.get('password','')
        user = auth.authenticate(username=username,password=password)
        if user is not None and user.is_active:
            auth.login(request,user)
            return formatMessageJson(success=True, status=200, message="登录成功")
        else:
            return formatMessageJson(success=False, status=1003, message="用户名或密码错误")

def logout(request):
    print('-----logout')
    auth.logout(request)
    return formatMessageJson(success=True, status=200, message="退出登录成功")

def formatPageJson(data=[], total=0):
    # import json
    # json = json.dumps(data, separators=(',', ':'), ensure_ascii=False)
    # print(json)
    print(len(data))
    try:
        return JsonResponse({"status": 200, "message": "调用成功", "total": total, "rows": data})
    except ValidationError:
        return JsonResponse({"status": 1001, "message": "调用失败", "total": total, "rows": data})

def formatJson(result, success=True):
    try:
        if success:
            return JsonResponse({"status": 200, "message": "调用成功", "result": result})
        else:
            return JsonResponse({"status": 1002, "message": "调用失败", "result": result})
    except ValidationError:
        return JsonResponse({"status": 1001, "message": "调用失败", "result": result})

def formatMessageJson(success=True, status=200, message="调用成功"):
    if success:
        return JsonResponse({"status": status, "message": message})
    else:
        return JsonResponse({"status": status, "message": message})

def loginVerify(request):
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']
        user = User.objects.filter(username=username, password=password)
        if user:
            request.session['username'] =  username
            return formatMessageJson(success=True, status=200, message="登录成功")
        else:
            return formatMessageJson(success=False, status=1003, message="用户名或密码错误")
    return formatMessageJson(success=False, message="请使用POST提交请求")

def getBlogList(request, offset=0, limit=10, search=''):
    print(str(request.GET))
    if request.method == 'GET':
        if 'offset' in request.GET.keys():
            offset = int(request.GET['offset'])
        if 'limit' in request.GET.keys():
            limit = int(request.GET['limit'])
        if 'search' in request.GET.keys():
            search = str(request.GET['search'])
    if limit > 20:
        limit = 20
    page = int(offset/limit)+1
    print(str(offset)+'-'+str(limit)+' page:'+str(page)+' search:'+search)
    blog_list = Blog.objects.filter(Q(title__contains=search) | Q(subTitle__contains=search)).order_by('-pubDate')
    paginator = Paginator(blog_list, limit) # Show 25 contacts per page
    try:
        blogs = paginator.page(page)
    except PageNotAnInteger:
        # If page is not an integer, deliver first page.
        blogs = paginator.page(1)
    except EmptyPage:
        # If page is out of range (e.g. 9999), deliver last page of results.
        blogs = paginator.page(paginator.num_pages)
    datas = []
    for blog in blogs:
        # 自定义key
        # blog['authorName'] = blog.pop('author__name')
        blogDict = model_to_dict(blog)
        blogDict['author_name'] = blog.author.name
        blogDict.pop('author')
        datas.append(blogDict)
    return formatPageJson(datas, paginator.count)

def getJSON(request):
    jsonResponse = JsonResponse({"message": "测试JSON"})
    return jsonResponse

def getAllJSON(request):
    # Manager.raw(raw_query, params=None, translations=None)
    # cursor = connection.cursor()
    # sql = "select * from blog_blog"
    # cursor.execute(sql)
    # # tuple(元祖)
    # blogs = cursor.fetchall()
    # return JsonResponse({"blogs": blogs})

    # blogs = Blog.objects.raw("select * from blog_blog")
    # datas = []
    # for blog in blogs:
    #     dict = {"title": blog.title}
    #     datas.append(dict)

    blogs = Blog.objects.all() #.values('title','subTitle','content','counter','pubDate','author__name')
    datas = []
    print(type(blogs))
    for blog in blogs:
        # 自定义key
        # blog['authorName'] = blog.pop('author__name')
        blogDict = model_to_dict(blog)
        blogDict['author_name'] = blog.author.name
        blogDict.pop('author')
        datas.append(blogDict)

    import json
    # separators指定分隔符
    json = json.dumps(datas, separators=(',', ':'), ensure_ascii=False)

    return HttpResponse(json)

