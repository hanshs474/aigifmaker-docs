# Elixir

```elixir
# mix.exs
def deps do
  [{:aigifmaker, "~> 0.1"}]
end
```

Set `AIGIFMAKER_API_KEY` (create a key at https://aigifmaker.ai/settings/apikeys) or pass the key to the client. `generate` submits the prompt, waits for the GIF and returns its URL.

```elixir
{:ok, url} = Aigifmaker.generate("a corgi in sunglasses dancing on a beach")
{:ok, left} = Aigifmaker.credits()
```

## Submit now, collect later

```elixir
{:ok, id} = Aigifmaker.submit("happy birthday text bouncing in rainbow letters", api_key: "sk-...")
{:ok, status} = Aigifmaker.status(id)   # "status" => pending | processing | success | failed
{:ok, url} = Aigifmaker.wait(id, timeout: 300_000)
```

Queued GIFs (accounts that have not bought credits yet) report `processing` with `queued: true` until their turn; the client keeps polling.

Failures are `{:error, reason, message}` with `reason` one of `:auth`, `:quota`, `:rejected`, `:failed`, `:timeout`, `:other`. Uses only OTP's `:httpc`.

Each GIF costs 1 credit, the same as on the website. Request and answer shapes: [HTTP API](../http.md).
