from django.http import HttpResponse
from django.http import JsonResponse
from django.views.decorators.http import *
from django.views.decorators.csrf import csrf_exempt


@csrf_exempt  # POST 및 DELETE 요청을 위해 CSRF 검증 비활성화
def likes(request):
    if request.method == 'POST':
        pass
    elif request.method == 'DELETE':
        pass
    elif request.method == 'PUT':
        pass
