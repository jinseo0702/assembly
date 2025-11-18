#include "../include/libasm_bonus.h"
#include <time.h>
#include <stdio.h>
#include <stdlib.h>

int main(void){
{
  char *arr[11] = {"one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", NULL};
  t_list *temp = calloc(sizeof(t_list), 1);
  if (!temp){
    return (1);
  }
  for(int i = 0; arr[i] != NULL; i++) {
    ft_list_push_front(&temp, arr[i]);  
  }
  int cnt = 0;
  t_list *temp2 = temp;
  while (temp->next) {
    printf("cnt is %d t_list data is %s\n", ++cnt, (char *)temp->data);
    temp = temp->next;
  }
  printf("list size is %d\n", ft_list_size(temp2));
  while (temp2->next) {
    t_list *tempf = temp2;
    temp2 = temp2->next;
    if (tempf != NULL)
      free(tempf);
  }
}
printf("\n------------------------------------------------------------------------\n");
{
  t_list *temp = calloc(sizeof(t_list), 1);
  int arr[100];
  const int count = 100;
  const int min = 0;
  const int max = 10;              // 원하는 범위
  srand((unsigned)time(NULL));      // 시드 1회 설정

  for (int i = 0; i < count; ++i) {
      arr[i] = (rand() % (max - min + 1)) + min;
      ft_list_push_front(&temp, &arr[i]);
      printf("%d ", arr[i]);
  }
  printf("\n------------------------------------------------------------------------\n");

  ft_list_sort(&temp, ft_strcmp);
  while (temp->next) {
    printf("%d ", *(int *)temp->data);
    temp = temp->next;
  }
  printf("\n");
}
return (0);
}