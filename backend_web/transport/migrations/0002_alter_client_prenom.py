# Generated by Django 4.1.7 on 2023-02-22 19:19

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('transport', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='client',
            name='prenom',
            field=models.CharField(max_length=100),
        ),
    ]
