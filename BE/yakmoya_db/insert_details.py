import os, json
import connection

conn, cur = connection.connect_rds()

# 1. JSON 파일 읽기

root_dir = "./raw_data/details"
files = os.listdir(root_dir)

for file in files:
    # 파일 경로
    path = os.path.join(root_dir, file)

    # json 파일 읽기
    with open(path, 'r', encoding='utf8') as f:
        data = json.load(f)

    # 값 추출
    idx = data['idx']
    drug_name = data['drug_name']
    pill_effect = data['pill_effect']
    pill_amount = data['pill_amount']
    pill_detail = data['pill_detail']
    pill_method = data['pill_method']
    pill_food = data['pill_food']
    inter_X = data['inter_X']
    pill_inter = data['pill_inter']

    # 2. 데이터베이스에 삽입

    query = """
        INSERT INTO pill_instructions (
            idx,
            drug_name,
            pill_effect,
            pill_amount,
            pill_detail,
            pill_method,
            pill_food,
            inter_X,
            pill_inter
        )
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
    """
    data = (
        idx,
        drug_name,
        pill_effect,
        pill_amount,
        pill_detail,
        pill_method,
        pill_food,
        inter_X,
        pill_inter,
    )

    cur.execute(query, data)
    conn.commit()
