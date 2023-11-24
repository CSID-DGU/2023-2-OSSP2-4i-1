import os
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "_config.settings")

import django
django.setup()

import csv
import connection
from pill.models import PillComponent

conn, cur = connection.connect_rds()

# Step 1: CSV 파일 읽기
with open("./raw_data/compo.csv", 'r', encoding='utf-8') as file:
    reader = csv.reader(file)
    data = list(reader)

# Step 2: 데이터 가공 및 데이터베이스에 저장
for row in data:
    # 가공된 데이터를 YourModel에 맞게 추출
    pill_name = row[0]
    pill_component = row[1]

    if pill_name == "알약이름":
        continue

    # Step 3: 데이터베이스에 저장
    instance = PillComponent.objects.create(pill_name=pill_name, pill_component=pill_component)
    instance.save()
