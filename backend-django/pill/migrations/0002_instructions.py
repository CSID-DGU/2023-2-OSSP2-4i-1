# Generated by Django 4.2.7 on 2023-11-19 10:18

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('pill', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Instructions',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('idx', models.CharField(max_length=255)),
                ('drug_name', models.CharField(max_length=255)),
                ('pill_effect', models.CharField(blank=True, max_length=255)),
                ('pill_amount', models.CharField(blank=True, max_length=255)),
                ('pill_detail', models.CharField(blank=True, max_length=255)),
                ('pill_method', models.CharField(blank=True, max_length=255)),
                ('pill_food', models.CharField(blank=True, max_length=255)),
                ('inter_x', models.IntegerField()),
                ('pill_inter', models.CharField(blank=True, max_length=255)),
            ],
        ),
    ]
