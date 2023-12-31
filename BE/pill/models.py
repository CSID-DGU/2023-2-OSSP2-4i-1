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


class Instructions(models.Model):
    idx = models.CharField(max_length=255)
    drug_name = models.CharField(max_length=255)
    pill_effect = models.CharField(max_length=2555, blank=True)
    pill_amount = models.CharField(max_length=2555, blank=True)
    pill_detail = models.CharField(max_length=2555, blank=True)
    pill_method = models.CharField(max_length=2555, blank=True)
    pill_food = models.CharField(max_length=2555, blank=True)
    inter_x = models.IntegerField()
    pill_inter = models.CharField(max_length=2555, blank=True)


class PillComponent(models.Model):
    pill_name = models.CharField(max_length=255)
    pill_component = models.CharField(max_length=255)


class Interactions(models.Model):
    pill_name = models.CharField(max_length=255, default=None)
    component_name1 = models.CharField(max_length=255)
    component_name2 = models.CharField(max_length=255)
    clinical_effect = models.CharField(max_length=255)
    mechanism = models.CharField(max_length=255)
    handle = models.CharField(max_length=255)
