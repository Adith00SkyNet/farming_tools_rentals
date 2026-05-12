from django import forms

from .models import category_model


class category_form(forms.ModelForm):

    class Meta:
        model=category_model
        fields=('category','description',)