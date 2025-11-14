#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main(void){
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

}
