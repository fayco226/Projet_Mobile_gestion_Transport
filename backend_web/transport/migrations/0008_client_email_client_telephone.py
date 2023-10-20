# Generated by Django 4.1.7 on 2023-03-13 17:52

from django.db import migrations, models
import phonenumber_field.modelfields


class Migration(migrations.Migration):

    dependencies = [
        ('transport', '0007_remove_client_email_remove_client_telephone'),
    ]

    operations = [
        migrations.AddField(
            model_name='client',
            name='email',
            field=models.EmailField(default='example@example.com', max_length=254),
        ),
        migrations.AddField(
            model_name='client',
            name='telephone',
            field=phonenumber_field.modelfields.PhoneNumberField(default='+22661748597', max_length=128, region=None),
        ),
    ]