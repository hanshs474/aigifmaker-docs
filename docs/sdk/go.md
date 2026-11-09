# Go

```bash
go get github.com/hanshs474/aigifmaker-go
```

Set `AIGIFMAKER_API_KEY` (create a key at https://aigifmaker.ai/settings/apikeys) or pass the key to the client. `generate` submits the prompt, waits for the GIF and returns its URL.

```go
import aigifmaker "github.com/hanshs474/aigifmaker-go"

url, err := aigifmaker.Generate(ctx, "a cat dancing in the rain, pixel art")
```

## Submit now, collect later

```go
c := aigifmaker.New("")                  // "" reads AIGIFMAKER_API_KEY
id, err := c.Submit(ctx, "a rocket launching, retro cartoon")
st, err := c.Status(ctx, id)            // st.Status: pending | processing | success | failed
url := st.URL()                         // the GIF, once st.Status == "success"
left, err := c.Credits(ctx)             // credits left, free to call
```

Queued GIFs (accounts that have not bought credits yet) report `processing` with `queued: true` until their turn; the client keeps polling.

A command-line tool comes with it: `go install github.com/hanshs474/aigifmaker-go/cmd/aigifmaker@latest`, then `aigifmaker "a cat dancing in the rain"`.

Each GIF costs 1 credit, the same as on the website. Request and answer shapes: [HTTP API](../http.md).
