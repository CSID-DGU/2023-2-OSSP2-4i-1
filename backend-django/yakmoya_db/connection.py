import pymysql


def connect_rds():
    conn = pymysql.connect(
        host="yakmoya.cwkjelry28ez.eu-north-1.rds.amazonaws.com",
        user="bakyoungha",
        password="123456789z",
        db="yakmoya",
        port=3306,
        charset="utf8",
    )
    cur = conn.cursor()
    return conn, cur
