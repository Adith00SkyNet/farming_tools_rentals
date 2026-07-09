from datetime import date

from django.contrib.auth import authenticate,login as auth_login
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.http import HttpResponseRedirect, HttpResponse
from django.shortcuts import render, get_object_or_404
from django.core.paginator import Paginator
from django.db import models

from adminpanel.models import (
    branch_location_model,
    category_model,
    district_model,
    machinery_model,
    rental_booking_model,
)
from login.models import customer_model

from .loginForms import customer_form


# Create your views here.


def customer_nav_context():
    return {
        'categories_nav': category_model.objects.all(),
    }



def customer_registration(request):
    context = {}
    frm = customer_form(request.POST or None)
    if frm.is_valid():
        # Create user in Auth_user table
        username = frm.cleaned_data['Username']
        password = frm.cleaned_data['Password']

        # Create Django User
        loginobj = User.objects.create_user(
            username=username,
            password=password
        )

        # Save technician
        obj = frm.save(commit=False)
        obj.Login = loginobj
        obj.save()


        return HttpResponseRedirect('/')
    context['form'] = frm
    return render(request, 'customer_registration.html', context)


def login(request):
    if request.method == "POST":
        uname = request.POST.get("Username")
        pd = request.POST.get("pwd")

        user_obj = authenticate(username=uname, password=pd)

        if user_obj is not None:
            auth_login(request, user_obj)

            if user_obj.is_superuser is True:
                return HttpResponseRedirect('/adminpanel')
            else:
                return HttpResponseRedirect('/machinery/')

        else:

            return HttpResponse("<script>alert('Invalid Credential !!!');window.location='/';</script>")

    return render(request, 'login.html')


@login_required(login_url='/')
def machinery_list(request):
    context = customer_nav_context()
    dataset = machinery_model.objects.select_related('branch', 'category', 'branch__district').all()

    category_id = request.GET.get('category')
    district_id = request.GET.get('district')
    status = request.GET.get('status')
    min_price = request.GET.get('min_price')
    max_price = request.GET.get('max_price')
    query = request.GET.get('q')

    if category_id:
        dataset = dataset.filter(category_id=category_id)
    if district_id:
        dataset = dataset.filter(branch__district_id=district_id)
    if status:
        dataset = dataset.filter(status=status)
    if min_price:
        dataset = dataset.filter(base_price_day__gte=min_price)
    if max_price:
        dataset = dataset.filter(base_price_day__lte=max_price)
    if query:
        dataset = dataset.filter(
            models.Q(name__icontains=query)
            | models.Q(model__icontains=query)
            | models.Q(specific__icontains=query)
            | models.Q(category__category__icontains=query)
            | models.Q(branch__location__icontains=query)
        )

    paginator = Paginator(dataset.order_by('id'), 6)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    context['page_obj'] = page_obj
    context['dataset'] = page_obj.object_list
    context['page_range'] = page_obj.paginator.get_elided_page_range(number=page_obj.number)
    context['categories'] = category_model.objects.all()
    context['districts'] = district_model.objects.all()
    context['status_choices'] = machinery_model.STATUS_CHOICES
    context['selected_category'] = category_id or ''
    context['selected_district'] = district_id or ''
    context['selected_status'] = status or ''
    context['selected_min_price'] = min_price or ''
    context['selected_max_price'] = max_price or ''
    context['selected_query'] = query or ''
    return render(request, 'customer_machinery_list.html', context)


@login_required(login_url='/')
def customer_dashboard(request):
    context = customer_nav_context()
    context['machinery_count'] = machinery_model.objects.count()
    context['available_count'] = machinery_model.objects.filter(status='available').count()
    context['booking_count'] = rental_booking_model.objects.filter(customer=request.user).count()
    context['pending_count'] = rental_booking_model.objects.filter(customer=request.user, status='pending').count()
    context['completed_count'] = rental_booking_model.objects.filter(customer=request.user, status='completed').count()
    context['latest_bookings'] = rental_booking_model.objects.select_related('machinery').filter(customer=request.user).order_by('-created_at')[:5]
    context['latest_machinery'] = machinery_model.objects.select_related('branch', 'category').all()[:6]
    return render(request, 'customer_dashboard.html', context)


@login_required(login_url='/')
def customer_categories(request):
    context = customer_nav_context()
    context['dataset'] = category_model.objects.all()
    return render(request, 'customer_categories.html', context)


@login_required(login_url='/')
def customer_branches(request):
    context = customer_nav_context()
    context['dataset'] = branch_location_model.objects.select_related('district').all()
    return render(request, 'customer_branches.html', context)


@login_required(login_url='/')
def customer_profile(request):
    context = customer_nav_context()
    profile = customer_model.objects.select_related('Login').filter(Login=request.user).first()
    context['obj'] = profile
    return render(request, 'customer_profile.html', context)


@login_required(login_url='/')
def machinery_detail(request, machinery_id):
    context = customer_nav_context()
    machinery = get_object_or_404(machinery_model.objects.select_related('branch', 'category'), id=machinery_id)
    context['obj'] = machinery
    return render(request, 'customer_machinery_detail.html', context)


@login_required(login_url='/')
def book_machinery(request, machinery_id):
    machinery = get_object_or_404(machinery_model, id=machinery_id)
    context = {'obj': machinery}

    if request.method == 'POST':
        start_date = request.POST.get('start_date')
        end_date = request.POST.get('end_date')

        if not start_date or not end_date:
            context['error'] = 'Start date and end date are required.'
            return render(request, 'customer_machinery_detail.html', context)

        start = date.fromisoformat(start_date)
        end = date.fromisoformat(end_date)
        days = (end - start).days + 1

        if days <= 0:
            context['error'] = 'End date must be after start date.'
            return render(request, 'customer_machinery_detail.html', context)

        if machinery.status.lower() != 'available':
            context['error'] = 'This machinery is not available for booking.'
            return render(request, 'customer_machinery_detail.html', context)

        has_overlap = rental_booking_model.objects.filter(
            machinery=machinery,
            status__in=['pending', 'approved', 'active'],
            start_date__lte=end,
            end_date__gte=start,
        ).exists()

        if has_overlap:
            context['error'] = 'This machinery is already booked for the selected dates.'
            return render(request, 'customer_machinery_detail.html', context)

        total_price = days * machinery.base_price_day

        rental_booking_model.objects.create(
            customer=request.user,
            machinery=machinery,
            start_date=start,
            end_date=end,
            status='pending',
            total_price=total_price,
        )
        return HttpResponseRedirect('/machinery/')

    return render(request, 'customer_machinery_detail.html', context)


@login_required(login_url='/')
def my_bookings(request):
    context = customer_nav_context()
    context['dataset'] = rental_booking_model.objects.select_related('machinery').filter(customer=request.user).order_by('-created_at')
    return render(request, 'customer_booking_history.html', context)


@login_required(login_url='/')
def cancel_booking(request, booking_id):
    booking = get_object_or_404(rental_booking_model, id=booking_id, customer=request.user)

    if request.method == 'POST' and booking.status == 'pending':
        booking.status = 'cancelled'
        booking.save(update_fields=['status'])

    return HttpResponseRedirect('/my-bookings/')
