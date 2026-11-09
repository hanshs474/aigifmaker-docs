# Dart / Flutter

```bash
dart pub add aigifmaker
```

Set `AIGIFMAKER_API_KEY` (create a key at https://aigifmaker.ai/settings/apikeys) or pass the key to the client. `generate` submits the prompt, waits for the GIF and returns its URL.

```dart
import 'package:aigifmaker/aigifmaker.dart';

Future<void> main() async {
  final gif = Aigifmaker(); // reads AIGIFMAKER_API_KEY
  print(await gif.credits()); // remaining credits, free to call
  print(await gif.generate('a corgi in sunglasses dancing on a beach, looping'));
  gif.close();
}
```

## Submit now, collect later

```dart
final gif = Aigifmaker(apiKey: 'sk-...', timeout: const Duration(minutes: 5));
final taskId = await gif.submit('happy birthday text bouncing in rainbow letters');
final st = await gif.status(taskId); // st.status: pending | processing | success | failed
final url = await gif.wait(taskId);  // polls every 3 seconds
```

Queued GIFs (accounts that have not bought credits yet) report `processing` with `queued: true` until their turn; the client keeps polling.

Each GIF costs 1 credit, the same as on the website. Request and answer shapes: [HTTP API](../http.md).
