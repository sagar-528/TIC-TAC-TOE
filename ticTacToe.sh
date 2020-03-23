
#!/bin/bash -x

#->Author: Sagar Gupta 
#->Date: Mar 2020 

#Constant
X="X"
O="O"

declare -a board
board=("1" "2" "3" "4" "5" "6" "7" "8" "9")
echo "Welcome to Tic Tac Toe"
echo " "
#Setting Board
echo "${board[0]} | ${board[1]} | ${board[2]}"
echo "----------"
echo "${board[3]} | ${board[4]} | ${board[5]}"
echo "----------"
echo "${board[6]} | ${board[7]} | ${board[8]}"

#Assigning the letter in the game.
echo " "
case $((RANDOM%2)) in
			0)
			echo "You have assigned : " $O ;;
			1)
			echo "You have assigned : " $X ;;
esac

#Who plays first in game
echo " "
case $((RANDOM%2)) in
			0)
			echo "You play first" ;;
			1)
			echo "Computer play first" ;;
esac
