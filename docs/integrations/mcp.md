# MCP server (Claude, Cursor, Gemini CLI)

`aigifmaker-mcp` is a stdio MCP server that lets any MCP client turn a sentence into an animated GIF: ask for a GIF in chat and get the URL back.

```json
{
  "mcpServers": {
    "aigifmaker": {
      "command": "npx",
      "args": ["-y", "aigifmaker-mcp"],
      "env": { "AIGIFMAKER_API_KEY": "sk-..." }
    }
  }
}
```

That block goes in Claude Desktop's `claude_desktop_config.json`, Cursor's `.cursor/mcp.json`, or any client that reads the same format.

- Claude Code: `claude mcp add aigifmaker -e AIGIFMAKER_API_KEY=sk-... -- npx -y aigifmaker-mcp`
- Gemini CLI: `gemini extensions install https://github.com/hanshs474/aigifmaker-mcp`
- Claude Code plugin: `claude plugin marketplace add hanshs474/aigifmaker-mcp`, then `claude plugin install aigifmaker@aigifmaker`

Create the key at https://aigifmaker.ai/settings/apikeys.

| Tool | What it does |
|---|---|
| `generate_gif` | Text prompt in, animated GIF URL out. Waits for the GIF (usually about a minute) |
| `check_credits` | Credits left on your account, free to call |

Each GIF costs 1 credit on your AI GIF Maker account, the same as on the website. New accounts get one free GIF (it carries a small aigifmaker.ai badge).
