from django.shortcuts import render, render_to_response
from django.http import HttpResponse, HttpResponseRedirect, JsonResponse
from django.template import loader
from django.core.exceptions import ValidationError
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.views.decorators.csrf import csrf_exempt
from blog.models import Blog, Author

# Create your views here.

def showBlog(request, blogId):
    t = loader.get_template('blog.html')
    blog = Blog.objects.get(id=blogId)
    blog.counter+=1
    blog.save()
    context = {'blog': blog}
    html = t.render(context)
    return HttpResponse(html)

def showBlogList(request):
    page = request.GET.get('page')
    blog_list = Blog.objects.all()
    paginator = Paginator(blog_list, 2) # Show 25 contacts per page
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

def addBlog(request):
    if request.method == 'POST':
        title = request.POST['title']
        content = request.POST['content']
        authorId = request.POST['authorId']
        if title=="" or content=="" or authorId=="" or authorId==0:
            return toAddBlog(request, "字段缺失")
        try:
            blog = Blog(title=title,content=content,author_id=authorId)
            blog.save()
            # 或者
            # Blog.objects.create(title=title,content=content,author_id=authorId)
            # return JsonResponse({"code": 200, "message": "新增成功"})
            return HttpResponseRedirect('/')
        except ValidationError:
            return toAddBlog(request)
    else:
        return toAddBlog(request, "只支持POST")

def deleteBlog(request, blogId):
    try:
        Blog.objects.filter(id=blogId).delete()
        return JsonResponse({"code": 200, "message": "删除成功"})
    except ValidationError:
        return JsonResponse({"code": 10001, "message": "删除失败"})

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
        content = request.POST['content']
        authorId = request.POST['authorId']
        if title=="" or content=="" or authorId=="" or authorId==0:
            return toUpdateBlog(request, blogId, "字段缺失")
        try:
            Blog.objects.filter(id=blogId).update(title=title,content=content,author_id=authorId)
            return HttpResponseRedirect('/')
        except ValidationError:
            return JsonResponse({"code": 10002, "message": "更新失败"})
    else:
        blogId = request.GET['blogId']
        return toUpdateBlog(request, blogId, "只支持POST")

def json(request):
    # return render_to_response('json.html')
    return render(request, 'json.html', locals())

def getJSON(request):
    jsonResponse = JsonResponse({"message": "测试JSON"})
    return jsonResponse
