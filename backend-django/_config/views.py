from rest_framework.views import APIView


class IndexAPIView(APIView):
    def get(self, request):
        return "배포 테스트"
