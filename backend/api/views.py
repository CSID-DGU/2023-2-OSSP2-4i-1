from rest_framework.authentication import get_authorization_header
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.exceptions import APIException

from .authentication import *
from .serializers import *
from .models import *


class RegisterAPIView(APIView):
    def post(self, request):
        serializer = UserSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data)


class LoginAPIView(APIView):
    def post(self, request):
        user = User.objects.filter(email=request.data["email"]).first()

        if not user:
            raise APIException("Invalid credentials!")

        if not user.check_password(request.data["password"]):
            raise APIException("Invalid credentials!")

        access_token = create_access_token(user.id)
        refresh_token = create_refresh_token(user.id)

        response = Response()

        # 데이터베이스에 refresh token을 저장하는 코드 필요.
        # 여기서는 테스트를 위해 쿠키로 대체함.
        response.set_cookie(key="refreshToekn", value=refresh_token, httponly=True)

        response.data = {
            "accessToken": access_token,
            "refreshToken": refresh_token,
        }

        return response


class UserAPIView(APIView):
    def get(self, request):
        auth = get_authorization_header(request).split()

        if auth and len(auth) == 2:
            token = auth[1].decode("utf-8")
            id = decode_access_token(token)

            user = User.objects.filter(pk=id).first()

            return Response(UserSerializer(user).data)

        raise exceptions.AuthenticationFailed("unauthenticated")


class RefreshAPIView(APIView):
    def post(self, request):
        refresh_token = request.COOKIES.get("refreshToken")
        id = decode_refresh_token(refresh_token)
        access_token = create_access_token(id)
        return Response(
            {
                "token": access_token,
            }
        )


class LogoutAPIView(APIView):
    def post(self, request):
        response = Response()
        response.delete_cookie(key="refreshToken")
        response.data = {
            "message": "seccess",
        }
        return response
