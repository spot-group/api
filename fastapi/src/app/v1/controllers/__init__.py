from fastapi import APIRouter

from app.v1.controllers.test import router as test_router
from app.v1.controllers.jobs import router as jobs_router

router = APIRouter()

router.include_router(router=test_router, prefix="/test")
router.include_router(router=jobs_router, prefix="/jobs")
