# JavaScript / TypeScript

```bash
npm install aigifmaker
# Deno / JSR
deno add jsr:@aigifmaker/aigifmaker
```

Set `AIGIFMAKER_API_KEY` (create a key at https://aigifmaker.ai/settings/apikeys) or pass the key to the client. `generate` submits the prompt, waits for the GIF and returns its URL.

```ts
import { generate, credits } from "aigifmaker";

console.log(await credits()); // remaining credits, free to call
const url = await generate("a corgi in sunglasses dancing on a beach, looping");
console.log(url);             // the finished GIF
```

## Submit now, collect later

```ts
import { Client } from "aigifmaker";

const gif = new Client({ apiKey: "sk-...", timeout: 300_000 }); // milliseconds, 5 minutes by default
const id = await gif.submit("happy birthday text bouncing in rainbow letters");
console.log((await gif.status(id)).status); // pending | processing | success | failed
const url = await gif.wait(id);              // polls every 3 seconds
```

Queued GIFs (accounts that have not bought credits yet) report `processing` with `queued: true` until their turn; the client keeps polling.

Errors: `AuthError`, `QuotaError`, `RejectedError`, all extending `AigifmakerError`. Node 18+, Deno and Bun; no dependencies.

Each GIF costs 1 credit, the same as on the website. Request and answer shapes: [HTTP API](../http.md).
