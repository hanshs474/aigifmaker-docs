# Rust

```bash
cargo add aigifmaker
```

Set `AIGIFMAKER_API_KEY` (create a key at https://aigifmaker.ai/settings/apikeys) or pass the key to the client. `generate` submits the prompt, waits for the GIF and returns its URL.

```rust
let url = aigifmaker::generate("a cat dancing in the rain, pixel art")?;
println!("{url}");
```

## Submit now, collect later

```rust
use std::time::Duration;

let mut client = aigifmaker::Client::new("sk-...");   // or Client::from_env()
client.timeout = Duration::from_secs(600);           // default: 5 minutes, polling every 3 seconds
let left = client.credits()?;                         // free to call
let id = client.submit("a rocket launching, retro cartoon")?;
let status = client.status(&id)?;                     // pending | processing | success | failed
let url = client.wait(&id)?;
```

Queued GIFs (accounts that have not bought credits yet) report `processing` with `queued: true` until their turn; the client keeps polling.

Each GIF costs 1 credit, the same as on the website. Request and answer shapes: [HTTP API](../http.md).
