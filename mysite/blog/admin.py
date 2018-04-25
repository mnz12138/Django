from django.contrib import admin
from .models import Blog, Author

# Register your models here.

# 将Models加入到Admin管理中
admin.site.register(Blog)
admin.site.register(Author)
