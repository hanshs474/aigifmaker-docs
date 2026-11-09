# SDKs

Every SDK has the same four calls: `generate(prompt)` submits, waits and returns the GIF URL; `submit(prompt)` returns a task id; `status(id)` returns where it stands; `credits()` returns the balance (free). All read `AIGIFMAKER_API_KEY` (create a key at https://aigifmaker.ai/settings/apikeys), poll every 3 seconds and give up after 5 minutes by default, and raise the same errors: `AuthError` (wrong or missing key), `QuotaError` (out of credits), `RejectedError` (prompt refused) and a base `AigifmakerError`.

| Language | Registry | Install |
|---|---|---|
| [Python](python.md) | PyPI | `pip install aigifmaker` |
| [JavaScript / TypeScript](javascript.md) | npm and JSR | `npm install aigifmaker` |
| [Go](go.md) | pkg.go.dev | `go get github.com/hanshs474/aigifmaker-go` |
| [Rust](rust.md) | crates.io | `cargo add aigifmaker` |
| [Ruby](ruby.md) | RubyGems | `gem install aigifmaker` |
| [PHP](php.md) | Packagist | `composer require hanshs474/aigifmaker` |
| [Dart / Flutter](dart.md) | pub.dev | `dart pub add aigifmaker` |
| [Elixir](elixir.md) | Hex | `{:aigifmaker, "~> 0.1"}` |
| [.NET](dotnet.md) | NuGet | `dotnet add package Aigifmaker` |
| [Java / Kotlin](java.md) | Maven Central | `io.github.hanshs474:aigifmaker` |

From an agent instead of code: the [MCP server](../integrations/mcp.md). Writing your own client: the [HTTP API](../http.md) is three calls.
