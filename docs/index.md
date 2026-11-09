# AI GIF Maker API and SDKs

Turn text into animated GIFs with AI GIF Maker. Native GIF generation — no video conversion. Type what you want and download your GIF in about a minute.

These are the official docs for calling [AI GIF Maker](https://aigifmaker.ai/?utm_source=readthedocs&utm_medium=package) from your own code. The same account and the same API key work from plain HTTP, from an SDK in ten languages, and from any MCP client: send a prompt, get back the URL of a finished, looping GIF.

```bash
curl -s -X POST https://aigifmaker.ai/api/ai/generate \
  -H "Authorization: Bearer $AIGIFMAKER_API_KEY" -H "Content-Type: application/json" \
  -d '{"provider":"openlux","mediaType":"image","model":"gif-maker-v1","scene":"text-to-image","prompt":"a corgi in sunglasses dancing on a beach","options":{"output_format":"gif"}}'
```

## Where to go next

- [Quickstart](quickstart.md): a key and your first GIF in three steps.
- [HTTP API](http.md): the three calls every client makes, with every answer and error.
- [SDKs](sdk/index.md): Python, JavaScript / TypeScript, Go, Rust, Ruby, PHP, Dart, Elixir, .NET and Java.
- [MCP server](integrations/mcp.md): ask for a GIF from Claude, Cursor or Gemini CLI.

## API key

Create a key at https://aigifmaker.ai/settings/apikeys and export it as `AIGIFMAKER_API_KEY`. Every SDK reads that variable.

## Credits

Each GIF costs 1 credit on your AI GIF Maker account, the same as on the website. New accounts get one free GIF (it carries a small aigifmaker.ai badge). If a GIF fails, its credit is refunded. Credit packs are on the [pricing](https://aigifmaker.ai/pricing?utm_source=readthedocs&utm_medium=package) page.

Questions: support@aigifmaker.ai.
