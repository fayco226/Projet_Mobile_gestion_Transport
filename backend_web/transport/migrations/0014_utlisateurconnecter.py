# Generated by Django 4.1.7 on 2023-04-27 21:17

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('transport', '0013_alter_reservation_options_reservation_nometprenom'),
    ]

    operations = [
        migrations.CreateModel(
            name='UtlisateurConnecter',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('identifiant', models.IntegerField()),
            ],
        ),
    ]
