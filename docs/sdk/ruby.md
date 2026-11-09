# Ruby

```bash
gem install aigifmaker
```

Set `AIGIFMAKER_API_KEY` (create a key at https://aigifmaker.ai/settings/apikeys) or pass the key to the client. `generate` submits the prompt, waits for the GIF and returns its URL.

```ruby
require "aigifmaker"

puts Aigifmaker.credits # remaining credits, free to call
url = Aigifmaker.generate("a corgi in sunglasses dancing on a beach, looping")
```

## Submit now, collect later

```ruby
gif = Aigifmaker::Client.new("sk-...", timeout: 300) # seconds, 5 minutes by default
task_id = gif.submit("happy birthday text bouncing in rainbow letters")
puts gif.status(task_id)["status"] # pending | processing | success | failed
url = gif.wait(task_id)            # polls every 3 seconds
```

Queued GIFs (accounts that have not bought credits yet) report `processing` with `queued: true` until their turn; the client keeps polling.

Each GIF costs 1 credit, the same as on the website. Request and answer shapes: [HTTP API](../http.md).
