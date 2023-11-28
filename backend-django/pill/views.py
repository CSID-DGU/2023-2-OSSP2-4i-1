import json

from django.core.paginator import Paginator
from django.db.models import Q
from django.http import JsonResponse
from rest_framework.authentication import get_authorization_header
from rest_framework.response import Response
from rest_framework.views import APIView

from authentication.authentication import *
from pill.models import Pill, Instructions
from pill.serializers import PillSerializer, InstructionsSerializer
from yakmoya_db.connection import connect_rds


class TextSearchAPIView(APIView):
    def get(self, request):
        auth = get_authorization_header(request).split()

        if auth and len(auth) == 2:
            text = request.GET.get('text')

            # DB 검색
            queryset = Pill.objects.filter(name__icontains=text)

            # 페이징 처리
            page = request.GET.get('page', '1')  # 페이지
            paginator = Paginator(queryset, 10)  # 페이지당 10개씩 보여주기
            page_obj = paginator.get_page(page)

            # Serializer를 사용하여 JSON으로 직렬화
            serializer = PillSerializer(page_obj, many=True)
            serialized_data = serializer.data

            # 응답
            return Response(serialized_data)

        raise exceptions.AuthenticationFailed('unauthenticated')


class SearchAPIView(APIView):
    def get(self, request):
        auth = get_authorization_header(request).split()

        if auth and len(auth) == 2:
            json_data = json.loads(request.body.decode('utf-8'))

            label_forms = json_data['label_forms']
            label_shapes = json_data['label_shapes']
            label_color1 = json_data['label_color1']
            label_color2 = json_data['label_color2']
            label_line_front = json_data['label_line_front']
            label_line_back = json_data['label_line_back']
            label_print_front = json_data['label_print_front']
            label_print_back = json_data['label_print_back']

            # 1차 필터링: forms, shapes
            queryset = Pill.objects.filter(label_forms=label_forms, label_shapes=label_shapes)

            # 2차 필터링: line, print
            queryset = queryset.filter(
                label_line_front=label_line_front,
                label_line_back=label_line_back,
                label_print_front=label_print_front,
                label_print_back=label_print_back,
            )
            
            # 3차 필터링: color
            if label_color1 == label_color2:
                queryset = queryset.filter(label_color1__icontains=label_color1)
            else:
                queryset = queryset.filter(
                    Q(label_color1__icontains=label_color1, label_color2__icontains=label_color2)
                    |
                    Q(label_color1__icontains=label_color2, label_color2__icontains=label_color1)
                )

            # Serializer를 사용하여 JSON으로 직렬화
            serializer = PillSerializer(queryset, many=True)
            serialized_data = serializer.data

            # 응답
            return Response(serialized_data)

        raise exceptions.AuthenticationFailed('unauthenticated')


class IDSearchAPIView(APIView):
    def get(self, request, pill_id):
        auth = get_authorization_header(request).split()

        if auth and len(auth) == 2:
            pill = Pill.objects.get(id=pill_id)

            name = pill.name

            queryset = Instructions.objects.get(drug_name=name)

            pill_name = name
            pill_img = pill.img_link
            pill_effect = queryset.pill_effect
            pill_detail = queryset.pill_detail
            pill_method = queryset.pill_method

            ret = dict()
            ret["id"] = pill_id
            ret["name"] = pill_name
            ret["img_link"] = pill_img
            ret["pill_effect"] = pill_effect
            ret["pill_detail"] = pill_detail
            ret["pill_method"] = pill_method

            print(ret)

            # 응답
            return JsonResponse(ret)

        raise exceptions.AuthenticationFailed('unauthenticated')


class LikeAPIView(APIView):
    def post(self, request, pill_id):
        auth = get_authorization_header(request).split()

        if auth and len(auth) == 2:
            queryset = Pill.objects.filter(id=pill_id)

            token = auth[1].decode('utf-8')

            patient_id = decode_access_token(token)
            pill_id = queryset.first().id

            # DB 삽입

            conn, cur = connect_rds()

            query = """
                INSERT INTO user_taking (patient_id, pill_id)
                VALUES (%s, %s)
            """
            data = (patient_id, pill_id)

            cur.execute(query, data)
            conn.commit()

            return Response("정상 등록 완료!")

        raise exceptions.AuthenticationFailed('unauthenticated')

    def delete(self, request, pill_id):
        auth = get_authorization_header(request).split()

        if auth and len(auth) == 2:
            queryset = Pill.objects.filter(id=pill_id)

            token = auth[1].decode('utf-8')

            patient_id = decode_access_token(token)
            pill_id = queryset.first().id

            # 삭제

            conn, cur = connect_rds()

            query = """
                DELETE FROM user_taking
                WHERE patient_id=patient_id and pill_id=pill_id
            """

            cur.execute(query)
            conn.commit()

            return Response("정상 삭제 완료!")

        raise exceptions.AuthenticationFailed('unauthenticated')
