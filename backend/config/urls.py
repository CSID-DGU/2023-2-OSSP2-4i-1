from django.contrib import admin
from django.urls import path
import api

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', ),
]
