
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

#Determining condition for winning or tie or change the turn
function checkWin(){
letter=$1

if [ "${board[0]}${board[1]}${board[2]}" == "$letter$letter$letter" ]
then
		result="Win"
elif [ "${board[3]}${board[4]}${board[5]}" == "$letter$letter$letter" ]
then
		result="Win"
elif [ "${board[6]}${board[7]}${board[8]}" == "$letter$letter$letter" ]
then
		result="Win"
elif [ "${board[0]}${board[3]}${board[6]}" == "$letter$letter$letter" ]
then
		result="Win"
elif [ "${board[1]}${board[4]}${board[7]}" == "$letter$letter$letter" ]
then
		result="Win"
elif [ "${board[2]}${board[5]}${board[8]}" == "$letter$letter$letter" ]
then
		result="Win"
elif [ "${board[0]}${board[4]}${board[8]}" == "$letter$letter$letter" ]
then
		result="Win"
elif [ "${board[2]}${board[4]}${board[6]}" == "$letter$letter$letter" ]
then
		result="Win"
else
		flag=0
		for((counter=0; counter<${#board[@]}; counter++))
		do
			if [[ "${board[$choose]}"!=X  || "${board[$choose]}"!=O ]]
			then
					flag=1
			fi
		done

	if [ $flag == 0 ]
	then
			result="draw"
	else
			result="change"
	fi
fi

echo $result 
}
letter="$(getLetter)"
player
playerTurn $letter
checkWin $playerSign
