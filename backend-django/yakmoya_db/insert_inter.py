import os
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "_config.settings")

import django
django.setup()

import csv
import connection
from pill.models import Interactions

conn, cur = connection.connect_rds()

# Step 1: CSV 파일 읽기
with open("./raw_data/inter.csv", 'r', encoding='utf-8') as file:
    reader = csv.reader(file)
    data = list(reader)

# Step 2: 데이터 가공 및 데이터베이스에 저장
for row in data:
    # 가공된 데이터를 YourModel에 맞게 추출
    pill_component1 = row[2]
    pill_component2 = row[4]
    clinical_effect = row[6]
    mechanism = row[7]
    handle = row[8]

    if pill_component1 == "성분1":
        continue

    # Step 3: 데이터베이스에 저장
    instance = Interactions.objects.create(
        component_name1=pill_component1,
        component_name2=pill_component2,
        clinical_effect=clinical_effect,
        mechanism=mechanism,
        handle=handle,
    )
    instance.save()
