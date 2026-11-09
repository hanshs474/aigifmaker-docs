# PHP

```bash
composer require hanshs474/aigifmaker
```

Set `AIGIFMAKER_API_KEY` (create a key at https://aigifmaker.ai/settings/apikeys) or pass the key to the client. `generate` submits the prompt, waits for the GIF and returns its URL.

```php
<?php
require 'vendor/autoload.php';

$gif = new Aigifmaker\Client();   // reads AIGIFMAKER_API_KEY
echo $gif->credits();             // remaining credits, free to call
$url = $gif->generate('a corgi in sunglasses dancing on a beach, looping');
```

## Submit now, collect later

```php
$gif = new Aigifmaker\Client('sk-...', timeout: 300);   // seconds, 5 minutes by default
$taskId = $gif->submit('happy birthday text bouncing in rainbow letters');
echo $gif->status($taskId)['status'];                    // pending | processing | success | failed
$url = $gif->wait($taskId);                              // polls every 3 seconds
```

Queued GIFs (accounts that have not bought credits yet) report `processing` with `queued: true` until their turn; the client keeps polling.

Each GIF costs 1 credit, the same as on the website. Request and answer shapes: [HTTP API](../http.md).
