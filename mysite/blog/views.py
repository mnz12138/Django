from django.shortcuts import render, render_to_response
from django.http import HttpResponse, HttpResponseRedirect, JsonResponse
from django.template import loader
from django.core.exceptions import ValidationError
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.views.decorators.csrf import csrf_exempt
from django.db import connection
from blog.models import Blog, Author
from django.forms.models import model_to_dict

# Create your views here.

def showBlog(request, blogId, page=1):
    t = loader.get_template('blog.html')
    blog = Blog.objects.get(id=blogId)
    blog.counter+=1
    blog.save()
    context = {'blog': blog, 'page':page}
    html = t.render(context)
    return HttpResponse(html)

def showBlogList(request, page=0):
    if page==0:
        page = request.GET.get('page')
    blog_list = Blog.objects.order_by('-pubDate')
    paginator = Paginator(blog_list, 10) # Show 25 contacts per page
    try:
        blogs = paginator.page(page)
    except PageNotAnInteger:
        # If page is not an integer, deliver first page.
        blogs = paginator.page(1)
    except EmptyPage:
        # If page is out of range (e.g. 9999), deliver last page of results.
        blogs = paginator.page(paginator.num_pages)
    return render(request, "blog_list.html", {'blogs': blogs})

def toAddBlog(request, message=""):
    authors = Author.objects.all()
    return render(request, "blog_add.html", {"authors": authors, "message": message})

@csrf_exempt
def addBlog(request):
    if request.method == 'POST':
        title = request.POST['title']
        subTitle = request.POST['subTitle']
        content = request.POST['content']
        authorId = request.POST['authorId']
        if title=="" or content=="" or subTitle=="" or authorId=="" or authorId==0:
            return toAddBlog(request, "字段缺失")
        try:
            blog = Blog(title=title,subTitle=subTitle,content=content,author_id=authorId)
            blog.save()
            # 或者
            # Blog.objects.create(title=title,content=content,author_id=authorId)
            # return JsonResponse({"code": 200, "message": "新增成功"})
            return HttpResponseRedirect('/')
        except ValidationError:
            return toAddBlog(request)
    else:
        return toAddBlog(request, "只支持POST")

@csrf_exempt
def deleteBlog(request):
    if request.method == 'POST':
        blogId = request.POST['blogId']
        if blogId=="":
            return JsonResponse({"code": 10003, "message": "字段缺失"})
        try:
            Blog.objects.filter(id=blogId).delete()
            return JsonResponse({"code": 200, "message": "删除成功"})
        except ValidationError:
            return JsonResponse({"code": 10001, "message": "删除失败"})
    else:
        return JsonResponse({"code": 10002, "message": "请使用POST请求"})

def toUpdateBlog(request, blogId, message=""):
    authors = Author.objects.all()
    blog = Blog.objects.get(id=blogId)
    return render(request, "blog_edit.html", {"authors": authors, "blog":blog, "message":message})

# 接受from表单提交的token
# {% csrf_token %}会自动生成<input type='hidden' name='csrfmiddlewaretoken' value='64JUYFk9D2YTdd1MIC4UCB4cU3rKfKxp86IjPHd5acR9d0kWjqbm0HFerN9uGX3I' />
@csrf_exempt
def updateBlog(request):
    if request.method == 'POST':
        blogId = request.POST['blogId']
        title = request.POST['title']
        subTitle = request.POST['subTitle']
        content = request.POST['content']
        authorId = request.POST['authorId']
        if title=="" or content=="" or subTitle=="" or authorId=="" or authorId==0:
            return toUpdateBlog(request, blogId, "字段缺失")
        try:
            Blog.objects.filter(id=blogId).update(title=title,subTitle=subTitle,content=content,author_id=authorId)
            return HttpResponseRedirect('/')
        except ValidationError:
            return JsonResponse({"code": 10002, "message": "更新失败"})
    else:
        blogId = request.GET['blogId']
        return toUpdateBlog(request, blogId, "只支持POST")

def json(request):
    return render_to_response('json.html')

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
