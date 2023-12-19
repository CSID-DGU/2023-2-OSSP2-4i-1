from django.http import HttpResponse
from rest_framework.views import APIView


class IndexAPIView(APIView):
    def get(self, request):
        return HttpResponse("배포 테스트")
