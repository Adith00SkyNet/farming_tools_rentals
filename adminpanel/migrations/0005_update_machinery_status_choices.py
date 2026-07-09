from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('adminpanel', '0004_rental_booking_model'),
    ]

    operations = [
        migrations.AlterField(
            model_name='machinery_model',
            name='status',
            field=models.CharField(choices=[('available', 'Available'), ('booked', 'Booked'), ('rented', 'Rented'), ('maintenance', 'Maintenance'), ('inactive', 'Inactive')], default='available', max_length=20),
        ),
    ]
