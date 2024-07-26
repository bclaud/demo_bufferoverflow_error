from litestar import Controller, HttpMethod, route



class HelloController(Controller):
    path = "/"

    @route(http_method=HttpMethod.POST, description="Requests a slack message")
    async def say_hello(
        self,
    ) -> dict[str, str]:
        return {"hello": ":)"}

