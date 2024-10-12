#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

#define N 2048 * 20480

__global__ void cuda_vector_add(float *res, float *a, float *b, int len) {
 for (int i =0 ; i < len; i++ ) {
   res[i] = a[i] + b[i];
 }
}

int main() {
  float *res, *res_gpu, *a, *a_gpu, *b, *b_gpu;
  res = (float *)malloc(sizeof(float) * N);
  a = (float *)malloc(sizeof(float) * N);
  b = (float *)malloc(sizeof(float) * N);
  cudaMalloc((void**)&res_gpu, sizeof(float) * N);
  cudaMalloc((void**)&a_gpu, sizeof(float) * N);
  cudaMalloc((void**)&b_gpu, sizeof(float) * N);
  for (int i = 0; i < N; i++) {
   a[i] = i;
   b[i] = i + 1;
  }
  struct timeval start, end;
  gettimeofday(&start, NULL);
  cudaMemcpy(a_gpu, a, sizeof(float) * N, cudaMemcpyHostToDevice);
  cudaMemcpy(b_gpu, b, sizeof(float) * N, cudaMemcpyHostToDevice);
  gettimeofday(&end, NULL);
  long elapsed_ms = (end.tv_sec - start.tv_sec) * 1000L; // Convert seconds to milliseconds
  elapsed_ms += (end.tv_usec - start.tv_usec) / 1000L;
  printf("execution time for data copy : %ld ms \n", elapsed_ms);
  cuda_vector_add<<<20480, 20480>>>(res_gpu, a_gpu, b_gpu, N);
  cudaDeviceSynchronize();
  gettimeofday(&end, NULL);
  elapsed_ms = (end.tv_sec - start.tv_sec) * 1000L; // Convert seconds to milliseconds
  elapsed_ms += (end.tv_usec - start.tv_usec) / 1000L;
  printf("execution time to kernel execution complete: %ld ms \n", elapsed_ms);
  cudaMemcpy(res, res_gpu, sizeof(float) * N, cudaMemcpyDeviceToHost);
  gettimeofday(&end, NULL);
  elapsed_ms = (end.tv_sec - start.tv_sec) * 1000L; // Convert seconds to milliseconds
  elapsed_ms += (end.tv_usec - start.tv_usec) / 1000L;
  printf("execution time : %ld ms \n", elapsed_ms);
  return 0;
}
