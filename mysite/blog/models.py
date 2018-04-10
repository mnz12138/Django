from django.db import models

# Create your models here.
class Author(models.Model):
    name = models.CharField(max_length=50)
    age = models.IntegerField()

    def __unicode__(self):
        return self.name

class Blog(models.Model):
    title = models.CharField(max_length=50)
    content = models.TextField()
    counter = models.IntegerField(default=0)
    pubData = models.DateField(auto_now_add=True)
    author = models.ForeignKey(Author, on_delete=models.CASCADE)

    def __unicode__(self):
        return self.title