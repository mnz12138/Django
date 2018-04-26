from django.urls import path

from . import views, apis, testViews

app_name = 'blog'

urlpatterns = [
    path('accounts/login/', apis.login, name='login'),
    path('accounts/logout/', apis.logout, name='logout'),
    # path('accounts/register/', apis.register, name='register'),

    path('toLogin/', views.toLogin, name='toLogin'),

    path('', views.toLogin, name=''),
    path('showBlogList', views.showBlogList, name='showBlogList'),
    path('showBlog', views.showBlog, name='showBlog'),
    path('toAddBlog', views.toAddBlog, name='toAddBlog'),
    path('toUpdateBlog', views.toUpdateBlog, name='toUpdateBlog'),
    path('json', views.json, name='json'),

    path('getJSON', apis.getJSON, name='getJSON'),
    path('getAllJSON', apis.getAllJSON, name='getAllJSON'),

    path('getBlogList', apis.getBlogList, name='getBlogList'),
    path('getBlog', apis.getBlog, name='getBlog'),
    path('addBlog', apis.addBlog, name='addBlog'),
    path('deleteBlog', apis.deleteBlog, name='deleteBlog'),
    path('updateBlog', apis.updateBlog, name='updateBlog'),
    path('editBlogColumn', apis.editBlogColumn, name="editBlogColumn"),

    path('getAllAuthor', apis.getAllAuthor, name="getAllAuthor"),
    
    path('loginVerify', apis.loginVerify, name='loginVerify'),

    path('test', testViews.test, name='test'),
]

