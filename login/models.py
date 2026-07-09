from django.contrib.auth.models import User
from django.db import models

# Create your models here.
class customer_model(models.Model):
    Login = models.OneToOneField(User, on_delete=models.CASCADE)
    name = models.CharField(max_length=100)
    email = models.EmailField()
    phone = models.BigIntegerField()
    Address = models.TextField()

    CreatedAt = models.DateTimeField(auto_now_add=True)
    UpdatedAt = models.DateTimeField(auto_now=True)


    def __str__(self):
        return f"{self.name} {self.email}"