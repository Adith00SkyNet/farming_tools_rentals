from django.shortcuts import render, redirect, get_object_or_404

from .adminForms import (
    branch_location_form,
    category_form,
    district_form,
    insure_policy_form,
    machinery_form,
    maintenance_log_form,
    rental_booking_form,
)
from .models import (
    branch_location_model,
    category_model,
    district_model,
    insure_policy_model,
    machinery_model,
    maintenance_log_model,
    rental_booking_model,
)


# Create your views here.
def adminpanel(request):
    return render(request, 'admin_header.html')


#category controllers
def category_insert(request):
    context = {}
    form = category_form(request.POST or None,request.FILES or None)
    if form.is_valid():
        form.save()
        return redirect(category_insert)
    context['f'] = form
    context['dataset'] = category_model.objects.all()
    return render(request, "category_insert.html", context)

def Category_Edit(request,category_id):
    context = {}
    obj = get_object_or_404(category_model, id=category_id)
    form = category_form(request.POST or None, instance=obj)
    if form.is_valid():
        form.save()
        return redirect(category_insert)
    context['f'] = form
    return render(request, 'category_insert.html', context)

def Category_Delete(request,category_id):
    if request.method != 'POST':
        return redirect(category_insert)
    context={}
    obj=get_object_or_404(category_model,id=category_id)
    obj.delete()
    return redirect(category_insert)

def category_view(request):
    context = {}
    context['dataset'] = category_model.objects.all()
    return render(request, "category_view.html", context)


#district Controllers

def add_district(request):
    context = {}
    form = district_form(request.POST or None)
    if form.is_valid():
        form.save()
        return redirect(add_district)
    context['f'] = form
    context['dataset'] = district_model.objects.all()
    return render(request, 'add_district.html', context)


def district_Delete(request,district_id):
    if request.method != 'POST':
        return redirect(add_district)
    context={}
    obj=get_object_or_404(district_model,id=district_id)
    obj.delete()
    return redirect(add_district)

def district_Edit(request,district_id):
    context = {}
    obj = get_object_or_404(district_model, id=district_id)
    form = district_form(request.POST or None, instance=obj)
    if form.is_valid():
        form.save()
        return redirect(add_district)
    context['f'] = form
    return render(request, 'add_district.html', context)


#branch location controllers
def branch_location_insert(request):
    context = {}
    form = branch_location_form(request.POST or None)
    if form.is_valid():
        form.save()
        return redirect(branch_location_insert)
    context['f'] = form
    context['dataset'] = branch_location_model.objects.select_related('district').all()
    return render(request, 'branch_location_insert.html', context)


def branch_location_edit(request,branch_id):
    context = {}
    obj = get_object_or_404(branch_location_model, id=branch_id)
    form = branch_location_form(request.POST or None, instance=obj)
    if form.is_valid():
        form.save()
        return redirect(branch_location_insert)
    context['f'] = form
    return render(request, 'branch_location_insert.html', context)


def branch_location_delete(request,branch_id):
    if request.method != 'POST':
        return redirect(branch_location_insert)
    obj = get_object_or_404(branch_location_model, id=branch_id)
    obj.delete()
    return redirect(branch_location_insert)


#machinery controllers
def machinery_insert(request):
    context = {}
    form = machinery_form(request.POST or None)
    if form.is_valid():
        form.save()
        return redirect(machinery_insert)
    context['f'] = form
    context['dataset'] = machinery_model.objects.select_related('branch','category').all()
    return render(request, 'machinery_insert.html', context)


def machinery_edit(request,machinery_id):
    context = {}
    obj = get_object_or_404(machinery_model, id=machinery_id)
    form = machinery_form(request.POST or None, instance=obj)
    if form.is_valid():
        form.save()
        return redirect(machinery_insert)
    context['f'] = form
    return render(request, 'machinery_insert.html', context)


def machinery_delete(request,machinery_id):
    if request.method != 'POST':
        return redirect(machinery_insert)
    obj = get_object_or_404(machinery_model, id=machinery_id)
    obj.delete()
    return redirect(machinery_insert)


#maintenance log controllers
def maintenance_log_insert(request):
    context = {}
    form = maintenance_log_form(request.POST or None)
    if form.is_valid():
        form.save()
        return redirect(maintenance_log_insert)
    context['f'] = form
    context['dataset'] = maintenance_log_model.objects.select_related('machinery').all()
    return render(request, 'maintenance_log_insert.html', context)


def maintenance_log_edit(request,maintain_id):
    context = {}
    obj = get_object_or_404(maintenance_log_model, id=maintain_id)
    form = maintenance_log_form(request.POST or None, instance=obj)
    if form.is_valid():
        form.save()
        return redirect(maintenance_log_insert)
    context['f'] = form
    return render(request, 'maintenance_log_insert.html', context)


def maintenance_log_delete(request,maintain_id):
    if request.method != 'POST':
        return redirect(maintenance_log_insert)
    obj = get_object_or_404(maintenance_log_model, id=maintain_id)
    obj.delete()
    return redirect(maintenance_log_insert)


