# Quickstart

## 1. Get a key

Sign in on AI GIF Maker and create a key at https://aigifmaker.ai/settings/apikeys. Then export it:

```bash
export AIGIFMAKER_API_KEY=sk-...
```

The key runs on your account exactly like the website does, and every GIF shows up in your history there.

## 2. Check the balance (free)

```bash
curl -s -X POST https://aigifmaker.ai/api/user/get-user-credits \
  -H "Authorization: Bearer $AIGIFMAKER_API_KEY"
```

```json
{"code": 0, "message": "ok", "data": {"remainingCredits": 12, "made": 3}}
```

## 3. Make a GIF

The shortest path is an SDK, which submits, waits and returns the URL:

```bash
pip install aigifmaker
python -c 'from aigifmaker import generate; print(generate("a corgi in sunglasses dancing on a beach"))'
```

Or with `curl`, submit and keep `data.id`:

```bash
curl -s -X POST https://aigifmaker.ai/api/ai/generate \
  -H "Authorization: Bearer $AIGIFMAKER_API_KEY" -H "Content-Type: application/json" \
  -d '{"provider":"openlux","mediaType":"image","model":"gif-maker-v1","scene":"text-to-image","prompt":"a corgi in sunglasses dancing on a beach","options":{"output_format":"gif"}}'
```

then ask every 3 seconds until `status` is `success`; the GIF is `data.images[0]`:

```bash
curl -s -X POST https://aigifmaker.ai/api/ai/query \
  -H "Authorization: Bearer $AIGIFMAKER_API_KEY" -H "Content-Type: application/json" \
  -d '{"taskId":"<data.id from the submit call>"}'
```

A GIF usually takes about a minute. Accounts that have not bought credits yet may wait in a short queue first (`queued: true`, `queueEta` in seconds); keep polling.

Each GIF costs 1 credit. New accounts get one free GIF (it carries a small aigifmaker.ai badge). See the [HTTP API](http.md) for every answer and error.
