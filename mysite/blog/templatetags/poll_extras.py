from django import template
from django.template.defaultfilters import stringfilter

register = template.Library()

@register.filter(name='cut')
def cut(value, arg):
    return value.replace(arg, '')

@register.filter
@stringfilter
def lower(value): # Only one argument.
    return value.lower()

# 注册过滤器
# register.filter('cut', cut)
# register.filter('lower', lower)
