from django.db import models


class User(models.Model):
    id = models.CharField(max_length=255, primary_key=True)
    password = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    refresh_token = models.CharField(max_length=255)
