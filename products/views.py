from django.shortcuts import render
from django.views.generic import View, ListView
from products.models import *


# Create your views here.
class ProductListView(ListView):
    template_name = 'products_list.html'
    model = Product


class ProductAddView(View):
    pass


class ProductUpdateView(View):
    pass


class ProductDeleteView(View):
    pass
