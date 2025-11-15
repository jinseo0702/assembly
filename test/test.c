#include "../include/libasm.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main(void){

  {
    printf("origin strlen test\n");
    char *ptr = "Hello Wrold!";
    int len = strlen(ptr);
    printf("string is %s and strlen is %d\n", ptr, len);
  }

  {
    printf("ft_strlen test\n");
    char *ptr = "Hello Wrold!";
    int len = ft_strlen(ptr);
    printf("string is %s and strlen is %d\n", ptr, len);
  }

  {
    printf("origin strcpy test\n");
    char *dest = calloc(sizeof(char), 100);
    char *src = calloc(sizeof(char), 100);
    strcpy(src, "test strcpy!");
    printf("is origin %s\n", src);
    strcpy(dest, src);
    printf("is dest %s\n", dest);
    free(dest);
    free(src);
  }

  {
    printf("mine ft_strcpy test\n");
    char *dest = calloc(sizeof(char), 100);
    char *src = calloc(sizeof(char), 100);
    ft_strcpy(src, "test strcpy!");
    printf("is origin %s\n", src);
    ft_strcpy(dest, src);
    printf("is dest %s\n", dest);
    free(dest);
    free(src);
  }

  {
    char *arr[10] = {"ABC", "ABC", "AB", "ABC", "ABC", "AB"}; 
    printf("strcmp test\n");
    for (int i = 0; i < 5; i++) {
      int i2 = i + 1;
      printf("CASE %d %s %s diff result is %d\n", (i + 1), arr[i], arr[i2], strcmp(arr[i], arr[i2]));
    }
    printf("ft_strcmp test\n");
    for (int i = 0; i < 5; i++) {
      int i2 = i + 1;
      printf("CASE %d %s %s diff result is %d\n", (i + 1), arr[i], arr[i2], ft_strcmp(arr[i], arr[i2]));
    }
  }
  
  return (0);
}