import redis
import base64

from libs.helpers.encoding import random_token
from fastapi import APIRouter, Response

router = APIRouter()


@router.get("/")
async def root():
    return {"status": "ok"}


@router.get("/write/{data}")
async def put_data(data: str):
    token = random_token(64)
    r = redis.Redis(host="redis", port=6379)
    r.set(token, base64.b64encode(data.encode()).decode())
    return {"token": token}


@router.get("/read/{token}")
async def get_data(token: str):
    r = redis.Redis(host="redis", port=6379)
    data = r.get(token)
    if data is not None:
        r.delete(token)
        return {"data": base64.b64decode(data.decode("utf-8")).decode('utf-8')}
    else:
        return {"data": "not found"}


@router.get("/get/{token}")
async def get_data(token: str):
    r = redis.Redis(host="redis", port=6379)
    data = r.get(token)
    if data is not None:
        r.delete(token)

        data = base64.b64decode(data.decode("utf-8")).decode('utf-8')

        file_name = "{}.txt".format(token)
        response = Response(content=data)
        response.headers["Content-Disposition"] = f"attachment; filename={file_name}"
    else:
        response = "not found"

    return response
