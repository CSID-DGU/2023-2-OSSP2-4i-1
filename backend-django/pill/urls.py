from django.urls import path

from .views import *

urlpatterns = [
    path('search', SearchAPIView.as_view()),
]
