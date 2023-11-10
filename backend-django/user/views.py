from rest_framework.response import Response
from rest_framework.views import APIView

from user.serializers import UserSerializer


class RegisterAPIView(APIView):
    def post(self, request):
        serializer = UserSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data)
