from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('adminpanel', '0005_update_machinery_status_choices'),
    ]

    operations = [
        migrations.AddField(
            model_name='rental_booking_model',
            name='payment_status',
            field=models.CharField(choices=[('unpaid', 'Unpaid'), ('partial', 'Partial'), ('paid', 'Paid'), ('refunded', 'Refunded')], default='unpaid', max_length=20),
        ),
    ]
