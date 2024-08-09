from litestar import Controller, HttpMethod, get, route



# class HelloController(Controller):
#     path = "/"
#
#     @route(http_method=HttpMethod.POST, description="Requests a slack message")
#     async def say_hello(
#         self,
#     ) -> dict[str, str]:
#         return {"hello": ":)"}

@get("/")
async def say_hello() -> dict[str, str]:
    return {"hello": "ok"}
