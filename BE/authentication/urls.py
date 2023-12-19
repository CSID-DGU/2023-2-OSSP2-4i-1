from django.urls import path

from .views import *

urlpatterns = [
    path('login', LoginAPIView.as_view()),
    path('token', TokenAPIView.as_view()),
]
