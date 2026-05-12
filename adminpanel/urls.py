from . import views
from django.urls import path, include

urlpatterns = [
    path('', views.adminpanel, name='adminpanel'),
    path('category_insert/', views.category_insert, name='category_insert'),
    path('Category_Delete/<category_id>', views.Category_Delete, name='Category_Delete'),
    path('Category_Edit/<category_id>', views.Category_Edit, name='Category_Edit'),
    path('viewTable', views.category_view, name='category_view'),

]
