from django.db import models


class Pill(models.Model):
    id = models.CharField(max_length=255, primary_key=True)
    name = models.CharField(max_length=255)


class PillProperties(models.Model):
    id = models.ForeignKey(Pill, on_delete=models.CASCADE, primary_key=True)
    custom_shape = models.CharField(max_length=255, null=True)
    shape = models.CharField(max_length=255, null=True)
    color1 = models.CharField(max_length=255, null=True)
    color2 = models.CharField(max_length=255, null=True)
    print_front = models.CharField(max_length=255, null=True)
    print_back = models.CharField(max_length=255, null=True)
    line_front = models.CharField(max_length=255, null=True)
    line_back = models.CharField(max_length=255, null=True)
