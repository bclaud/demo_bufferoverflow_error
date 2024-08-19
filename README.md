## How to reproduce it

```sh
nix run github:bclaud/demo_bufferoverflow_error#default
```

Application is also available without `poetry2nix`. but the result still the same.

```sh
poetry run github:bclaud/demo_bufferoverflow_error#demoErrorBuildPythonApp
```

Server will start to listen on port 8000. As soon as a request is sended

```sh
curl http://localhost:8000
```

server shuts down with the following error
```sh
INFO:     Started server process [156746]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
INFO:     Uvicorn running on http://0.0.0.0:8000 (Press CTRL+C to quit)
*** buffer overflow detected ***: terminated
fish: Job 2, 'nix run' terminated by signal SIGABRT (Abort)
```

If we start the server using poetry, there is no such a problem.

To reproduce, download the repo, then ``direnv allow`` to enable poetry and then
```sh
poetry run demo-error
```

I already tried ``nix run --no-sandbox``.


## Isolated issue

the issue seems to be on msgspec lib.

Specificaly when you try to encode any `int`. This results on buffer overflow

buffer overflow:
```python
import msgspec

msgspec.json.encode({'status_code': 500, 'detail': 'Internal Server Error'})
```

no error:

```python
import msgspec

msgspec.json.encode({'anything': 'that is not a integer'})
```

however, it encodes for both yaml and toml

```python
>>> msgspec.yaml.encode({"a": "dict"})
b'a: dict\n'
>>> msgspec.yaml.encode({"a": 123})
b'a: 123\n'
>>>
```
