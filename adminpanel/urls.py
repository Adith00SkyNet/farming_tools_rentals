from . import views
from django.urls import path, include

urlpatterns = [

    path('', views.adminpanel, name='adminpanel'),

    # category Insert
    path('category_insert/', views.category_insert, name='category_insert'),
    path('Category_Delete/<category_id>', views.Category_Delete, name='Category_Delete'),
    path('Category_Edit/<category_id>', views.Category_Edit, name='Category_Edit'),
    path('viewTable', views.category_view, name='category_view'),


    #district
    path('add_district/', views.add_district, name='add_district'),
    path('district_edit/<district_id>', views.district_Edit, name='district_edit'),
    path('district_delete/<district_id>', views.district_Delete, name='district_delete'),

    #branch location
    path('branch_location_insert/', views.branch_location_insert, name='branch_location_insert'),
    path('branch_location_edit/<branch_id>', views.branch_location_edit, name='branch_location_edit'),
    path('branch_location_delete/<branch_id>', views.branch_location_delete, name='branch_location_delete'),

    #machinery
    path('machinery_insert/', views.machinery_insert, name='machinery_insert'),
    path('machinery_edit/<machinery_id>', views.machinery_edit, name='machinery_edit'),
    path('machinery_delete/<machinery_id>', views.machinery_delete, name='machinery_delete'),

    #maintenance logs
    path('maintenance_log_insert/', views.maintenance_log_insert, name='maintenance_log_insert'),
    path('maintenance_log_edit/<maintain_id>', views.maintenance_log_edit, name='maintenance_log_edit'),
    path('maintenance_log_delete/<maintain_id>', views.maintenance_log_delete, name='maintenance_log_delete'),

    #insure policy
    path('insure_policy_insert/', views.insure_policy_insert, name='insure_policy_insert'),
    path('insure_policy_edit/<policy_id>', views.insure_policy_edit, name='insure_policy_edit'),
    path('insure_policy_delete/<policy_id>', views.insure_policy_delete, name='insure_policy_delete'),

    # rental booking
    path('rental_booking_insert/', views.rental_booking_insert, name='rental_booking_insert'),
    path('rental_booking_edit/<booking_id>', views.rental_booking_edit, name='rental_booking_edit'),
    path('rental_booking_delete/<booking_id>', views.rental_booking_delete, name='rental_booking_delete'),
    path('rental_booking_approve/<booking_id>', views.rental_booking_approve, name='rental_booking_approve'),
    path('rental_booking_reject/<booking_id>', views.rental_booking_reject, name='rental_booking_reject'),
    path('rental_booking_activate/<booking_id>', views.rental_booking_activate, name='rental_booking_activate'),
    path('rental_booking_complete/<booking_id>', views.rental_booking_complete, name='rental_booking_complete'),
    path('rental_invoice/<booking_id>', views.rental_invoice, name='rental_invoice'),
    path('rental_booking_mark_partial/<booking_id>', views.rental_booking_mark_partial, name='rental_booking_mark_partial'),
    path('rental_booking_mark_paid/<booking_id>', views.rental_booking_mark_paid, name='rental_booking_mark_paid'),
    path('rental_booking_mark_refunded/<booking_id>', views.rental_booking_mark_refunded, name='rental_booking_mark_refunded'),

]
