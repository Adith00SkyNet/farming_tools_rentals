from django.db import models
from django.contrib.auth.models import User

# Create your models here.
class category_model(models.Model):
    category=models.CharField(max_length=20)
    description=models.TextField(max_length=500)

    def __str__(self):
        return self.category

    class Meta:
        db_table="category"


class district_model(models.Model):
    district=models.CharField(max_length=20)

    def __str__(self):
        return self.district

    class Meta:
        db_table="district"


class branch_location_model(models.Model):
    address=models.CharField(max_length=50)
    district=models.ForeignKey(district_model, on_delete=models.CASCADE)
    location=models.CharField(max_length=30)
    postal_code=models.CharField(max_length=20)

    def __str__(self):
        return f"{self.location} - {self.district}"

    class Meta:
        db_table="branch_location"


class machinery_model(models.Model):
    STATUS_CHOICES = (
        ("available", "Available"),
        ("booked", "Booked"),
        ("rented", "Rented"),
        ("maintenance", "Maintenance"),
        ("inactive", "Inactive"),
    )

    branch=models.ForeignKey(branch_location_model, on_delete=models.CASCADE)
    category=models.ForeignKey(category_model, on_delete=models.CASCADE)
    name=models.CharField(max_length=150)
    model=models.CharField(max_length=100)
    year=models.CharField(max_length=20)
    specific=models.CharField(max_length=150)
    base_price_day=models.IntegerField()
    status=models.CharField(max_length=20, choices=STATUS_CHOICES, default="available")
    created_at=models.DateField()
    gst=models.CharField(max_length=20)
    img_url1=models.CharField(max_length=100)
    img_url2=models.CharField(max_length=100)

    def __str__(self):
        return f"{self.name} - {self.model}"

    class Meta:
        db_table="machinery"


class maintenance_log_model(models.Model):
    machinery=models.ForeignKey(machinery_model, on_delete=models.CASCADE)
    descr=models.CharField(max_length=150)
    service_date=models.DateField()
    cost=models.IntegerField()
    next_due_date=models.DateField()

    def __str__(self):
        return f"{self.machinery} - {self.service_date}"

    class Meta:
        db_table="maintenance_logs"


class insure_policy_model(models.Model):
    machinery=models.ForeignKey(machinery_model, on_delete=models.CASCADE)
    provider_name=models.CharField(max_length=30)
    policy_no=models.CharField(max_length=50)
    start_date=models.DateField()
    end_date=models.DateField()
    coverage_detail=models.CharField(max_length=150)

    def __str__(self):
        return f"{self.policy_no} - {self.provider_name}"

    class Meta:
        db_table="insure_policy"


class rental_booking_model(models.Model):
    PAYMENT_STATUS_CHOICES = (
        ("unpaid", "Unpaid"),
        ("partial", "Partial"),
        ("paid", "Paid"),
        ("refunded", "Refunded"),
    )

    STATUS_CHOICES = (
        ("pending", "Pending"),
        ("approved", "Approved"),
        ("rejected", "Rejected"),
        ("active", "Active"),
        ("completed", "Completed"),
        ("cancelled", "Cancelled"),
    )

    customer = models.ForeignKey(User, on_delete=models.CASCADE)
    machinery = models.ForeignKey(machinery_model, on_delete=models.CASCADE)
    start_date = models.DateField()
    end_date = models.DateField()
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default="pending")
    payment_status = models.CharField(max_length=20, choices=PAYMENT_STATUS_CHOICES, default="unpaid")
    total_price = models.IntegerField(default=0)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.customer.username} - {self.machinery} - {self.status}"

    class Meta:
        db_table = "rental_booking"
