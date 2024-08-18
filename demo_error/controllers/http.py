from litestar import Controller, HttpMethod, get, route



class HelloController(Controller):
    path = "/"

    @route(http_method=HttpMethod.GET, description="Simple hello")
    async def say_hello(
        self,
    ) -> dict[str, str]:
        return {"hello": "world"}

    @route(path="/crash", http_method=HttpMethod.GET, description="Throws an Unhandled Exception")
    async def crashes(
            self,
    ) -> None:
        1 / 0
