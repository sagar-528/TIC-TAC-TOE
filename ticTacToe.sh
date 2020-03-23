
#!/bin/bash -x

#->Author: Sagar Gupta 
#->Date: Mar 2020 

declare -a board
board=("1" "2" "3" "4" "5" "6" "7" "8" "9")
echo "Welcome to Tic Tac Toe"

#Setting Board
echo "${board[0]} | ${board[1]} | ${board[2]}"
echo "----------"
echo "${board[3]} | ${board[4]} | ${board[5]}"
echo "----------"
echo "${board[6]} | ${board[7]} | ${board[8]}"
