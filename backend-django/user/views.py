import json

from django.http import HttpResponse, JsonResponse
from rest_framework.authentication import get_authorization_header
from rest_framework.response import Response
from rest_framework.views import APIView
import itertools

from pill.models import PillComponent, Interactions
from user.models import *
from user.serializers import *
from authentication.authentication import *

import time

from datetime import datetime


class RegisterAPIView(APIView):
    def post(self, request):
        serializer = UserSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data)


class MeAPIView(APIView):
    def get(self, request):
        auth = get_authorization_header(request).split()

        if auth and len(auth) == 2:
            token = auth[1].decode('utf-8')
            id = decode_access_token(token)

            user = User.objects.filter(pk=id).first()

            return Response(UserSerializer(user).data)

        raise exceptions.AuthenticationFailed('unauthenticated')


class PillAPIView(APIView):
    def get(self, request):
        auth = get_authorization_header(request).split()

        if auth and len(auth) == 2:
            token = auth[1].decode('utf-8')
            id = decode_access_token(token)

            query_set = Taking.objects.filter(patient_id=id)

            ret = list()

            for data in query_set:
                pill_id = data.pill_id
                pill = Pill.objects.get(id=pill_id)
                pill_name = pill.name
                img_url = pill.img_link

                dic = dict()
                dic["id"] = pill_id
                dic["name"] = pill_name
                dic["img"] = img_url

                ret.append(dic)

            return JsonResponse(ret, safe=False)

        raise exceptions.AuthenticationFailed('unauthenticated')


class InteractionAPIView(APIView):
    def get(self, request):
        auth = get_authorization_header(request).split()

        if auth and len(auth) == 2:
            token = auth[1].decode('utf-8')
            id = decode_access_token(token)

            query_set = Taking.objects.filter(patient_id=id)  # 현재 복용 중인 약 검색
            taking_name_list = list()  # 현재 복용 중인 약 리스트
            for q in query_set:
                taking_name_list.append(q.pill.name)
            # 복용 중인 약 출력 (디버깅)
            print(taking_name_list)

            # 경우의 수 (combination, nC2)
            combi_list = itertools.combinations(taking_name_list, 2)

            for pair in combi_list:
                pill1_components = list()
                pill2_components = list()
                qset1 = PillComponent.objects.filter(pill_name=pair[0])
                qset2 = PillComponent.objects.filter(pill_name=pair[1])
                if not qset1.exists() or not qset2.exists():
                    continue  # 두 약 중 단 하나의 약이라도 PillComponent 에 등록되어 있지 않다면 상충여부를 확인할 필요가 없음
                else:  # 두 약 모두 PillComponent 에 등록된 경우
                    # 시간 측정
                    start = time.time()

                    # 첫 번째 약이랑 같이 먹으면 안 되는 성분 리스트 추출
                    query_set = Interactions.objects.filter(pill_name=pair[0])
                    not_set = set()
                    for q in query_set:
                        not_set.add(q.component_name2)

                    for q in qset1:
                        pill1_components.append(q.pill_component)
                    for q in qset2:
                        pill2_components.append(q.pill_component)
                    print(pill1_components)
                    print(pill2_components)

                    flag = 0
                    for c2 in pill2_components:
                        if c2 in not_set:
                            print("[Caution]", pair[0], "+", c2, "in", pair[1])
                            for d in query_set.filter(component_name2=c2):
                                print("\t\t", d.clinical_effect)

                    end = time.time()

                    print("2개 검사 시간: ", end - start)

            return HttpResponse("test")

        raise exceptions.AuthenticationFailed('unauthenticated')


class AlarmAPIView(APIView):
    def post(self, request):
        auth = get_authorization_header(request).split()

        if auth and len(auth) == 2:
            token = auth[1].decode('utf-8')
            data = json.loads(request.body)

            patient_id = decode_access_token(token)
            pill_id = data["pill_id"]
            scheduled_time = data["time"]

            instance = TakingSchedule.objects.create(
                scheduled_time=scheduled_time,
                patient_id=patient_id,
                pill_id=pill_id,
            )
            instance.save()

            return Response("알림 정보 저장 완료!")

        raise exceptions.AuthenticationFailed('unauthenticated')

    def patch(self, request):
        auth = get_authorization_header(request).split()

        if auth and len(auth) == 2:
            token = auth[1].decode('utf-8')
            data = json.loads(request.body)

            patient_id = decode_access_token(token)
            pill_id = data["pill_id"]
            scheduled_time = data["time"]

            instance = TakingSchedule.objects.get(patient_id=patient_id, pill_id=pill_id)
            instance.scheduled_time = scheduled_time
            instance.save()

            return Response("알림 정보 수정 완료!")

        raise exceptions.AuthenticationFailed('unauthenticated')

    def get(self, request):
        auth = get_authorization_header(request).split()

        if auth and len(auth) == 2:
            token = auth[1].decode('utf-8')

            patient_id = decode_access_token(token)

            ds = TakingSchedule.objects.filter(patient_id=patient_id)

            return Response(TakingScheduleSerializer(ds, many=True).data)

        raise exceptions.AuthenticationFailed('unauthenticated')
