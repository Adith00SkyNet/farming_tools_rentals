from django.db import models

# Create your models here.
class category_model(models.Model):
    category=models.CharField(max_length=20)
    description=models.TextField(max_length=500)

    class Meta:
        db_table="category"


class district_model(models.Model):
    district=models.CharField(max_length=20)

    class Meta:
        db_table="district"
