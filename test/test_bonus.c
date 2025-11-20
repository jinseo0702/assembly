#include "../include/libasm_bonus.h"
#include <string.h>
#include <time.h>
#include <stdio.h>
#include <stdlib.h>

char **copy_arr(char *arr[]){
  int idx = 0;
  char **ptr = NULL;
  while (arr[idx] != NULL) idx++;
  if (idx <= 0) return (NULL);
  ptr = (char **)calloc(idx + 1, sizeof(char *));
  if (ptr == NULL) return (NULL);
  for (int i = 0; i < idx; i++) {
    ptr[i] = strdup(arr[i]);
    if (ptr[i] == NULL) return (NULL);
  }
  return (ptr);
}

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
  char *words[] = {"a", "a", "a", "a","e","f",NULL};
  char **ptr = copy_arr(words);
  t_list *head = NULL;
  int cnt = 0;

  for (int i = 0; ptr[i]; i++){
    printf("cnt is %d\n", cnt);
    ft_list_push_front(&head, ptr[i]);
    cnt++;
  }

  printf("origine is\n");
  cnt = 0;
  for (t_list *node = head; node; node = node->next){
    printf("cnt is %d %s\n", cnt,(char *)node->data);
    cnt++;
  }

  ft_list_sort(&head, ft_strcmp);

  printf("sort is\n");
  cnt = 0;
  for (t_list *node = head; node; node = node->next){
    printf("cnt is %d %s\n", cnt,(char *)node->data);
    cnt++;
  }

  while (head) {
      t_list *next = head->next;
      free(head);
      head = next;
  }
}
return (0);
}