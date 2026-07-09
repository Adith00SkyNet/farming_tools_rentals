from django import forms

from .models import (
    branch_location_model,
    category_model,
    district_model,
    insure_policy_model,
    machinery_model,
    maintenance_log_model,
    rental_booking_model,
)


class category_form(forms.ModelForm):

    class Meta:
        model=category_model
        fields=('category','description',)


class district_form(forms.ModelForm):

    class Meta:
        model=district_model
        fields=('district',)


class branch_location_form(forms.ModelForm):
    district = forms.ModelChoiceField(
        queryset=district_model.objects.all(),
        empty_label="Select District"
    )

    class Meta:
        model=branch_location_model
        fields=('address','district','location','postal_code',)


class machinery_form(forms.ModelForm):
    class Meta:
        model=machinery_model
        fields=(
            'branch',
            'category',
            'name',
            'model',
            'year',
            'specific',
            'base_price_day',
            'status',
            'created_at',
            'gst',
            'img_url1',
            'img_url2',
        )
        widgets={
            'created_at': forms.DateInput(attrs={'type': 'date'}),
            'status': forms.Select(),
        }


class maintenance_log_form(forms.ModelForm):

    class Meta:
        model=maintenance_log_model
        fields=('machinery','descr','service_date','cost','next_due_date',)
        widgets={
            'service_date': forms.DateInput(attrs={'type': 'date'}),
            'next_due_date': forms.DateInput(attrs={'type': 'date'}),
        }


class insure_policy_form(forms.ModelForm):

    class Meta:
        model=insure_policy_model
        fields=(
            'machinery',
            'provider_name',
            'policy_no',
            'start_date',
            'end_date',
            'coverage_detail',
        )
        widgets={
            'start_date': forms.DateInput(attrs={'type': 'date'}),
            'end_date': forms.DateInput(attrs={'type': 'date'}),
        }


class rental_booking_form(forms.ModelForm):

    class Meta:
        model = rental_booking_model
        fields = (
            'customer',
            'machinery',
            'start_date',
            'end_date',
            'status',
            'payment_status',
            'total_price',
        )
        widgets = {
            'start_date': forms.DateInput(attrs={'type': 'date'}),
            'end_date': forms.DateInput(attrs={'type': 'date'}),
        }
