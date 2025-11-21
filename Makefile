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

BONUS = libasm_bonus.a
TEST_BONUS = libasm_bonustest
DEBUG_BONUS = libasm_debug_bonus.a
DEBUG_TEST_BONUS = libasm_debug_bonustest

HEADER = include/libasm.h
HEADER_BONUS = include/libasm_bonus.h

ASM_SRC = src/ft_strlen.s \
src/ft_strcpy.s \
src/ft_strcmp.s \
src/ft_write.s \
src/ft_read.s \
src/ft_strdup.s

ASM_BONUS_SRC = src/ft_list_push_front.s \
src/ft_atoi_base.s \
src/ft_list_size.s \
src/ft_list_sort.s \
src/ft_list_remove_if.s

C_SRC = test/test.c

C_BONUS_SRC = test/test_bonus.c

ASM_OBJS = $(ASM_SRC:.s=.o)
ASM_OBJS_DEBUG = $(ASM_SRC:.s=.debug.o)
C_OBJ = $(C_SRC:.c=.o)

ASM_BONUS_OBJS = $(ASM_BONUS_SRC:.s=.o)
ASM_BONUS_OBJS_DEBUG = $(ASM_BONUS_SRC:.s=.debug.o)
C_BONUS_OBJ = $(C_BONUS_SRC:.c=.o)

all : $(NAME)

test : $(TEST)

debug : $(DEBUG)

debug_test : $(DEBUG_TEST)

bonus : $(BONUS)

test_bonus : $(TEST_BONUS)

debug_bonus : $(DEBUG_BONUS)

debug_test_bonus : $(DEBUG_TEST_BONUS)

$(NAME) : $(ASM_OBJS)
	$(AR) $@ $^

$(TEST) : $(C_OBJ) $(NAME) $(HEADER)
	$(CC) $(CFLAG) $^ -o $(TEST)

$(DEBUG) : $(ASM_OBJS_DEBUG)
	$(AR) $@ $(ASM_OBJS_DEBUG)

$(DEBUG_TEST) : $(C_OBJ) $(DEBUG) $(HEADER)
	$(CC) $(CFLAG_DEBUG) $^ -o $(DEBUG_TEST)

$(BONUS) : $(ASM_BONUS_OBJS)
	$(AR) $@ $^

$(TEST_BONUS) : $(C_BONUS_OBJ) $(BONUS) $(NAME) $(HEADER_BONUS)
	$(CC) $(CFLAG) $^ -o $(TEST_BONUS)

$(DEBUG_BONUS) : $(ASM_BONUS_OBJS_DEBUG)
	$(AR) $@ $(ASM_BONUS_OBJS_DEBUG)

$(DEBUG_TEST_BONUS) : $(C_BONUS_OBJ) $(DEBUG_BONUS) $(DEBUG) $(HEADER_BONUS)
	$(CC) $(CFLAG_DEBUG) $^ -o $(DEBUG_TEST_BONUS)

%.debug.o : %.s
	$(NASM) $(NASMFLAGS_DEBUG) $< -o $@

%.o : %.s
	$(NASM) $(NASMFLAGS) $< -o $@

%.o : %.c $(HEADER)
	$(CC) $(CFLAG) -c $< -o $@

clean :
	$(RM) $(ASM_OBJS) $(C_OBJ) $(ASM_OBJS_DEBUG)

fclean :
	@make clean
	$(RM) $(NAME) $(TEST) $(DEBUG) $(DEBUG_TEST)

clean_bonus :
	@make clean
	$(RM) $(ASM_BONUS_OBJS) $(C_BONUS_OBJ) $(ASM_BONUS_OBJS_DEBUG)

fclean_bonus :
	@make fclean
	@make clean_bonus
	$(RM) $(BONUS) $(TEST_BONUS) $(DEBUG_BONUS) $(DEBUG_TEST_BONUS)

re : 
	@make fclean
	@make all

.PHONY: all test debug debug_test clean fclean re clean_bonus fclean_bonus