from django.db import models

# Create your models here.
class User(models.Model):
    username = models.CharField(max_length=150)
    last_login = models.DateField(null=True)
    is_superuser = models.BooleanField(default=False)
    password = models.CharField(max_length=128)
    first_name = models.CharField(max_length=30, default="")
    last_name = models.CharField(max_length=150, default="")
    email = models.CharField(max_length=254, default="")
    is_staff = models.BooleanField(default=False)
    is_active = models.BooleanField(default=False)
    date_joined = models.DateField(auto_now=True)

    def __unicode__(self):
        return self.username

class Author(models.Model):
    name = models.CharField(max_length=50)
    age = models.IntegerField()

    def __unicode__(self):
        return self.name

class Blog(models.Model):
    title = models.CharField(max_length=50)
    subTitle = models.CharField(max_length=200, null=True, default="")
    content = models.TextField()
    counter = models.IntegerField(default=0)
    pubDate = models.DateField(auto_now_add=True)
    author = models.ForeignKey(Author, on_delete=models.CASCADE)

    def __unicode__(self):
        return self.title
        
