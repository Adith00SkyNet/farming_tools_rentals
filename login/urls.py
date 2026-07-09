from . import views
from django.urls import path, include

urlpatterns = [

    path('', views.login, name='login'),
    # Registration
    path('registration/', views.customer_registration, name='registration'),
    path('dashboard/', views.customer_dashboard, name='customer_dashboard'),
    path('machinery/', views.machinery_list, name='machinery_list'),
    path('machinery/<int:machinery_id>/', views.machinery_detail, name='machinery_detail'),
    path('machinery/<int:machinery_id>/book/', views.book_machinery, name='book_machinery'),
    path('my-bookings/', views.my_bookings, name='my_bookings'),
    path('categories/', views.customer_categories, name='customer_categories'),
    path('branches/', views.customer_branches, name='customer_branches'),
    path('profile/', views.customer_profile, name='customer_profile'),
    path('my-bookings/<int:booking_id>/cancel/', views.cancel_booking, name='cancel_booking'),


]
