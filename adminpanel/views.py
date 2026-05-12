from django.shortcuts import render, redirect, get_object_or_404

from .adminForms import category_form
from .models import category_model


# Create your views here.
def adminpanel(request):
    return render(request, 'adminheader.html')

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
    context={}
    obj=get_object_or_404(category_model,id=category_id)
    obj.delete()
    return redirect(category_insert)

def category_view(request):
    context = {}
    context['dataset'] = category_model.objects.all()
    return render(request, "category_view.html", context)