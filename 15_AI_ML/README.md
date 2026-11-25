# 15 — AI / ML (Cross-cutting)

> Machine learning sits mostly at the runtime + application layers but pulls
> hard on CPU/GPU/accelerator hardware below and the network above. This
> layer collects models, training, inference, agents, and tooling.

## Across the stack

```text
this layer cuts across the stack rather than sitting in one place

  13  Network Application  ─┐
  08  User Applications    ─┤      ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  07  Runtime Environment  ─┼──────┃  15  AI / ML                          ◀── here   ┃
  06  System Libraries     ─┤      ┃      models · training · inference · agents      ┃
  02  CPU / accelerators   ─┘      ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

a model is maths on an accelerator, shipped as an API
```

## At a glance

| Field | Value |
|-------|-------|
| Spans | 02 (accelerators), 06–08 (runtimes/apps), 13 (APIs) |
| Description | Models, training, inference, agents, evaluation, safety |
| Languages | Python (dominant), C++/CUDA (kernels), Rust (infra), JS/TS (apps) |
| Subdomains | Classical ML, deep learning, LLMs, embeddings/RAG, agents, RL, MLOps |

## What lives here

- **Classical ML** — linear/logistic regression, trees, GBDTs, SVMs, k-NN, clustering
- **Deep learning** — MLP, CNN, RNN, Transformer, diffusion, mixture-of-experts
- **LLMs** — open & closed models, prompting, fine-tuning, alignment
- **Embeddings & vector search** — RAG patterns, hybrid retrieval
- **Agents** — tool use, planning, MCP-style protocols
- **Reinforcement learning** — value/policy methods, RLHF, DPO, PPO
- **Computer vision, speech, multimodal**
- **MLOps** — datasets, training, eval, deploy, observability, governance
- **Hardware** — NVIDIA/AMD/Intel GPUs, TPUs, Apple Neural Engine, NPUs
- **AI safety & policy** — capability evals, jailbreaks, red-teaming, governance

## In this layer

Everything for this layer is on this page or one click away.

