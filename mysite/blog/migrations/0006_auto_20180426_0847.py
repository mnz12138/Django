# Generated by Django 2.0.4 on 2018-04-26 08:47

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('blog', '0005_auto_20180416_1127'),
    ]

    operations = [
        migrations.DeleteModel(
            name='User',
        ),
        migrations.AlterField(
            model_name='blog',
            name='pubDate',
            field=models.DateTimeField(auto_now_add=True),
        ),
        migrations.AlterField(
            model_name='blog',
            name='subTitle',
            field=models.CharField(blank=True, max_length=200, null=True),
        ),
    ]
