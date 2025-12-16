---
title: Decision BN Analyzer
emoji: 🎯
colorFrom: indigo
colorTo: blue
sdk: docker
app_port: 8501
pinned: false
---

# Decision Analysis by Bayesian Networks

Streamlit app for Bayesian Network decision analysis with LLM-powered case parsing.

**Developer:** Sina Bahrami  
**License:** Business Source License 1.1 (converts to MIT on 2027-12-31)

## Features

- **LLM-Powered Parsing**: Convert natural language cases to Bayesian Networks
- **Multi-Model Fallback**: Supports OpenAI, Groq, and other LLM providers with automatic failover
- **Interactive Queries**: Compute marginals, posteriors with evidence, and expected utilities
- **Decision Analysis**: Automatic optimal action recommendations via influence diagrams
- **Visualizations**: Probability distributions and utility charts

## Quick Start

```bash
# Install dependencies
pip install -r requirements.txt

# Set API key
echo "OPENAI_API_KEY=sk-..." > .env

# Run app
streamlit run app.py
```

## Programmatic Usage

```python
from bn_decision_maker import DecisionBN, CaseParser, SYSTEM_PROMPT

# Parse case with LLM
parser = CaseParser(models=APP_CONFIG["models"])
parsed = parser.parse_case(case_text, SYSTEM_PROMPT)

# Build Bayesian Network
bn = DecisionBN(parsed['bn-data'])

# Query probabilities
marginal = bn.get_marginal("FraudLikelihood")
posterior = bn.get_posterior(["FraudLikelihood"], {"AccountAge": "New"})

# Decision analysis (if utilities defined)
best_action, expected_utility = bn.get_optimal_action()
```

## Architecture

```
├── app.py                              # Streamlit UI
├── bn_decision_maker/
│   ├── bn_decision_maker.py           # BN construction & inference
│   ├── llm_parser.py                  # LLM integration with multi-model fallback
│   ├── config.py                      # System prompts & model configurations
│   └── examples/predefined_cases.py   # Example cases
└── test_decision_maker.py             # Unit tests
```

## Configuration

Edit `bn_decision_maker/config.py` to add LLM models:

```python
APP_CONFIG = {
    "models": [
        {
            "model_name": "gpt-4o-mini",
            "litellm_params": {
                "custom_llm_provider": "openai",
                "env_key": "OPENAI_API_KEY"
            }
        }
    ]
}
```

## Dependencies

- `streamlit` - Web UI
- `pyagrum` - Bayesian Network engine
- `litellm` - Multi-provider LLM API wrapper
- `pandas`, `plotly` - Data handling and visualization
