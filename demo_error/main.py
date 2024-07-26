from litestar import Litestar
import uvicorn

from demo_error.controllers.http import HelloController



def get_litestar_app() -> Litestar:
    litestar_app = Litestar(
        [HelloController],
    )
    return litestar_app


def get_app():
    litestar_app = get_litestar_app()

    return litestar_app


def run():
    uvicorn.run(
        get_app,
        factory=True,
        host="0.0.0.0",
        port=8000,
        http="httptools",
        loop="uvloop",
    )


if __name__ == "__main__":
    run()
