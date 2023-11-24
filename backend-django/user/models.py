from django.db import models
from django.contrib.auth.models import AbstractUser
from pill.models import Pill


class User(AbstractUser):
    email = models.CharField(max_length=255, unique=True)
    password = models.CharField(max_length=255)
    name = models.CharField(max_length=255)

    first_name = None
    last_name = None
    username = None

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []


class Taking(models.Model):
    patient = models.ForeignKey(User, on_delete=models.CASCADE)
    pill = models.ForeignKey(Pill, on_delete=models.CASCADE)


class TakingSchedule(models.Model):
    patient = models.ForeignKey(User, on_delete=models.CASCADE)
    pill = models.ForeignKey(Pill, on_delete=models.CASCADE)
    scheduled_time = models.DateTimeField(null=True)
    is_taken = models.BooleanField(default=False)
