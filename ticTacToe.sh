
#!/bin/bash -x

#->Author: Sagar Gupta 
#->Date: Mar 2020 

#Constant
X="X"
O="O"
IS_EMPTY=" "

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
				playerSign=$X
				computerLetter=$O ;;
			1)
				playerSign=$O 
				computerLetter=$X ;;
esac
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
echo " "
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

function computerTurn(){
computerLetter=$1
choose=$((RANDOM%9))
	if [[ "{board[$choose]}"!=X && "${board[$choose]}"!=O ]]
	then
			echo "Computer turn"
			board[$choose]="$computerLetter"
			echo " "
			displayBoard
	else
		computerTurn $computerLetter
	fi
}

function checkWinningMove(){
	local letter=$1
	index=0
while(($index<8))
do
	if [[ ${board[$index]} == $letter && ${board[$((index+1))]} == $letter && ${board[$((index+2))]} == $IS_EMPTY ]]
	then
			board[$((index+2))]=$letter
			compPlay=1
			return
		elif [[ ${board[$index]} == $letter && ${board[$((index+2))]} == $letter && ${board[$((index+1))]} == $IS_EMPTY ]]
      then
         board[$((index+1))]=$letter
         compPlay=1
         return
		elif [[ ${board[$((index+2))]} == $letter && ${board[$((index+1))]} == $letter && ${board[$index]} == $IS_EMPTY ]]
      then
         board[$index]=$letter
         compPlay=1
         return
		elif [[ ${board[$index]} == $letter && ${board[$((index+3))]} == $letter && ${board[$((index+6))]} == $IS_EMPTY ]]
      then
         board[$((index+6))]=$letter
         compPlay=1
         return
		elif [[ ${board[$index]} == $letter && ${board[$((index+6))]} == $letter && ${board[$((index+3))]} == $IS_EMPTY ]]
      then
         board[$((index+3))]=$letter
         compPlay=1
         return
		elif [[ ${board[$((index+3))]} == $letter && ${board[$((index+6))]} == $letter && ${board[$index]} == $IS_EMPTY ]]
      then
         board[$index]=$letter
         compPlay=1
         return
	fi
		index=$((index+3))
done
	if [[ ${board[0]} == $letter && ${board[8]} == $letter && ${board[4]} == $IS_EMPTY ]]
   then
			board[4]=$letter
			compPlay=1
   	   return
		elif [[ ${board[0]} == $letter && ${board[4]} == $letter && ${board[8]} == $IS_EMPTY ]]
      then
         board[8]=$letter
         compPlay=1
         return
		elif [[ ${board[8]} == $letter && ${board[4]} == $letter && ${board[0]} == $IS_EMPTY ]]
      then
         board[0]=$letter
         compPlay=1
         return
		elif [[ ${board[2]} == $letter && ${board[4]} == $letter && ${board[6]} == $IS_EMPTY ]]
      then
         board[6]=$letter
         compPlay=1
         return
		elif [[ ${board[2]} == $letter && ${board[6]} == $letter && ${board[4]} == $IS_EMPTY ]]
      then
         board[4]=$letter
         compPlay=1
         return
		elif [[ ${board[4]} == $letter && ${board[6]} == $letter && ${board[2]} == $IS_EMPTY ]]
      then
         board[2]=$letter
         compPlay=1
         return
	fi
}
displayBoard
getLetter
chance="$(player)"
flag=0
if [[ "$chance"=="Computer plays First" ]]
then
		falg=1
fi

while((0==0))
do
	if [[ $flag%2==0 ]]
	then
		computerTurn $computerLetter
		result="$(checkWin $computerLetter)"
		if [[ $result=="wins" || $result=="draw" ]]
		then
			echo "player " $result 
			echo " "
			break
		fi
	fi
	flag=$((flag+1))
done
