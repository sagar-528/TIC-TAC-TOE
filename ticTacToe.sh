
#!/bin/bash -x

#->Author: Sagar Gupta 
#->Date: Mar 2020 

#Constant
X="X"
O="O"

declare -a board
board=("0" "1" "2" "3" "4" "5" "6" "7" "8")
echo "Welcome to Tic Tac Toe"
echo " "
#Setting Board
function displayBoard(){
echo "${board[0]} | ${board[1]} | ${board[2]}"
echo "----------"
echo "${board[3]} | ${board[4]} | ${board[5]}"
echo "----------"
echo "${board[6]} | ${board[7]} | ${board[8]}"
}

#Assigning the letter in the game.
function getLetter(){
case $((RANDOM%2)) in
			0)
				playerSign=$X ;;
			1)
				playerSign=$O ;;
esac
echo $playerSign
}

#Who plays first in game
function player(){
case $((RANDOM%2)) in
			0)
			echo "You play first" ;;
			1)
			echo "Computer play first" ;;
esac
}

#Choose the valid cells
function playerTurn(){
playerSign=$1
read -p "Enter the cells between 0 to 8: " choose
if [[ $choose>=0 && $choose<=8 ]]
then
	if [[ "${board[$choose]}"!=X || "${board[$choose]}"!=O ]]
	then
			board[$choose]="$playerSign"
	else
			playerTurn $playerSign
	fi
else
	printf "Invalid input"
fi
displayBoard
}
letter="$(getLetter)"
player
playerTurn $letter
