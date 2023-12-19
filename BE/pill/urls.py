from django.urls import path

from .views import *

urlpatterns = [
    path('search/', TextSearchAPIView.as_view()),
    path('search/image', SearchAPIView.as_view()),
    path('<int:pill_id>', IDSearchAPIView.as_view()),
    path('likes/<int:pill_id>', LikeAPIView.as_view()),
]
