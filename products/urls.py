from django.conf.urls import url
from products.views import *

urlpatterns = [
    url(r'product/list', ProductListView.as_view(), name='product_list'),
    url(r'product/list', ProductAddView.as_view(), name='product_add'),
    url(r'product/list', ProductUpdateView.as_view(), name='product_update'),
    url(r'product/list', ProductDeleteView.as_view(), name='product_delete'),
]
