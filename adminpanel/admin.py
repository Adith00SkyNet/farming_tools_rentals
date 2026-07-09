from django.contrib import admin
from .models import (
    branch_location_model,
    category_model,
    district_model,
    insure_policy_model,
    machinery_model,
    maintenance_log_model,
    rental_booking_model,
)

# Register your models here.
admin.site.register(category_model)
admin.site.register(district_model)
admin.site.register(branch_location_model)
admin.site.register(machinery_model)
admin.site.register(maintenance_log_model)
admin.site.register(insure_policy_model)
admin.site.register(rental_booking_model)
