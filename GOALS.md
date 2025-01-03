# Transformer Practice

## Goal

- Write a clean LLM code that has individual components and can scale to LLAMA level.
- Set up Docker / Bazel for the environment.
- Set up AWS instances or Cruise shells to run the code seamlessly (local vs remote).
- Set up benchmarking code:
  - PyTorch Profiler
  - NSYS
  - Jupyter Notebook
- Benchmark variants of Flash Attention and other optimization techniques.
- Optimize the code using:
  - `torch.compile`
  - TensorRT-LLM
  - Torch-TensorRT
- Try various decoding strategies:
  - Speculative Decoding
  - Multi-Token Decoding
- Apply Quantization:
  - SpinQuant
  - GPTQ
  - INT8 Quantization
- Perform parity analysis.
