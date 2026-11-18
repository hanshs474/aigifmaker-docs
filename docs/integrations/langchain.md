# LangChain integration

`langchain-aigifmaker` wraps AI GIF Maker as a LangChain tool (`AigifmakerGifGenerator`) on your [AI GIF Maker](https://aigifmaker.ai/?utm_source=readthedocs&utm_medium=langchain) API key.

```bash
pip install langchain-aigifmaker
export AIGIFMAKER_API_KEY=sk-...   # create one at https://aigifmaker.ai/settings/apikeys
```

```python
from langchain_aigifmaker import AigifmakerGifGenerator

gif = AigifmakerGifGenerator()
url = gif.invoke({"prompt": "a corgi in sunglasses dancing on a beach, looping"})
```

- **PyPI**: [langchain-aigifmaker](https://pypi.org/project/langchain-aigifmaker/)
- **Source**: [hanshs474/langchain-aigifmaker](https://github.com/hanshs474/langchain-aigifmaker)
- **Pricing**: 1 GIF = 1 credit; every new account gets 1 free badged GIF, and credit packs start at $3.99 at [aigifmaker.ai/pricing](https://aigifmaker.ai/pricing?utm_source=readthedocs&utm_medium=langchain).
