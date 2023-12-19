import os, json
import connection

conn, cur = connection.connect_rds()

# 1. JSON 파일 읽기

root_dir = "./raw_data/pills"
files = os.listdir(root_dir)

for file in files:
    # 파일 경로
    path = os.path.join(root_dir, file)

    # json 파일 읽기
    with open(path, 'r', encoding='utf8') as f:
        data = json.load(f)

    # 값 추출
    name = data["drug_name"]
    img_link = data["img_link"]

    label = data["label"]
    label_forms = label["forms"]
    label_shapes = label["shapes"]
    label_color1 = label["color1"]
    label_color2 = label["color2"]
    label_line_front = label["line_front"]
    label_line_back = label["line_back"]
    label_print_front = label["print_front"]
    label_print_back = label["print_back"]

    # 2. 데이터베이스에 삽입

    query = """
        INSERT INTO pill_pill (name, img_link, label_forms, label_shapes, label_color1, label_color2, label_line_front, label_line_back, label_print_front, label_print_back)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """
    data = (name, img_link, label_forms, label_shapes, label_color1, label_color2, label_line_front, label_line_back,
            label_print_front, label_print_back)

    cur.execute(query, data)
    conn.commit()
