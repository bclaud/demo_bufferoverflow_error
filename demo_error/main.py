from litestar import Litestar, MediaType, Request, Response
from litestar.exceptions import HTTPException
from litestar.status_codes import HTTP_500_INTERNAL_SERVER_ERROR
import uvicorn

from demo_error.controllers.http import HelloController



def get_litestar_app() -> Litestar:
    litestar_app = Litestar(
        [HelloController],
        # debug=True,
        # pdb_on_exception=True
        exception_handlers={HTTPException: app_http_exception_handler, Exception: app_exception_handler}
    )
    return litestar_app


def get_app():
    litestar_app = get_litestar_app()

    return litestar_app


def run():
    uvicorn.run(
        get_app,
        factory=True,
        host="127.0.0.1",
        port=8000,
        http="httptools",
        loop="uvloop",
    )

def app_exception_handler(_: Request, exc: Exception) -> Response:
    """
    Default handler for exceptions subclassed from Exception.

    For some reason that I do not understand, not providing an custom handler
    throws 'bufferoverflow detected' and the servers crashes
    """
    return Response(
        media_type=MediaType.JSON,
        content={
            "detail": "Internal server error"
        },
        status_code=500
    )


def app_http_exception_handler(request: Request, exc: Exception) -> Response:
    """
    Default handler for exceptions subclassed from HTTPException.

    For some reason that I do not understand, not providing an custom handler
    throws 'bufferoverflow detected' and the servers crashes
    """
    status_code = getattr(exc, "status_code", HTTP_500_INTERNAL_SERVER_ERROR)
    detail = getattr(exc, "detail", "")

    return Response(
        media_type=MediaType.JSON,
        content={"detail": detail, "path": request.url.path},
        status_code=status_code,
    )

if __name__ == "__main__":
    run()
