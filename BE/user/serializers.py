from rest_framework.serializers import ModelSerializer
from rest_framework import serializers

from .models import *


class UserSerializer(ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'email', 'password', 'name']
        extra_kwargs = {
            'password': {'write_only': True},
        }

    def create(self, validated_data):
        password = validated_data.pop('password', None)
        instance = self.Meta.model(**validated_data)
        if password is not None:
            instance.set_password(password)
        instance.save()
        return instance


class TakingSerializer(serializers.ModelSerializer):
    class Meta:
        model = Taking
        fields = '__all__'


class TakingScheduleSerializer(serializers.ModelSerializer):
    class Meta:
        model = TakingSchedule
        fields = '__all__'
