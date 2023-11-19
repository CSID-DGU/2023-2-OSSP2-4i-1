from rest_framework import serializers

from pill.models import Pill, Instructions


class PillSerializer(serializers.ModelSerializer):
    class Meta:
        model = Pill
        fields = '__all__'


class InstructionsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Instructions
        fields = '__all__'
