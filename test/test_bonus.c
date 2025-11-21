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

void free_fct(void *ptr){
  free(ptr);
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
  free(temp);
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
  for (int i  = 0; ptr[i] != NULL; i++) {
    free(ptr[i]);
  }
  free(ptr);
}
printf("\n------------------------------------------------------------------------\n");
{
  char *arr[] = {"apple", "kiwi", "grape", "mango", "lemon", "peach", "berry", "melon", "plum", "pear", NULL};
  char **ptr = copy_arr(arr);
  t_list *head = NULL;
  int cnt = 0;
  for (int i = 0; ptr[i]; i++){
    ft_list_push_front(&head, ptr[i]);
    printf("cnt is %d %s\n", cnt, (char *)head->data);
    cnt++;
  }
  char *word = "apple"; 
  printf("remove id word is %s \n", word);
  ft_list_remove_if(&head, word, ft_strcmp, free_fct);
  for (t_list *node = head; node; node = node->next){
    printf("cnt is %d %s\n", cnt,(char *)node->data);
    cnt++;
  }
  while (head) {
    t_list *next = head->next;
    free(head);
    head = next;
  }
  for (int i  = 0; ptr[i] != NULL; i++) {
    free(ptr[i]);
  }
  free(ptr);
}
printf("\n------------------------------------------------------------------------\n");

{
  char *base[] = {
      "",                   // Invalid: 빈 문자열
      "0",                  // Invalid: 길이 1
      "01",                 // Binary (2진수)
      "012",                // Ternary (3진수)
      "0123",               // Quaternary (4진수)
      "01234",              // Quinary (5진수)
      "012345",             // Senary (6진수)
      "0123456",            // Septenary (7진수)
      "01234567",           // Octal (8진수)
      "012345678",          // Nonary (9진수)
      "0123456789",         // Decimal (10진수)
      "0123456789A",        // Undecimal (11진수)
      "0123456789AB",       // Duodecimal (12진수)
      "0123456789ABC",      // Tridecimal (13진수)
      "0123456789ABCD",     // Tetradecimal (14진수)
      "0123456789ABCDE",    // Pentadecimal (15진수)
      "0123456789ABCDEF",   // Hexadecimal (16진수)
      "0123456789abcdef",   // Lowercase Hex (16진수)
      "poneyvif",           // Custom Base (8진수 변형)
      "0123455",            // Invalid: 중복 문자
      "01+-",               // Invalid: 부호 포함
      NULL
  };
  
  char *num[] = {
      "0",
      "1",
      "10",
      "42",
      "-42",
      "   +42",
      "   -42",
      "101010",
      "FF",
      "ff",
      "7f",
      "2147483647",
      "-2147483648",
      "vn",                 // poneyvif 테스트용
      "invalid",
      NULL
  };

  int i = 0;
  while (base[i])
  {
      printf("\n=== Testing Base: \"%s\" ===\n", base[i]);
      int j = 0;
      while (num[j])
      {
          int res = ft_atoi_base(num[j], base[i]);
          printf("Base: \"%s\", Num: \"%s\" => Result: %d\n", base[i], num[j], res);
          j++;
      }
      i++;
  }
}
return (0);
}