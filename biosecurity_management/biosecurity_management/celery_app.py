from celery import Celery

app = Celery('biosecurity_management')
app.config_from_object('django.conf:settings')
