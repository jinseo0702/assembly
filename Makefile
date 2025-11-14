NASM = nasm
NASMFLAGS = -f elf64
NASMFLAGS_DEBUG = -f elf64 -g -F dwarf
CC = gcc
CFLAG = -g -Wall -Wextra -Werror
CFLAG_DEBUG = -no-pie
AR = ar rcs
RM = rm -rf

NAME = libasm.a
TEST = libasmtest
DEBUG = libasm_debug.a
DEBUG_TEST = libasm_debug_test
HEADER = include/libasm.h
ASM_SRC = src/ft_strlen.s \
src/ft_strcpy.s
ASM_OBJS = $(ASM_SRC:.s=.o)
ASM_OBJS_DEBUG = $(ASM_SRC:.s=.debug.o)
C_SRC = test/test.c
C_OBJ = $(C_SRC:.c=.o)

all : $(NAME)

test : $(TEST)

debug : $(DEBUG)

debug_test : $(DEBUG_TEST)

$(NAME) : $(ASM_OBJS)
	$(AR) $@ $^

$(TEST) : $(C_OBJ) $(NAME) $(HEADER)
	$(CC) $(CFLAG) $^ -o $(TEST)

$(DEBUG) : $(ASM_OBJS_DEBUG)
	$(AR) $@ $(ASM_OBJS_DEBUG)

$(DEBUG_TEST) : $(C_OBJ) $(DEBUG) $(HEADER)
	$(CC) $(CFLAG_DEBUG) $^ -o $(DEBUG_TEST)

%.debug.o : %.s
	$(NASM) $(NASMFLAGS_DEBUG) $< -o $@

%.o : %.s
	$(NASM) $(NASMFLAGS) $< -o $@

%.o : %.c $(HEADER)
	$(CC) $(CFLAG) -c $< -o $@

clean :
	$(RM) $(ASM_OBJS) $(C_OBJ) $(ASM_OBJS_DEBUG)

fclean :
	$(RM) $(ASM_OBJS) $(C_OBJ) $(NAME) $(TEST) $(ASM_OBJS_DEBUG) $(DEBUG) $(DEBUG_TEST)

re : 
	@make fclean
	@make all

.PHONY: all test debug debug_test clean fclean re