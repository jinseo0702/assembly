NASM = nasm
NASMFALGS = -f elf64
CC = gcc
CFLAG = -g -Wall -Wextra -Werror
AR = ar rcs
RM = rm -rf

NAME = libasm.a
TEST = libasmtest
HEADER = include/libasm.h
ASM_SRC = src/ft_strlen.s
ASM_OBJS = $(ASM_SRC:.s=.o)
C_SRC = test/test.c
C_OBJ = $(C_SRC:.c=.o)

all : $(NAME)

test : $(TEST)

$(TEST) : $(C_OBJ) $(NAME) $(HEADER)
	$(CC) $(CFLAG) $^ -o $(TEST)

$(NAME) : $(ASM_OBJS)
	$(AR) $@ $^

%.o : %.s
	$(NASM) $(NASMFALGS) $< -o $@

%.o : %.c $(HEADER)
	$(CC) $(CFLAG) -c $< -o $@

clean :
	$(RM) $(ASM_OBJS) $(C_OBJ)

fclean :
	$(RM) $(ASM_OBJS) $(C_OBJ) $(NAME) $(TEST)

re : 
	@make fclean
	@make all

.PHONY: all test clean fclean re