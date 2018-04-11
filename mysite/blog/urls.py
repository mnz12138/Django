from django.urls import path

from . import views

app_name = 'blog'

urlpatterns = [
    path('', views.showBlogList, name='showBlogList'),
    path('blog/<int:blogId>', views.showBlog, name='showBlog'),
    path('toAddBlog', views.toAddBlog, name='toAddBlog'),
    path('addBlog', views.addBlog, name='addBlog'),
    path('deleteBlog/<int:blogId>', views.deleteBlog, name='deleteBlog'),
    path('toUpdateBlog/<int:blogId>', views.toUpdateBlog, name='toUpdateBlog'),
    path('updateBlog', views.updateBlog, name='updateBlog'),
    path('getJSON', views.getJSON, name='getJSON'),
]

