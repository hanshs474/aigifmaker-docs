# Python

```bash
pip install aigifmaker
```

Set `AIGIFMAKER_API_KEY` (create a key at https://aigifmaker.ai/settings/apikeys) or pass the key to the client. `generate` submits the prompt, waits for the GIF and returns its URL.

```python
from aigifmaker import generate, credits

print(credits())  # remaining credits, free to call
url = generate("a corgi in sunglasses dancing on a beach, looping")
print(url)        # the finished GIF
```

## Submit now, collect later

```python
from aigifmaker import Client

gif = Client(api_key="sk-...", timeout=300)   # seconds, 5 minutes by default
task_id = gif.submit("happy birthday text bouncing in rainbow letters")
print(gif.status(task_id)["status"])           # pending | processing | success | failed
url = gif.wait(task_id)                        # polls every 3 seconds
```

Queued GIFs (accounts that have not bought credits yet) report `processing` with `queued: true` until their turn; the client keeps polling.

Errors are subclasses of `AigifmakerError`: `AuthError`, `QuotaError`, `RejectedError`. Standard library only.

Each GIF costs 1 credit, the same as on the website. Request and answer shapes: [HTTP API](../http.md).
