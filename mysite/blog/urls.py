from django.urls import path

from . import views
from . import apis

app_name = 'blog'

urlpatterns = [
    path('accounts/login/', apis.login, name='login'),
    path('accounts/logout/', apis.logout, name='logout'),
    # path('accounts/register/', apis.register, name='register'),

    path('toLogin/', views.toLogin, name='toLogin'),

    path('', views.toLogin, name=''),
    path('showBlogList', views.showBlogList, name='showBlogList'),
    path('blog/<int:blogId>', views.showBlog, name='showBlog'),
    path('toAddBlog', views.toAddBlog, name='toAddBlog'),
    path('addBlog', views.addBlog, name='addBlog'),
    path('deleteBlog', views.deleteBlog, name='deleteBlog'),
    path('toUpdateBlog', views.toUpdateBlog, name='toUpdateBlog'),
    path('updateBlog', views.updateBlog, name='updateBlog'),
    path('json', views.json, name='json'),

    path('getJSON', apis.getJSON, name='getJSON'),
    path('getAllJSON', apis.getAllJSON, name='getAllJSON'),

    path('getBlogList', apis.getBlogList, name='getBlogList'),
    path('loginVerify', apis.loginVerify, name='loginVerify')
]

