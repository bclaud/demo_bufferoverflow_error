from litestar import Litestar
import uvicorn

from demo_error.controllers.http import HelloController

from litestar.contrib.opentelemetry import OpenTelemetryConfig
from litestar.middleware.logging import LoggingMiddlewareConfig
from litestar.config.compression import CompressionConfig


def get_litestar_app() -> Litestar:
    open_telemetry_config = OpenTelemetryConfig()
    logging_middleware_config = LoggingMiddlewareConfig()
    litestar_app = Litestar(
        [HelloController],
        compression_config=CompressionConfig(backend="gzip", gzip_compress_level=5),
        middleware=[
            open_telemetry_config.middleware,
            logging_middleware_config.middleware,
        ],
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
