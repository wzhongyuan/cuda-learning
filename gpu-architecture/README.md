# GPU 架构
## CPU 架构和 GPU 架构
![GPU & GPU Arch](https://github.com/wzhongyuan/cuda-learning/blob/main/gpu-architecture/Cpu-gpu.svg.png)

主要区别
- CPU 有复杂控制模块，GPU比较简单
- CPU 的计算单元(ALU, core) 大，但是数目少
- GPU 的计算单元小，但数目多
- CPU 计算单元更快更聪明，性能越来越好得益于更快的主频，更聪明体现在乱序执行能力上。
- GPU 的计算受功耗和算热的影响，因为计算单元太多，GPU的特色能力就是做乘加(MAD)操作，或者融合乘加(FMA)操作。现在的GPU也可以做张量计算(Tensor Core) 以及光线追踪(Ray tracing)等操作。

所以，GPU的能力不是强大的计算单元，而是大规模并行处理能力。故SIMD(Single instruction multiple data) 型应用适合GPU。

## GPU的SM(Streaming multi processor)架构
### 从一个具体应用开始
对一个包含8个元素的数组进行求和，在单核CPU的CPU模型里，就是一个顺序执行的过程，如下图。

![Sequential Sum](https://github.com/wzhongyuan/cuda-learning/blob/main/gpu-architecture/Screenshot%202024-10-15%20at%2019.28.29.png)

但是实际上可以通过并行的方式来求和（reduce）

![Parallel Sum](https://github.com/wzhongyuan/cuda-learning/blob/main/gpu-architecture/parallel%20sum.png)

从GPU core 的执行上来说，如下图所示

![Core Sum](https://github.com/wzhongyuan/cuda-learning/blob/main/gpu-architecture/core%20parallelism.png)

这种并行方式带来的诉求：需要一个**共享内存(Shared memory) 来存储和访问中间变量和中间结果**。而对于一个GPU来说，可能有几千个核心来，这就使得**core之间协调变得很难，代价也很高**。这是因为通常GPU里，都需要通过一些技术手段来解决core之间协调共享数据的。比如**缓存一致性协议**、**硬件同步原语**、**内存屏障**等等。
GPU的解决办法就是 SM 架构。
### SM 架构和多线程模型
