性能测试
```CPP
#include <iostream>
#include <chrono>
#include <vector>
#include <algorithm>

void performTask() {
  std::vector<int> vec(1000000);
  std::iota(vec.begin(), vec.end(), 1);
  std::sort(vec.begin(), vec.end(), [](int a, int b) { return b < a; });
}

int main() {
  const int numRuns = 10;
  double totalDuration = 0;

  for(int i = 0; i < numRuns; ++i) {
    auto start = std::chrono::high_resolution_clock::now();
    performTask();
    auto end = std::chrono::high_resolution_clock::now();
    totalDuration += std::chrono::duration_cast<std::chrono::microseconds>(end - start).count();
  }

  double averageDuration = totalDuration / numRuns;
  std::cout << "Average execution time over " << numRuns << " runs: " << averageDuration << " microseconds" << std::endl;

  return 0;
}

```
