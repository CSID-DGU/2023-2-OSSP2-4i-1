from django.urls import path

import pills.views
from alarms import views
from likes import views
from pills import views
from users import views

urlpatterns = [
    # alarms urls

    # likes urls
    path('pill/<int:pill_id>/likes', likes.views.likes),

    # pills urls
    path('pill/search/image', pills.views.find_by_image),

    # users urls
    path('user/signup', ),
    path('user/login', ),
    path('user/logout, '),
    path('user/me', ),
    path('user/pill', ),
    path('user/pill/interaction', ),

    # tokens urls
    path('token/', ),
    path('token/', ),
]
