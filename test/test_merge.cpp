#include <cstdio>
#include <iostream>
#include <list>
#include <ostream>

int main(void){
  std::list<int> temp;
  const int count = 100;
  const int min = 0;
  const int max = 10;              // 원하는 범위
  srand((unsigned)time(NULL));      // 시드 1회 설정

  for (int i = 0; i < count; ++i) {
      temp.push_back((rand() % (max - min + 1)) + min);
  }
  for (auto it = temp.begin(); it != temp.end(); it++) {
    std::cout << *it <<" " << std::flush;
  }
}
//merge sort is simple divide and merge
std::list<int> merge_sort(std::list<int> &temp){
  if (temp.size() <= 1)
    return temp;
  auto mid = temp.begin();
    std::advance(mid, temp.size() / 2);
    std::list<int> left, right;
    left.splice(left.begin(), temp, temp.begin(), mid);
    right.splice(right.begin(), temp, mid, temp.end());
    left = merge_sort(left);
    right = merge_sort(right);
}