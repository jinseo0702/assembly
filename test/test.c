#include "../include/libasm.h"
#include <errno.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

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

  
  /*{
    char *arr = "HelloWrold\n";
    long wr = 0;
    long fwr = 0;
    wr = write(1, arr, strlen(arr));
    fwr = ft_write(1, arr, strlen(arr));
    fprintf(stderr, "write return value is %ld\n", wr);
    fprintf(stderr, "ft_write return value is %ld\n", fwr);
    wr = write(1, arr, strlen(arr));
    fprintf(stderr, "write return value is %ld %s\n", wr, strerror(errno));
    close(1);
    fwr = ft_write(1, arr, strlen(arr));
    fprintf(stderr, "ft_write return value is %ld %s\n", fwr, strerror(errno));
  }*/

  /*{
    char arr[100];
    memset(arr, 0, sizeof(arr));
    long re = 0;
    long fre = 0;
    re = read(0, arr, sizeof(arr) - 1);
    fprintf(stderr, "read %sreturn value is %ld %s\n", arr, re, strerror(errno));
    fre = ft_read(0, arr, sizeof(arr) - 1);
    fprintf(stderr, "ft_read %sreturn value is %ld %s\n", arr , fre, strerror(errno));
    close(0);
    re = read(0, arr, sizeof(arr) - 1);
    fprintf(stderr, "read return value is %ld %s\n", re, strerror(errno));
    fre = ft_read(0, arr, sizeof(arr) - 1);
    fprintf(stderr, "ft_read return value is %ld %s\n", fre, strerror(errno));
    re = read(-1, arr, sizeof(arr) - 1);
    fprintf(stderr, "read return value is %ld %s\n", re, strerror(errno));
    fre = ft_read(-1, arr, sizeof(arr) - 1);
    fprintf(stderr, "ft_read return value is %ld %s\n", fre, strerror(errno));
  }*/

  {
    char buf[10000];
    memset(buf, 0, sizeof(buf));
    memset(buf, 'A', sizeof(buf) - 1);
    char *one[5] = {"test my func", "", "a", buf, NULL};
    char *two[5] = {NULL,};
    for (int i = 0; i < 4; i++) {
      two[i] = strdup(one[i]);
      if (two[i] == NULL){
        fprintf(stderr, "one is %s two is %s\n", one[i], two[i]);
        continue;
      }
      if (strlen(one[i]) < 500){
        fprintf(stderr, "one is %s len is %ld err is %s\n", one[i], strlen(one[i]), strerror(errno));
        fprintf(stderr, "two is %s len is %ld err is %s\n", two[i], strlen(two[i]), strerror(errno));
      }
      else{
        fprintf(stderr, "one len is %ld err is %s\n", strlen(one[i]), strerror(errno));
        fprintf(stderr, "two len is %ld err is %s\n", strlen(two[i]), strerror(errno));
      }
      if (two[i] != NULL)
        free(two[i]);
    }
  }

  {
    fprintf(stderr, "-----------------------------------strdup test-----------------------------------\n");
    char buf[10000];
    memset(buf, 0, sizeof(buf));
    memset(buf, 'A', sizeof(buf) - 1);
    char *one[5] = {"test my func", "", "a", buf, NULL};
    char *two[5] = {NULL,};
    for (int i = 0; i < 4; i++) {
      two[i] = ft_strdup(one[i]);
      if (two[i] == NULL){
        fprintf(stderr, "one is %s two is %s\n", one[i], two[i]);
        continue;
      }
      if (strlen(one[i]) < 500){
        fprintf(stderr, "one is %s len is %ld err is %s\n", one[i], strlen(one[i]), strerror(errno));
        fprintf(stderr, "two is %s len is %ld err is %s\n", two[i], strlen(two[i]), strerror(errno));
      }
      else{
        fprintf(stderr, "one len is %ld err is %s\n", strlen(one[i]), strerror(errno));
        fprintf(stderr, "two len is %ld err is %s\n", strlen(two[i]), strerror(errno));
      }
      if (two[i] != NULL)
        free(two[i]);
    }
  }
  
  return (0);
}