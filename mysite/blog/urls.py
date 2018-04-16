from django.urls import path

from . import views
from . import apis

app_name = 'blog'

urlpatterns = [
    path('', views.showBlogList, name='showBlogList'),
    path('blog/<int:blogId>', views.showBlog, name='showBlog'),
    path('toAddBlog', views.toAddBlog, name='toAddBlog'),
    path('addBlog', views.addBlog, name='addBlog'),
    path('deleteBlog', views.deleteBlog, name='deleteBlog'),
    path('toUpdateBlog/<int:blogId>', views.toUpdateBlog, name='toUpdateBlog'),
    path('updateBlog', views.updateBlog, name='updateBlog'),
    path('json', views.json, name='json'),

    path('getJSON', apis.getJSON, name='getJSON'),
    path('getAllJSON', apis.getAllJSON, name='getAllJSON'),

    path('getBlogList', apis.getBlogList, name='getBlogList'),
]

