import json
from sqlmodel import create_engine, SQLModel, Session
from model import SQLMODEL

# secrets.json 파일에서 데이터 읽기
with open("secrets.json", "r") as file:
    secrets = json.load(file)

db_config = secrets["database"]

# URL 구성 요소 생성
## secrets.json 만들기
URL_components = [
    db_config["drivername"],
    "://",
    db_config["username"],
    ":",
    db_config["password"],
    "@",
    db_config["host"],
    ":",
    db_config["port"],
    "/",
    db_config["database"],
    "?",
    "charset=utf8",
]

engine = create_engine("".join(URL_components))
SQLModel.metadata.create_all(engine)

def create_newspapers(newspapers: list[SQLMODEL.NewsPaper]):
    with Session(engine, expire_on_commit=False) as session:
        for newspaper in newspapers:
            session.add(newspaper)
        session.commit()