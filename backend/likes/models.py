from django.db import models
from users.models import User
from pills.models import Pill


class Like(models.Model):
    id = models.AutoField
    user_id = models.ForeignKey(User, on_delete=models.CASCADE)
    pill_id = models.ForeignKey(Pill, on_delete=models.CASCADE)
