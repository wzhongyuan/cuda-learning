# GPU 架构
## CPU 架构和 GPU 架构
![GPU & GPU Arch](https://github.com/wzhongyuan/cuda-learning/blob/main/gpu-architecture/Cpu-gpu.svg.png)

主要区别
- CPU 有控制模块，GPU没有
- CPU 的计算单元(ALU, core) 大，但是数目少
- GPU 的计算单元小，但数目多
- CPU 计算单元更快更聪明，性能越来越好得益于更快的主频，更聪明体现在乱序执行能力上。
- GPU 的计算受功耗和算热的影响，因为计算单元太多，GPU的特色能力就是做乘加(MAD)操作，或者融合乘加(FMA)操作。现在的GPU也可以做张量计算(Tensor Core) 以及光线追踪(Ray tracing)等操作。

所以，GPU的能力不是强大的计算单元，而是大规模并行处理能力。
