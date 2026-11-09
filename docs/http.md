# HTTP API

Base URL `https://aigifmaker.ai`. Every call is a `POST` with `Authorization: Bearer sk-...` (create a key at https://aigifmaker.ai/settings/apikeys).

Every answer is **HTTP 200**; read the JSON `code`, not the status line:

```json
{"code": 0, "message": "ok", "data": { ... }}
{"code": -1, "message": "<why>"}
```

## Submit a GIF

```bash
curl -s -X POST https://aigifmaker.ai/api/ai/generate \
  -H "Authorization: Bearer $AIGIFMAKER_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "provider": "openlux",
    "mediaType": "image",
    "model": "gif-maker-v1",
    "scene": "text-to-image",
    "prompt": "a paper plane looping over a city skyline at sunset",
    "options": {"output_format": "gif"}
  }'
```

Send the body exactly as shown; only `prompt` changes.

Answer:

```json
{"code": 0, "message": "ok", "data": {"id": "<task id>", "status": "pending", "taskId": "...", ...}}
```

Keep **`data.id`**: that is what the status call takes.

## Ask for the status

```bash
curl -s -X POST https://aigifmaker.ai/api/ai/query \
  -H "Authorization: Bearer $AIGIFMAKER_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"taskId": "<data.id from the submit call>"}'
```

Answer:

```json
{"code": 0, "message": "ok", "data": {
  "id": "...",
  "status": "success",
  "images": ["https://.../your.gif"],
  "watermarked": [false]
}}
```

| `status` | What to do |
|---|---|
| `pending`, `processing` | Ask again in 3 seconds |
| `success` | The GIF is `images[0]` |
| `failed`, `canceled` | Stop; `errorMessage` says why, `refundNote` says what happened to the credit |

Optional fields: `queued: true` and `queueEta` (seconds) while an account that has not bought credits waits in the queue; this is normal, keep polling. `failureKind: "moderation"` when the content filter refused the prompt. `watermarked` is `true` for the free GIF with the aigifmaker.ai badge.

The SDKs poll every 3 seconds and give up after 5 minutes by default.

## Credit balance (free)

```bash
curl -s -X POST https://aigifmaker.ai/api/user/get-user-credits \
  -H "Authorization: Bearer $AIGIFMAKER_API_KEY"
```

Answer: `{"code": 0, "message": "ok", "data": {"remainingCredits": 12, "made": 3}}`.

## Errors

| Answer | Meaning | SDK error |
|---|---|---|
| `code: -1`, message contains `invalid API key` or `no auth` | The key is wrong, deleted or missing | `AuthError` |
| `code: 0` with `data.wall: true` | No key was sent | `AuthError` |
| `code: -1`, message contains `insufficient credits` | The account is out of credits; top up on the [pricing](https://aigifmaker.ai/pricing?utm_source=readthedocs&utm_medium=package) page | `QuotaError` |
| `code` other than `0` and `-1`, or `failureKind: "moderation"` | The prompt was refused, or a cooldown after a refusal is active; reword it | `RejectedError` |
| any other `code: -1` | The message says why | `AigifmakerError` |

The real answer to a wrong key:

```json
{"code": -1, "message": "invalid API key — create one at https://aigifmaker.ai/settings/apikeys"}
```

and to a submit with no key:

```json
{"code": 0, "message": "ok", "data": {"wall": true, "reason": "anon_credits", "cost": 1, "remaining": 0, "grant": 0}}
```
