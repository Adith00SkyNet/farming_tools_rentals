from django import forms

from .models import customer_model


class customer_form(forms.ModelForm):
    Username = forms.CharField(label='Username', max_length=150)
    Password = forms.CharField(label='Password', widget=forms.PasswordInput)
    ConfirmPassword = forms.CharField(label='Confirm Password', widget=forms.PasswordInput)

    class Meta:
        model = customer_model
        fields = ('name', 'email', 'phone', 'Address')
        widgets = {
            'Address': forms.Textarea(attrs={'rows': 4}),
        }

    def clean(self):
        cleaned_data = super().clean()
        password = cleaned_data.get('Password')
        confirm_password = cleaned_data.get('ConfirmPassword')

        if password and confirm_password:
            if password != confirm_password:
                raise forms.ValidationError("Passwords do not match.")

        return cleaned_data
