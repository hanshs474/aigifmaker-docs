# .NET

```bash
dotnet add package Aigifmaker
```

Set `AIGIFMAKER_API_KEY` (create a key at https://aigifmaker.ai/settings/apikeys) or pass the key to the client. `generate` submits the prompt, waits for the GIF and returns its URL.

```csharp
using Aigifmaker;

var gifs = new AigifmakerClient(); // reads AIGIFMAKER_API_KEY
string url = await gifs.GenerateAsync("a corgi in sunglasses dancing on a beach, confetti falling");
```

## Submit now, collect later

```csharp
string id = await gifs.SubmitAsync("a paper plane looping over a city skyline at sunset");
AigifmakerStatus s = await gifs.StatusAsync(id); // s.Status: pending | processing | success | failed
if (s.IsSuccess) Console.WriteLine(s.Url);
int left = await gifs.CreditsAsync();            // free to call
```

Queued GIFs (accounts that have not bought credits yet) report `processing` with `queued: true` until their turn; the client keeps polling.

Errors: `AuthException`, `QuotaException`, `RejectedException`, all deriving from `AigifmakerException`. Targets .NET 8 and .NET Standard 2.0.

Each GIF costs 1 credit, the same as on the website. Request and answer shapes: [HTTP API](../http.md).
