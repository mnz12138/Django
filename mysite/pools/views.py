from django.http import HttpResponse
from django.shortcuts import render, render_to_response
from blog import apis

def index(request):
    json = apis.getTest()
    print(json)
    return render_to_response("index.html")
    # return HttpResponse("Hello, world. You're at the polls index.")
