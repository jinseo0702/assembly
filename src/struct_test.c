#include <stdlib.h>
#include <stdio.h>
#include <time.h>
void quick_sort(int arr[], int left, int right);
void bubble_sort(int arr[], int size);
typedef struct s_list
{
void *data;
struct s_list *next;
} t_list;

int main(void){
  int arr[100];
  const int count = 100;
  const int min = 0;
  const int max = 10;              // 원하는 범위
  srand((unsigned)time(NULL));      // 시드 1회 설정

  for (int i = 0; i < count; ++i) {
      arr[i] = (rand() % (max - min + 1)) + min;
      printf("%d ", arr[i]);
  }
  printf("\n-------------------------\n");
  // quick_sort(arr, 0, 99);
  bubble_sort(arr, 100);
  for (int i = 0; i < count; ++i) {
    printf("%d ", arr[i]);
  }
  printf("\n");
  return 0;
}

void quick_sort(int arr[], int left, int right){
  int i = left;
  int j = right;
  int pivot = (arr[(left + right) / 2]);
  int temp;
  while (i <= j) {
    while (arr[i] < pivot) i++;
    while (arr[j] > pivot) j--;
    if(i <= j){
      temp = arr[i];
      arr[i] = arr[j];
      arr[j] = temp;
      i++;
      j--;
    }
  }
  //left
  if(left < j)quick_sort(arr, left, j);
  //right
  if(i < right)quick_sort(arr, i, right);
}

void bubble_sort(int arr[], int size){
  int temp = 0;
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      if (arr[j] >= arr[j+1]){
        temp = arr[j];
        arr[j] = arr[j + 1];
        arr[j + 1] = temp;
      }
    }
  }
}
/*
do {
    swapped = 0;
    prev = NULL;
    cur = head;

    while (cur && cur->next) {
        next = cur->next;
        if (cmp(cur->data, next->data) > 0) {
            // swap(cur, next)
            swapped = 1;
        } else {
            prev = cur;
            cur = cur->next;
        }
    }
} while (swapped);
*/
// void bubble_do_while(int arr[], int size){
//   do {

//   }while ()
// }

void swap(t_list **begin_list, t_list *prev, t_list *cur, t_list *next){
  //ptr 이 null 이라면
  if (!prev){
    *begin_list = next;
    cur->next = next->next;
    next->next = cur;
  }
}