#insure policy controllers
def insure_policy_insert(request):
    context = {}
    form = insure_policy_form(request.POST or None)
    if form.is_valid():
        form.save()
        return redirect(insure_policy_insert)
    context['f'] = form
    context['dataset'] = insure_policy_model.objects.select_related('machinery').all()
    return render(request, 'insure_policy_insert.html', context)


def insure_policy_edit(request,policy_id):
    context = {}
    obj = get_object_or_404(insure_policy_model, id=policy_id)
    form = insure_policy_form(request.POST or None, instance=obj)
    if form.is_valid():
        form.save()
        return redirect(insure_policy_insert)
    context['f'] = form
    return render(request, 'insure_policy_insert.html', context)


def insure_policy_delete(request,policy_id):
    if request.method != 'POST':
        return redirect(insure_policy_insert)
    obj = get_object_or_404(insure_policy_model, id=policy_id)
    obj.delete()
    return redirect(insure_policy_insert)


# rental booking controllers
def rental_booking_insert(request):
    context = {}
    form = rental_booking_form(request.POST or None)
    if form.is_valid():
        form.save()
        return redirect(rental_booking_insert)
    context['f'] = form
    context['dataset'] = rental_booking_model.objects.select_related('customer', 'machinery').all()
    return render(request, 'rental_booking_insert.html', context)


def rental_booking_edit(request, booking_id):
    context = {}
    obj = get_object_or_404(rental_booking_model, id=booking_id)
    form = rental_booking_form(request.POST or None, instance=obj)
    if form.is_valid():
        form.save()
        return redirect(rental_booking_insert)
    context['f'] = form
    return render(request, 'rental_booking_insert.html', context)


def rental_booking_delete(request, booking_id):
    if request.method != 'POST':
        return redirect(rental_booking_insert)
    obj = get_object_or_404(rental_booking_model, id=booking_id)
    obj.delete()
    return redirect(rental_booking_insert)


def rental_booking_approve(request, booking_id):
    booking = get_object_or_404(rental_booking_model, id=booking_id)
    if request.method != 'POST' or booking.status not in ['pending']:
        return redirect(rental_booking_insert)
    booking.status = 'approved'
    booking.save(update_fields=['status'])
    booking.machinery.status = 'booked'
    booking.machinery.save(update_fields=['status'])
    return redirect(rental_booking_insert)


def rental_booking_reject(request, booking_id):
    booking = get_object_or_404(rental_booking_model, id=booking_id)
    if request.method != 'POST' or booking.status not in ['pending', 'approved']:
        return redirect(rental_booking_insert)
    booking.status = 'rejected'
    booking.save(update_fields=['status'])
    booking.machinery.status = 'available'
    booking.machinery.save(update_fields=['status'])
    return redirect(rental_booking_insert)


def rental_booking_activate(request, booking_id):
    booking = get_object_or_404(rental_booking_model, id=booking_id)
    if request.method != 'POST' or booking.status not in ['approved']:
        return redirect(rental_booking_insert)
    booking.status = 'active'
    booking.save(update_fields=['status'])
    booking.machinery.status = 'rented'
    booking.machinery.save(update_fields=['status'])
    return redirect(rental_booking_insert)


def rental_booking_complete(request, booking_id):
    booking = get_object_or_404(rental_booking_model, id=booking_id)
    if request.method != 'POST' or booking.status not in ['active']:
        return redirect(rental_booking_insert)
    booking.status = 'completed'
    booking.payment_status = 'paid'
    booking.save(update_fields=['status', 'payment_status'])
    booking.machinery.status = 'available'
    booking.machinery.save(update_fields=['status'])
    return redirect(rental_booking_insert)


def rental_invoice(request, booking_id):
    booking = get_object_or_404(
        rental_booking_model.objects.select_related('customer', 'machinery', 'machinery__branch', 'machinery__category'),
        id=booking_id,
    )
    return render(request, 'rental_invoice.html', {'obj': booking})


def rental_booking_mark_partial(request, booking_id):
    booking = get_object_or_404(rental_booking_model, id=booking_id)
    if request.method != 'POST':
        return redirect(rental_booking_insert)
    booking.payment_status = 'partial'
    booking.save(update_fields=['payment_status'])
    return redirect(rental_booking_insert)


def rental_booking_mark_paid(request, booking_id):
    booking = get_object_or_404(rental_booking_model, id=booking_id)
    if request.method != 'POST':
        return redirect(rental_booking_insert)
    booking.payment_status = 'paid'
    booking.save(update_fields=['payment_status'])
    return redirect(rental_booking_insert)


def rental_booking_mark_refunded(request, booking_id):
    booking = get_object_or_404(rental_booking_model, id=booking_id)
    if request.method != 'POST':
        return redirect(rental_booking_insert)
    booking.payment_status = 'refunded'
    booking.save(update_fields=['payment_status'])
    return redirect(rental_booking_insert)
