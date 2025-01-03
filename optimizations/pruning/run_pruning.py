import numpy as np
import torch
import torch.nn as nn
from torch.profiler import ProfilerActivity, profile


# Define a simple model
class SimpleModel(nn.Module):
    def __init__(self):
        super(SimpleModel, self).__init__()
        self.fc = nn.Linear(10, 1)

    def forward(self, x):
        return self.fc(x)


# Generate random input using NumPy
np.random.seed(42)
input_data = np.random.rand(100, 10).astype(np.float32)

# Convert NumPy array to PyTorch tensor
input_tensor = torch.tensor(input_data, dtype=torch.float32)

# Instantiate the model
model = SimpleModel()

# Run the model and profile its execution
with profile(
    activities=[ProfilerActivity.CPU],
    on_trace_ready=torch.profiler.tensorboard_trace_handler("./log"),
) as prof:
    output = model(input_tensor)

# Print output and profiler summary
print("Output:", output)
print(prof.key_averages().table(sort_by="cpu_time_total", row_limit=10))
