# Transformer Practice

## Goal

- Write a clean LLM code that has individual components and can scale to LLAMA level
- Set up docker / bazel for environment
- Setup AWS instance or cruise shells to run the code seamelessly (local vs remote)
- Setup benchmarking code (pytorch profiler, nsys, jupyter notebook)
- Benchmark variants of flash attention and other optimization techniques
- Optimize the code using
 - torch.compile
 - TensorRT-LLM
 - torch-trt
- Try various decoding strategies
 - Speculative decoding
 - Multi token decoding
- Apply Quantization
 - Apply SpinQuant
 - Apply GPTQ
 - Do int8 quantization
- Do parity analysis 