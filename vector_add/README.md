# CUDA hello world : vector add
## Compile and run CPU program
Complie 
```shell
   gcc cpu.c -o vector_add_cpu
```
Run
```Shell
   ./vector_add_cpu
```
## Compile and run GPU program
```shell
   nvcc gpu.c -o vector_add_gpu
```
Run
```Shell
   ./vector_add_gpu
```
## Basic steps of a CUDA application

 - Allocate device memory
   ```c
      cudaMalloc((void**)&a_gpu, sizeof(float) * N);
   ```
 - Copy data from host to device memory
   ```c
      cudaMemcpy(a_gpu, a, sizeof(float) * N, cudaMemcpyHostToDevice);
   ```
 - Launch kernel
   ```c
      cuda_vector_add<<<20480, 20480>>>(res_gpu, a_gpu, b_gpu, N);
   ```
 - Wait for kernel to complete
   ```c
      cudaDeviceSynchronize();
   ```
 - Copy data from memory to host
   ```c
      cudaMemcpy(res, res_gpu, sizeof(float) * N, cudaMemcpyDeviceToHost);
   ```
 - Free memory
   ```c
      cudaFree(a_gpu);
   ```
