from django.db import models
from django.contrib.auth.models import AbstractUser


class User(AbstractUser):
    email = models.CharField(max_length=255, unique=True)
    password = models.CharField(max_length=255)
    name = models.CharField(max_length=255)

    first_name = None
    last_name = None
    username = None

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []
