# Generated by Django 4.2.7 on 2023-11-19 10:33

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('pill', '0002_instructions'),
    ]

    operations = [
        migrations.AlterField(
            model_name='instructions',
            name='pill_amount',
            field=models.CharField(blank=True, max_length=2555),
        ),
        migrations.AlterField(
            model_name='instructions',
            name='pill_detail',
            field=models.CharField(blank=True, max_length=2555),
        ),
        migrations.AlterField(
            model_name='instructions',
            name='pill_effect',
            field=models.CharField(blank=True, max_length=2555),
        ),
        migrations.AlterField(
            model_name='instructions',
            name='pill_food',
            field=models.CharField(blank=True, max_length=2555),
        ),
        migrations.AlterField(
            model_name='instructions',
            name='pill_inter',
            field=models.CharField(blank=True, max_length=2555),
        ),
        migrations.AlterField(
            model_name='instructions',
            name='pill_method',
            field=models.CharField(blank=True, max_length=2555),
        ),
    ]
