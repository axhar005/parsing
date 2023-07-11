# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: olivierboucher <olivierboucher@student.    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/01/06 12:34:33 by oboucher          #+#    #+#              #
#    Updated: 2023/07/11 10:41:24 by olivierbouc      ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# ➜  ~ git clone https://github.com/codam-coding-college/MLX42.git
# ➜  ~ cd MLX42
# ➜  ~ cmake -B build # build here refers to the outputfolder.
# ➜  ~ cmake --build build -j4 # or do make -C build -j4

#--- LIBRARY NAME ---#
NAME = so_long
LDIR = lib/libft/
LIBFT = libft.a

#--- COMMAND VARIABLES ---#
CC = gcc
CFLAGS = -Wall -Wextra -Werror -fsanitize=address -g
RM = rm -f
AR = ar rcs
MK = mkdir -p

#--- COLORS ---#
GREEN	=	\033[1;32m
RED		=	\033[1;31m
RESET 	= 	\033[0m

#--- INCLUDE ---#
INCDIR = inc

#--- SOURCE ---#
SRCDIR	=	src
SRC		= 	main.c 
VPATH	=	$(SRCDIR)

#--- OBJECT ---#
OBJDIR  =   obj
OBJ = $(addprefix $(OBJDIR)/, $(SRC:.c=.o))

#--- RULES ---#
$(OBJDIR)/%.o:	%.c
	@$(CC) $(CFLAGS) -I$(INCDIR) -I. -c $< -o $@
	
all:	update init libft $(NAME)
	
${NAME}:	$(OBJDIR) $(OBJ)
	@$(CC) $(CFLAGS) -I$(INCDIR) -o $(NAME) $(OBJ) $(LDIR)$(LIBFT)
	@echo "$(NAME)$(GREEN) sucessefully compiled 📁.$(RESET)"

$(OBJDIR):
	@$(MK) $(OBJDIR)
	
libft:
	@$(MAKE) -C $(LDIR)
	
update:
	@git submodule update --remote --recursive

init:
	@git submodule update --init --recursive

run:	all
	@./$(NAMES)
	
clean:
	@$(MAKE) -C $(LDIR) clean
	@$(RM) $(OBJ)
	@$(RM)r $(OBJDIR)
	
fclean:	clean	
	@$(MAKE) -C $(LDIR) fclean
	@$(RM) $(NAME)
	@echo "$(NAME)$(GREEN) object files and executable successfully removed 🗑.$(RESET)"

re:	fclean all

.PHONY:	all clean fclean re libft