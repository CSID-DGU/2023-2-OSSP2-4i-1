from rest_framework.views import APIView


class IndexAPIView(APIView):
    def post(self, request):
        return "배포 테스트"
