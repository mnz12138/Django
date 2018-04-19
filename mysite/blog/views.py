from django.shortcuts import render, render_to_response
from django.http import HttpResponse, HttpResponseRedirect, JsonResponse
from django.urls import reverse
from django.template import loader
from django.core.exceptions import ValidationError
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.views.decorators.csrf import csrf_exempt
from django.db import connection
from blog.models import Blog, Author
from django.forms.models import model_to_dict
from django.contrib.auth.decorators import login_required

# Create your views here.

# return HttpResponseRedirect(reverse('blog:toLogin', args=(question.id,)))
def toLogin(request):
    print('-----toLogin')
    return render(request, "login.html")

@login_required
def showBlog(request, blogId=0):
    if blogId is None or blogId == 0:
        blogId = request.GET.get('blogId', 0)
    print(blogId)
    blog = Blog.objects.get(id=blogId)
    blog.counter+=1
    blog.save()
    return render(request, "blog.html", {"blog": blog})

@login_required
def showBlogList(request):
    return render(request, "blog_list.html")

@login_required
def toAddBlog(request, message=""):
    authors = Author.objects.all()
    return render(request, "blog_add.html", {"authors": authors, "message": message})

@login_required
def toUpdateBlog(request, blogId=0, message=""):
    if blogId is None or blogId == 0:
        blogId = request.GET['blogId']
    authors = Author.objects.all()
    blog = Blog.objects.get(id=blogId)
    return render(request, "blog_edit.html", {"authors": authors, "blog":blog, "message":message})

def json(request):
    return render_to_response('json.html')
