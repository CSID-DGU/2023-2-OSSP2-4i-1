from django.urls import path

import pills.views
from alarms import views
from likes import views
from pills import views
from users import views

urlpatterns = [
    path('api/pill/search/image', pills.views.find_by_image)
]
