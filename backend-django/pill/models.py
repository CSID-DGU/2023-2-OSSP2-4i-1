from django.db import models


class Pill(models.Model):
    name = models.CharField(max_length=255)
    img_link = models.CharField(max_length=255)
    label_forms = models.CharField(max_length=255, blank=True)
    label_shapes = models.CharField(max_length=255, blank=True)
    label_color1 = models.CharField(max_length=255, blank=True)
    label_color2 = models.CharField(max_length=255, blank=True)
    label_line_front = models.CharField(max_length=255, blank=True)
    label_line_back = models.CharField(max_length=255, blank=True)
    label_print_front = models.CharField(max_length=255, blank=True)
    label_print_back = models.CharField(max_length=255, blank=True)
