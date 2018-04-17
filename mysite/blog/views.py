from django.shortcuts import render, render_to_response
from django.http import HttpResponse, HttpResponseRedirect, JsonResponse
from django.template import loader
from django.core.exceptions import ValidationError
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.views.decorators.csrf import csrf_exempt
from django.db import connection
from blog.models import Blog, Author
from django.forms.models import model_to_dict
from django.contrib.auth.decorators import login_required

# Create your views here.
def toLogin(request):
    print('-----toLogin')
    return render(request, "login.html")

@login_required
def showBlog(request, blogId):
    t = loader.get_template('blog.html')
    blog = Blog.objects.get(id=blogId)
    blog.counter+=1
    blog.save()
    context = {'blog': blog}
    html = t.render(context)
    return request, HttpResponse(html)

@login_required
def showBlogList(request):
    return render(request, "blog_list.html")

@login_required
def toAddBlog(request, message=""):
    authors = Author.objects.all()
    return render(request, "blog_add.html", {"authors": authors, "message": message})

@csrf_exempt
@login_required
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
            return showBlogList(request)
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

@login_required
def toUpdateBlog(request, blogId=0, message=""):
    if blogId is None or blogId == 0:
        blogId = request.GET['blogId']
    authors = Author.objects.all()
    blog = Blog.objects.get(id=blogId)
    return render(request, "blog_edit.html", {"authors": authors, "blog":blog, "message":message})

# 接受from表单提交的token
# {% csrf_token %}会自动生成<input type='hidden' name='csrfmiddlewaretoken' value='64JUYFk9D2YTdd1MIC4UCB4cU3rKfKxp86IjPHd5acR9d0kWjqbm0HFerN9uGX3I' />
@csrf_exempt
@login_required
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
            return showBlogList(request)
        except ValidationError:
            return JsonResponse({"code": 10002, "message": "更新失败"})
    else:
        blogId = request.GET['blogId']
        return toUpdateBlog(request, blogId, "只支持POST")

def json(request):
    return render_to_response('json.html')
