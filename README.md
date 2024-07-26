## How to reproduce it

``sh
nix run github:bclaud/demo_bufferoverflow_error#default
``

Server will start to listen on port 8000. As soon as a request is sended

``sh
curl http://localhost:8000
``

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

