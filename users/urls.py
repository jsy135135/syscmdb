from django.conf.urls import url
from users.views import *

urlpatterns = [
    url(r'^list/', UserListView.as_view(), name='user_list'),
    url(r'^add/', UserAddView.as_view(), name='user_add'),
    url(r'^update', UserUpdateView.as_view(), name='user_update'),
    url(r'^delete', UserDeleteView.as_view(), name='user_delete'),
    url(r'^status', UserStatusView.as_view(), name='user_status'),
    url(r'^group/list', GroupListView.as_view(), name='group_list'),
    url(r'^group/add', GroupAddView.as_view(), name='group_add'),
    url(r'^group/update', GroupUpdateView.as_view(), name='group_update'),
    url(r'^group/delete', GroupDeleteView.as_view(), name='group_delete'),
    url(r'^perm/list', PermListView.as_view(), name='perm_list'),
    url(r'^perm/user_set_perm', UserSetPermView.as_view(), name='user_set_perm'),
    url(r'^testdata/', TestDataView.as_view())
]
