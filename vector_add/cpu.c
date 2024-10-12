#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

#define N 20480 * 20480

void vector_add(float *res, float *a, float *b, int len) {
  for (int i = 0; i < len; i++) {
   res[i] = a[i] + b[i];
  }
}

int main() {
  float *res, *a, *b;
  res = (float *)malloc(sizeof(float) * N);
  a = (float *)malloc(sizeof(float) * N);
  b = (float *)malloc(sizeof(float) * N);
  for (int i = 0; i < N; i++) {
    a[i] = i;
    b[i] = i + 1;
  }
  struct timeval start, end;
  gettimeofday(&start, NULL);
  vector_add(res, a, b, N);
  gettimeofday(&end, NULL);
  long elapsed_ms = (end.tv_sec - start.tv_sec) * 1000L; // Convert seconds to milliseconds
  elapsed_ms += (end.tv_usec - start.tv_usec) / 1000L;  
  printf("execution time : %ld ms \n", elapsed_ms);
  return 0;
}
