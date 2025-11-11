#include "../include/libasm.h"
#include <stdio.h>
#include <string.h>

int main(void){

  {
    printf("origin strlen test relinked\n");
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
  
  return (0);
}