| Section | Notes | What's there |
|---------|-------|--------------|
| [References](#references) | — | papers, books, courses, benchmarks |
| [Lessons](#lessons) | [Interactive labs](ml_labs.md) | from scratch nets to fine-tuning to agents |
| [Languages](#languages) | — | frameworks & DSLs |
| [Manual Pages](#manual-pages) | [AI/ML Tools Reference](ml_tools.md) | `nvidia-smi`, `torchrun`, `huggingface-cli`, `ollama` |
| [Topics](#topics) | [Transformer Architecture](transformer_architecture.md) | architectures, training, alignment, RAG, agents |
| [Protocols](#protocols) | — | API specs, MCP, model serving, formats |

## Cross-references
- Accelerator hardware → [CPU › Topics](../02_CPU/README.md#topics) + GPU/NPU notes
- Inference runtimes & serving → [07_Runtime_Environment](../07_Runtime_Environment/)
- AI-enabled apps → [08_User_Applications](../08_User_Applications/)
- Model API endpoints → [13_Network_Application](../13_Network_Application/)
- Prompt injection, model abuse → [Security › Topics](../14_Security/README.md#topics)

---

## References

### What is in this section

```text
  Textbooks, seminal papers, and online resources for AI/ML study.

  ┌─── foundations textbooks ─────────────────────────────────────────────┐
  │  Goodfellow et al. · Bishop PRML · Murphy Prob. ML · d2l.ai           │
  │  ESL/ISL · Sutton & Barto (RL) · Géron hands-on                       │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── seminal papers ────────────────────────────────────────────────────┐
  │  "Attention Is All You Need" · BERT · GPT series · LLaMA              │
  │  InstructGPT (RLHF) · Constitutional AI · LoRA · Flash Attention      │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── online resources ──────────────────────────────────────────────────┐
  │  fast.ai · cs231n · cs224n · Andrej Karpathy's YT                     │
  │  HuggingFace docs · Papers With Code · ArXiv (cs.LG / cs.CL)         │
  └───────────────────────────────────────────────────────────────────────┘
```

### Books — foundations
- *Deep Learning* — Goodfellow, Bengio, Courville. The textbook.
- *Pattern Recognition and Machine Learning* — Bishop.
- *Probabilistic Machine Learning* (Vol 1 & 2) — Kevin Murphy.
- *The Elements of Statistical Learning* — Hastie, Tibshirani, Friedman.
- *An Introduction to Statistical Learning* — same authors (gentler intro).
- *Reinforcement Learning: An Introduction* — Sutton & Barto.
- *Dive into Deep Learning* (`d2l.ai`) — free, code+math.

### Books — applied / modern
- *Hands-On Machine Learning with Scikit-Learn, Keras, and TensorFlow* — Géron.
- *Designing Machine Learning Systems* — Chip Huyen.
- *Building LLMs for Production* — various, fast-moving topic.
- *Natural Language Processing with Transformers* — Tunstall, von Werra, Wolf.
- *Generative Deep Learning* — David Foster.

### Seminal papers
- **"Attention Is All You Need"** — Vaswani et al. (Transformer)
- **GPT-1/2/3/4 technical reports** (OpenAI)
- **BERT** — Devlin et al.
- **LLaMA / LLaMA 2 / 3 / 4** — Meta technical reports
- **InstructGPT (RLHF)** — Ouyang et al.
- **Constitutional AI** — Anthropic
- **DPO: Direct Preference Optimization** — Rafailov et al.
- **Chain-of-Thought, Tree-of-Thought, ReAct, Reflexion** — reasoning papers
- **RAG: Retrieval-Augmented Generation** — Lewis et al.
- **DDPM / DDIM / Stable Diffusion / Imagen / DALL·E 2/3** — diffusion line
- **AlphaGo / AlphaZero / MuZero / AlphaFold** — DeepMind classics
- **Scaling Laws (Kaplan, Chinchilla)** — model sizing

### Online
- arXiv (`cs.LG`, `cs.CL`, `cs.CV`, `cs.AI`)
- Papers With Code
- HuggingFace Hub & docs
- Anthropic / OpenAI / DeepMind / Meta AI / Google Research blogs
- Lilian Weng's blog (lilianweng.github.io)
- Sebastian Raschka's blog & books
- Jay Alammar's illustrated transformer/BERT/GPT posts

### Courses
- Andrej Karpathy — "Zero to Hero" YouTube series (free, hands-on)
- fast.ai courses
- Stanford CS231n (vision), CS224n (NLP), CS285 (RL)
- HuggingFace courses (NLP, RL, Audio, Diffusion)

### Benchmarks & evals
- MMLU, MMLU-Pro, BBH, HellaSwag, ARC, TruthfulQA
- HumanEval, MBPP, SWE-bench (code)
- GSM8K, MATH, AIME (math)
- LMSYS Chatbot Arena, MT-Bench
- HELM (Stanford), Open LLM Leaderboard
- Multimodal: MMMU, MathVista, VQA

---

## Lessons

### What is in this section

```text
  Lesson ladder: math foundations → deep learning → LLMs → agents.

  ┌─── dedicated module ──────────────────────────────────────────────────┐
  │  ml_labs.md (PyTorch MNIST · attention visualization · ONNX export)  │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── foundations (1–4) ─────────────────────────────────────────────────┐
  │  linear algebra · calc + probability · ML from scratch · Karpathy    │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── deep learning (5–9) ───────────────────────────────────────────────┐
  │  PyTorch · CNN · RNN/LSTM · Transformer from scratch · diffusion     │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── LLMs & agents (10–15) ─────────────────────────────────────────────┐
  │  tokenization · local model · fine-tune (LoRA/QLoRA) · evaluation   │
  │  RAG · agent frameworks · production serving                          │
  └───────────────────────────────────────────────────────────────────────┘
```

### Dedicated Lesson Modules

| File | Covers |
|------|--------|
| [AI/ML — Interactive Labs](ml_labs.md) | PyTorch MNIST, attention visualization, ONNX export |

### Foundations
1. **Linear algebra refresher** — vectors, matrices, eigenvalues, SVD, autograd intuition.
2. **Calc + probability** — gradients, chain rule, Bayes, expectation, entropy.
3. **From scratch ML** — implement linear/logistic regression, KNN, k-means without sklearn.
4. **Karpathy "Zero to Hero"** — micrograd → makemore → minBPE → nanoGPT, in order.

### Deep learning
5. **PyTorch fundamentals** — tensors, autograd, nn.Module, datasets, training loop.
6. **CNN on CIFAR-10 / MNIST** — beat a baseline; understand overfitting.
7. **RNN/LSTM/GRU** — character-level language model.
8. **Transformer from scratch** — re-derive attention; train a tiny LM.
9. **Diffusion model** — implement a DDPM on a toy dataset.

### LLMs
10. **Tokenization** — BPE / SentencePiece / tiktoken; understand subwords.
11. **Run a local model** — Ollama / llama.cpp / vLLM with Llama 3 / Mistral / Qwen.
12. **Fine-tune** — LoRA / QLoRA on a small dataset; TRL / Axolotl / Unsloth.
13. **Preference tuning** — DPO on a small preference dataset.
14. **Evaluation** — MMLU subset + a custom eval suite for your use case.

### Prompting & agents
15. **Prompt engineering** — system/user/assistant, few-shot, role-play, chain-of-thought.
16. **Function / tool calling** — OpenAI-style tools, Anthropic tool use, schemas.
17. **RAG** — embeddings + vector store + retriever + reranker + LLM.
18. **Hybrid retrieval** — BM25 + dense; reciprocal rank fusion.
19. **Agent loop** — ReAct/Reflexion; observe → think → act; budget control.
20. **MCP servers** — write a Model Context Protocol server; expose tools to a model.

### Computer vision / multimodal
21. **CLIP basics** — image-text embedding; zero-shot classification.
22. **Vision Transformer** — fine-tune ViT for a custom task.
23. **Detection / segmentation** — YOLO / SAM / Mask R-CNN walkthrough.

### RL
24. **Tabular RL** — Q-learning on FrozenLake / Taxi.
25. **DQN** on CartPole / Atari (small game).
26. **PPO** with stable-baselines3.

### MLOps & deployment
27. **Experiment tracking** — Weights & Biases / MLflow / Aim.
28. **Data versioning** — DVC / lakeFS.
29. **Serve a model** — TorchServe / vLLM / Triton; benchmark throughput & latency.
30. **Quantization** — INT8/INT4 with bitsandbytes/AWQ/GPTQ; measure quality loss.
31. **Deploy on-device** — Core ML / ONNX Runtime / llama.cpp / MLC LLM.

### Safety & evals (cross-link [14_Security](../14_Security/))
32. **Red-team your prompt** — jailbreaks, prompt injection in tool outputs.
33. **Eval harness** — write graded prompts; track regressions across model upgrades.

---

## Languages

### What is in this section

```text
  Languages for AI/ML work, from training to deployment.

  ┌─── core / compute ────────────────────────────────────────────────────┐
  │  Python (dominant) · C++ (kernels, inference engines)                 │
  │  CUDA C++ · HIP/ROCm · Metal Shading Language · Triton · Mojo        │
  │  Rust (serving infra) · Julia (scientific ML) · JS/TS (browser)       │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── Python frameworks ─────────────────────────────────────────────────┐
  │  PyTorch · JAX (XLA) · TensorFlow/Keras · scikit-learn               │
  │  XGBoost/LightGBM/CatBoost · HuggingFace ecosystem                   │
  └───────────────────────────────────────────────────────────────────────┘
```

### Core
| Language | Where |
|----------|-------|
| Python | Dominant — training, inference orchestration, eval, agents |
| C++ | Performance kernels, inference engines (llama.cpp, ggml, ONNX Runtime) |
| CUDA C++ | NVIDIA GPU kernels |
| HIP / ROCm | AMD GPU kernels |
| Metal Shading Language | Apple GPU/MPS kernels |
| Triton | OpenAI's GPU kernel DSL (Python) |
| Mojo | Modular's Python-superset (early) |
| Rust | Serving infra, embeddings DBs, candle (HuggingFace) |
| Julia | Scientific ML (Flux.jl, MLJ.jl) |
| JS / TS | Browser inference (TF.js, transformers.js), app glue |

### Python frameworks
| Framework | Notes |
|-----------|-------|
| PyTorch | Default research + production |
| JAX | Functional, XLA-compiled; Flax, Haiku, Equinox on top |
| TensorFlow / Keras | Still significant in industry |
| scikit-learn | Classical ML |
| XGBoost / LightGBM / CatBoost | GBDTs |
| HuggingFace Transformers / Diffusers / Datasets / Accelerate | The ecosystem |
| Lightning / PyTorch Lightning | Training loop wrapper |
| FastAI | High-level on top of PyTorch |
| Ray / Ray Train / Ray Serve | Distributed |
| DeepSpeed / Megatron-LM / FSDP | Large-scale training |
| vLLM / TGI / sglang / TensorRT-LLM | High-throughput inference |
| llama.cpp / ggml | CPU/Metal/CUDA quantized inference (C++) |
| MLX | Apple Silicon framework |

### LLM tooling
| Tool | Purpose |
|------|---------|
| LangChain / LlamaIndex | Orchestration, RAG |
| Haystack | RAG + production search |
| Instructor / Pydantic AI | Typed LLM outputs |
| DSPy | Programmatic prompting |
| LiteLLM | Multi-provider proxy |
| OpenRouter / Together / Replicate / Fireworks | Model marketplaces |
| Ollama / LM Studio / Jan | Local model runners |

### Agents & MCP
- Anthropic Claude SDK, OpenAI Agents SDK
- Model Context Protocol (MCP) — open standard for tool/context exposure
- LangGraph, CrewAI, AutoGen — multi-agent frameworks

### Data / ETL
- pandas / polars / Spark / DuckDB
- Apache Arrow / Parquet
- LakeFS / DVC / Pachyderm (versioning)

### Tracking
- W&B, MLflow, Aim, Neptune, Comet

### Vector DBs & search
- Postgres + pgvector, Qdrant, Weaviate, Milvus, Chroma, Pinecone, FAISS
- BM25 / OpenSearch / Elasticsearch (lexical)

---

## Manual Pages

### What is in this section

```text
  ML tooling, from GPU monitoring to training and serving CLIs.

  ┌─── dedicated subfile ─────────────────────────────────────────────────┐
  │  ml_tools.md (nvidia-smi · nvtop · tensorboard · huggingface-cli)    │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── GPU / hardware monitoring ─────────────────────────────────────────┐
  │  nvidia-smi · nvtop · rocm-smi · intel_gpu_top · tegrastats           │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── CUDA & training ───────────────────────────────────────────────────┐
  │  nvcc · nsys · ncu · torchrun · accelerate · deepspeed                │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── model management & serving ────────────────────────────────────────┐
  │  huggingface-cli · ollama · vllm · tensorboard · wandb / mlflow      │
  └───────────────────────────────────────────────────────────────────────┘
```

### Dedicated man page references

| Topic | File |
|-------|------|
| ML tools | [AI/ML Tools Reference](ml_tools.md) — nvidia-smi, nvtop, tensorboard, huggingface-cli |

---

### GPU / hardware monitoring
| Command | Purpose |
|---------|---------|
| `nvidia-smi` | NVIDIA GPU status + utilization |
| `nvidia-smi dmon` / `pmon` | Continuous monitoring |
| `nvtop` | TUI GPU monitor |
| `rocm-smi` | AMD GPU equivalent |
| `intel_gpu_top` | Intel GPU monitor |
| `tegrastats` | NVIDIA Jetson |
| `powermetrics --samplers gpu_power` | macOS Apple Silicon GPU |

### CUDA & friends
| Command | Purpose |
|---------|---------|
| `nvcc` | NVIDIA CUDA compiler |
| `cuda-gdb` | CUDA debugger |
| `nsys` (Nsight Systems) | System-wide profiler |
| `ncu` (Nsight Compute) | Kernel-level profiler |
| `cupti` | CUDA Profiling Tools Interface |

### PyTorch
| Command | Purpose |
|---------|---------|
| `python -m torch.utils.collect_env` | Env summary for bug reports |
| `torchrun` | Distributed launcher (replaces `torch.distributed.launch`) |
| `torch-tb-profiler` | TensorBoard profiler plugin |

### HuggingFace
| Command | Purpose |
|---------|---------|
| `huggingface-cli login` | Auth |
| `huggingface-cli download model/repo` | Download |
| `huggingface-cli scan-cache` | Disk usage |
| `accelerate config` / `accelerate launch` | Distributed convenience |

### Local LLM runners
| Command | Purpose |
|---------|---------|
| `ollama run llama3` | Pull + chat |
| `ollama serve` | Local API |
| `llama.cpp` (`llama-server`, `llama-cli`) | C++ runner with quantization |
| `vllm` (`vllm serve`) | High-throughput server |
| `lmstudio` / `jan` | Desktop apps |

### Eval / fine-tune
| Command | Purpose |
|---------|---------|
| `lm-eval` (lm-evaluation-harness) | Benchmarks (MMLU etc.) |
| `axolotl preprocess / train` | Fine-tune convenience |
| `unsloth` | Memory-efficient fine-tuning |
| `trl` CLI | RLHF / DPO via HuggingFace |

### Vector DB CLIs
| Command | Purpose |
|---------|---------|
| `qdrant`, `weaviate`, `milvus`, `chromadb` | Run/operate vector DBs |
| `psql` + `pgvector` | Postgres vector ops |

### MLOps
| Command | Purpose |
|---------|---------|
| `mlflow ui` / `mlflow run` | Experiments + serving |
| `wandb login` / `wandb sync` | W&B CLI |
| `dvc init` / `dvc pull` / `dvc push` | Data versioning |

### Model formats
- **Safetensors** — preferred binary format (no pickle, mmap-friendly)
- **GGUF** — llama.cpp quantized format
- **ONNX** — open exchange
- **Core ML (.mlpackage)** — Apple
- **TFLite** / **TensorRT engines** / **OpenVINO IR**

---

## Topics

### What is in this section

```text
  AI/ML topics: from classical methods to LLM training and production.

  ┌─── classical ML ──────────────────────────────────────────────────────┐
  │  regression · trees (XGBoost/LightGBM) · SVM · clustering · PCA      │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── deep learning & architectures ────────────────────────────────────┐
  │  activations · optimizers · CNN · Transformer · Mamba (SSM)           │
  │  diffusion (DDPM/SD) · multimodal (CLIP · VLMs · Whisper)             │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── LLM training ──────────────────────────────────────────────────────┐
  │  pretraining · SFT · RLHF / DPO · LoRA / QLoRA · scaling laws        │
  │  distributed: FSDP / ZeRO / pipeline / tensor parallelism             │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── inference & production ────────────────────────────────────────────┐
  │  quantization (AWQ/GPTQ/GGUF) · vLLM · RAG · agents · evals          │
  │  safety · alignment (Constitutional AI / RLHF) · MLOps               │
  └───────────────────────────────────────────────────────────────────────┘
```

### Dedicated Topic Deep Dives

| File | Covers |
|------|--------|
| [Transformer Architecture](transformer_architecture.md) | MHA, KV cache, MoE, scaling laws, RoPE |

### Classical ML
- **Linear / logistic regression**, regularization (L1, L2, elastic net)
- **Decision trees, Random Forest, GBDT** (XGBoost, LightGBM, CatBoost)
- **SVM**, kernel methods
- **Clustering** — k-means, DBSCAN, hierarchical
- **Dimensionality reduction** — PCA, t-SNE, UMAP
- **Bayesian** — naive Bayes, Gaussian processes, MCMC

### Deep learning
- **Activations** — ReLU/GELU/SiLU/Swish/Mish, sigmoid, softmax.
- **Optimizers** — SGD, Adam/AdamW, Adafactor, Lion, Schedule-Free.
- **Regularization** — dropout, weight decay, label smoothing, cutmix, mixup.
- **Normalization** — BatchNorm, LayerNorm, RMSNorm, GroupNorm.
- **Initialization** — Xavier, Kaiming, μP scaling.
- **Architectures** — MLP, CNN (ResNet, ConvNeXt), RNN/LSTM/GRU, Transformer, Mamba (SSM), MoE.

### Transformers / LLMs
- **Self-attention, multi-head, KV-cache, MQA/GQA, attention sinks**
- **Positional encoding** — sinusoidal, RoPE, ALiBi, NoPE
- **Activation / normalization variants** — SwiGLU, RMSNorm, pre-norm vs post-norm
- **Decoding** — greedy, beam, top-k/top-p, temperature, min-p, speculative decoding, lookahead
- **Long context** — ring attention, FlashAttention, sliding window, sparse attention
- **MoE** — gating, expert routing, sparsity
- **Tokenization** — BPE, SentencePiece, Unigram, Tiktoken

### Training
- **Datasets** — curation, dedup (MinHash/LSH), filtering, contamination
- **Pretraining** — next-token prediction, masked LM, replaced-token detection
- **SFT** — supervised fine-tuning
- **Preference** — RLHF (PPO), DPO, KTO, ORPO, IPO, SimPO
- **PEFT** — LoRA / QLoRA / DoRA / adapters / prefix tuning
- **Distributed** — DP, DDP, FSDP, ZeRO 1/2/3, Pipeline, Tensor, Sequence parallelism
- **Mixed precision** — fp16, bf16, fp8
- **Scaling laws** — Kaplan, Chinchilla, recent works

### Diffusion & generative
- **DDPM/DDIM** noise schedules
- **Latent diffusion (Stable Diffusion family)**
- **Classifier-free guidance**
- **ControlNet / IP-Adapter / LoRA for diffusion**
- **Image-to-video, video-to-video** (newer)

### Multimodal
- **CLIP-style contrastive learning**
- **VLMs** — vision-language models (LLaVA, BLIP-2, GPT-4V/o, Gemini, Claude vision)
- **Speech** — Whisper, Conformer; TTS (XTTS, OpenVoice, Tortoise, ElevenLabs-style)
- **Audio** — Codec models (EnCodec, SoundStream)

### Inference & serving
- **Quantization** — INT8/INT4 (AWQ, GPTQ, bitsandbytes, GGUF k-quants)
- **KV cache management** — paged attention (vLLM), continuous batching
- **Speculative decoding**, **Medusa heads**, **EAGLE**
- **Batching strategies** — static, dynamic, continuous
- **TensorRT-LLM, ONNX Runtime, OpenVINO** optimizations

### RAG & retrieval
- **Chunking strategies** — fixed, semantic, parent-child
- **Embedding models** — text-embedding-3, BGE, E5, GTE
- **Vector indices** — IVF, HNSW, ScaNN, FAISS variants
- **Hybrid search** — dense + BM25 (RRF), cross-encoders for rerank
- **Long-context vs RAG** tradeoffs

### Agents
- **ReAct, Reflexion, Tree-of-Thoughts**
- **Tool use** — function calling, MCP
- **Planning** — task decomposition, sub-agents, multi-agent orchestration
- **Memory** — episodic, semantic, scratchpad
- **Evaluation** — task success, safety, cost, latency

### RL
- **MDPs**, value/policy iteration
- **Tabular Q-learning, SARSA**
- **DQN, Double DQN, Dueling**
- **Policy gradients** — REINFORCE, A2C/A3C, PPO, GRPO
- **Model-based** — Dyna, MuZero
- **Offline RL** — CQL, IQL

### Evaluation
- **Benchmarks** (see references)
- **LLM-as-judge** — pitfalls, position bias, length bias
- **Pairwise comparison & Elo** (Chatbot Arena)
- **Eval as code** — Promptfoo, LangSmith, Ragas

### Safety & alignment
- **Capability evals**, **dangerous capability evals**
- **Jailbreaks & prompt injection** (cross-link [14_Security](../14_Security/README.md#topics))
- **Constitutional AI**, **RLHF**, **rule-based reward models**
- **Watermarking** for model outputs
- **Privacy** — differential privacy, federated learning, membership inference

### MLOps
- **Experiment tracking, model registry, lineage**
- **Data versioning, validation (Great Expectations / Pandera)**
- **Feature stores** — Feast, Tecton
- **Drift detection** — input drift, prediction drift, label drift
- **Model observability** — Arize, WhyLabs, Fiddler

---

## Protocols

### What is in this section

```text
  AI/ML protocols: tool-use, inference APIs, model exchange, and training.

  ┌─── model context / tool-use ──────────────────────────────────────────┐
  │  MCP · OpenAI Tool Calling · Anthropic Tool Use · Gemini Fn Calling   │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── inference / serving APIs ──────────────────────────────────────────┐
  │  OpenAI Chat Completions / Embeddings · Anthropic Messages            │
  │  HuggingFace TGI · vLLM OpenAI-compatible · OpenAI Responses API     │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── model & tensor exchange ───────────────────────────────────────────┐
  │  ONNX · SafeTensors · GGUF · PyTorch .pt/.pth · HuggingFace Hub      │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── training / communication ──────────────────────────────────────────┐
  │  NCCL (all-reduce) · Gloo · MPI (horovod) · RDMA/InfiniBand          │
  └───────────────────────────────────────────────────────────────────────┘
```

### Model context / tool-use protocols
| Spec | Owner | Purpose |
|------|-------|---------|
| MCP (Model Context Protocol) | Anthropic + community | Standard for exposing tools/resources/prompts to LLMs |
| OpenAI Tool Calling | OpenAI | Function calls schema in chat completions |
| Anthropic Tool Use | Anthropic | Tool definitions + tool_use / tool_result blocks |
| Gemini Function Calling | Google | Similar pattern |
| OpenAI Assistants API | OpenAI | Threaded assistants with tools + files |

### Inference / serving APIs (de facto wire compat)
| API | Purpose |
|-----|---------|
| OpenAI Chat Completions | The most widely-cloned schema |
| OpenAI Embeddings | Standard embedding API shape |
| Anthropic Messages | System + user + assistant turns |
| Google Gemini REST | Similar request shape |
| HuggingFace Inference Endpoints / TGI | Open-source serving |
| vLLM OpenAI-compatible server | Self-hostable, OAI-compatible |
| OpenAI Responses API | Newer unified response API |

### Model & tensor exchange formats
| Format | Owner | Notes |
|--------|-------|-------|
| Safetensors | HuggingFace | Safe (no pickle), mmap, fast |
| GGUF | llama.cpp | Quantized model bundle |
| ONNX | LFAI | Cross-framework graph IR |
| Core ML (.mlpackage) | Apple | iOS/macOS on-device |
| TFLite | Google | Mobile/edge |
| TensorRT engine | NVIDIA | Compiled for specific GPUs |
| OpenVINO IR | Intel | CPU/iGPU/NPU |
| MLX format | Apple | Apple Silicon native |

### Dataset / metadata
| Spec | Purpose |
|------|---------|
| HuggingFace `datasets` schema | Common dataset format |
| Croissant | W3C dataset metadata |
| TFRecord | TensorFlow record format |
| Parquet / Arrow | Columnar storage (cross-link [data](../12_Network_Transport/) and tooling) |

### Eval / harness specs
| Tool | Schema |
|------|--------|
| lm-evaluation-harness | YAML task definitions |
| HELM | Stanford eval framework |
| BIG-bench | Google benchmark format |
| Promptfoo / LangSmith | YAML/JSON test cases |

### Vector index APIs
- pgvector SQL extension
- Qdrant / Weaviate / Milvus / Pinecone REST + gRPC

### Cross-link
- LLMs served over HTTP/JSON → [13_Network_Application](../13_Network_Application/)
- Prompt injection treated as security topic → [Security › Topics](../14_Security/README.md#topics)
- Hardware accelerators feed the runtime → [02_CPU](../02_CPU/) + GPU/NPU notes
