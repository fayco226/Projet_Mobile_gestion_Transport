# Generated by Django 4.1.1 on 2023-04-23 01:40

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('transport', '0011_rename_nometdeexpediteur_courier_nometprenomdeexpediteur_and_more'),
    ]

    operations = [
        migrations.RenameField(
            model_name='courier',
            old_name='Cnib',
            new_name='cnib',
        ),
        migrations.AddField(
            model_name='courier',
            name='validerArrive',
            field=models.BooleanField(default=False),
        ),
        migrations.AddField(
            model_name='courier',
            name='validerPris',
            field=models.BooleanField(default=False),
        ),
        migrations.AddField(
            model_name='reservation',
            name='valider_reservation',
            field=models.BooleanField(default=False),
        ),
    ]
