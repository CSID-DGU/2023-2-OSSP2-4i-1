from django.db import models
from pills.models import Pill


class User(models.Model):
    id = models.CharField(max_length=255, primary_key=True)
    password = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    refresh_token = models.CharField(max_length=255)


class Taking(models.Model):
    id = models.AutoField
    user_id = models.ForeignKey(User, on_delete=models.CASCADE)
    pill_id = models.ForeignKey(Pill, on_delete=models.CASCADE)
