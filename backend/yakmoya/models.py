# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Tablet(models.Model):
    tablet_id = models.CharField(primary_key=True, max_length=255)
    tablet_name = models.CharField(max_length=255)

    class Meta:
        managed = False
        db_table = 'tablet'


class TabletProperties(models.Model):
    drug_n = models.OneToOneField(Tablet, models.DO_NOTHING, db_column='drug_N', primary_key=True)  # Field name made lowercase.
    dl_custom_shape = models.CharField(max_length=255, blank=True, null=True)
    drug_shape = models.CharField(max_length=255, blank=True, null=True)
    color_class1 = models.CharField(max_length=255, blank=True, null=True)
    color_class2 = models.CharField(max_length=255, blank=True, null=True)
    print_front = models.CharField(max_length=255, blank=True, null=True)
    print_back = models.CharField(max_length=255, blank=True, null=True)
    line_front = models.CharField(max_length=255, blank=True, null=True)
    line_back = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'tablet_properties'


class User(models.Model):
    user_id = models.CharField(primary_key=True, max_length=255)
    user_password_encrypted = models.CharField(max_length=255)
    user_name = models.CharField(max_length=255)
    user_refresh_token = models.CharField(max_length=255)

    class Meta:
        managed = False
        db_table = 'user'
