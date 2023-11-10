import base64

from rest_framework.exceptions import APIException
from rest_framework.response import Response
from rest_framework.views import APIView

from user.models import User
from .authentication import *


class LoginAPIView(APIView):
    def post(self, request):
        # Authorization 헤더에서 Basic 토큰 추출
        auth_header = request.headers.get('Authorization')

        if auth_header and auth_header.startswith('Basic '):
            # "Basic <base64-encoded-credentials>"에서 "<base64-encoded-credentials>" 부분 추출
            encoded_credentials = auth_header.split(' ')[1]

            # Base64 디코딩
            decoded_bytes = base64.b64decode(encoded_credentials.encode('utf-8'))

            # 바이트를 문자열로 변환
            decoded_str = decoded_bytes.decode('utf-8')

            # 사용자 이메일과 비밀번호를 추출
            email, password = decoded_str.split(':')

            user = User.objects.filter(email=email).first()

            # if not User:
            #     raise APIException('[Invalid Credentials] 존재하지 않는 이메일입니다.')
            #
            # if not user.check_password(password):
            #     raise APIException('[Invalid Credentials] 비밀번호가 올바르지 않습니다.')

            access_token = create_access_token(user.id)
            refresh_token = create_refresh_token(user.id)

            response = Response()

            response.set_cookie(key='refreshToken', value=refresh_token, httponly=True)
            response.data = {
                'accessToken': access_token,
            }

            return response
