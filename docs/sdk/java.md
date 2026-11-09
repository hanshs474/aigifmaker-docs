# Java / Kotlin

```xml
<dependency>
  <groupId>io.github.hanshs474</groupId>
  <artifactId>aigifmaker</artifactId>
  <version>0.1.0</version>
</dependency>
```

Set `AIGIFMAKER_API_KEY` (create a key at https://aigifmaker.ai/settings/apikeys) or pass the key to the client. `generate` submits the prompt, waits for the GIF and returns its URL.

```java
import io.github.hanshs474.aigifmaker.Aigifmaker;

Aigifmaker gifs = new Aigifmaker(); // reads AIGIFMAKER_API_KEY
String url = gifs.generate("a corgi in sunglasses dancing on a beach, confetti falling");
```

## Submit now, collect later

```java
String id = gifs.submit("a paper plane looping over a city skyline at sunset");
Aigifmaker.Status s = gifs.status(id); // s.status: pending | processing | success | failed
if (s.isSuccess()) System.out.println(s.url());
int left = gifs.credits();             // free to call
```

Queued GIFs (accounts that have not bought credits yet) report `processing` with `queued: true` until their turn; the client keeps polling.

Gradle: `implementation("io.github.hanshs474:aigifmaker:0.1.0")`. Errors: `AigifmakerException.AuthException`, `QuotaException`, `RejectedException`. Java 11+, no dependencies.

Each GIF costs 1 credit, the same as on the website. Request and answer shapes: [HTTP API](../http.md).
