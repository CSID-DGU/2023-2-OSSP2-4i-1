from django.urls import path

import alarms.views
import likes.views
import pills.views
import users.views

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
