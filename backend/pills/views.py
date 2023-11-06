from django.http import JsonResponse
from django.views.decorators.http import require_GET


@require_GET
def find_by_name(request):
    pass


@require_GET
def find_by_image(request):
    return JsonResponse("hello")
