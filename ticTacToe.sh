
#!/bin/bash -x

#->Author: Sagar Gupta 
#->Date: Mar 2020 

#Constant
X="X"
O="O"
IS_EMPTY=" "

declare -a gameBoard
gameBoard=("0" "1" "2" "3" "4" "5" "6" "7" "8")
printf "Welcome to Tic Tac Toe\n"

#Setting Board
function displayBoard(){
echo "${gameBoard[0]} | ${gameBoard[1]} | ${gameBoard[2]}"
echo "----------"
echo "${gameBoard[3]} | ${gameBoard[4]} | ${gameBoard[5]}"
echo "----------"
echo "${gameBoard[6]} | ${gameBoard[7]} | ${gameBoard[8]}"
}

#Assigning the letter in the game.
function assignLetter(){
case $((RANDOM%2)) in
			0)
				playerLetter=$X
				computerLetter=$O ;;
			1)
				playerLetter=$O 
				computerLetter=$X ;;
esac
}

#Who plays first in game
function firstChance(){
case $((RANDOM%2)) in
			0)
				echo "playerChance" ;;
			1)
				echo "computerChance" ;;
esac
}

#Choose the valid cells
function playerTurn(){
playerLetter=$1
echo "Enter the cells between 0 to 8: " 
read response
if [[ $response>=0 && $response<=8 ]]
then
	if [[ "${gameBoard[$response]}"!=X || "${gameBoard[$response]}"!=O ]]
	then
			gameBoard[$response]="$playerLetter"
			displayBoard
	else
			playerTurn $playerLetter
	fi
else
	printf "Invalid input\n"
fi
}

#Determining condition for winning or tie or change the turn
function checkWin(){
letter=$1

if [[ "${gameBoard[0]}"==$letter && "${gameBoard[1]}"==$letter && "${gameBoard[2]}"==$letter ]]
then
		result="Wins"
elif [[ "${gameBoard[3]}"==$letter && "${gameBoard[4]}"==$letter && "${gameBoard[5]}"==$letter ]]
then
      result="Wins"
elif [[ "${gameBoard[6]}"==$letter && "${gameBoard[7]}"==$letter && "${gameBoard[8]}"==$letter ]]
then
      result="Wins"
elif [[ "${gameBoard[0]}"==$letter && "${gameBoard[3]}"==$letter && "${gameBoard[6]}"==$letter ]]
then
      result="Wins"
elif [[ "${gameBoard[1]}"==$letter && "${gameBoard[4]}"==$letter && "${gameBoard[7]}"==$letter ]]
then
      result="Wins"
elif [[ "${gameBoard[2]}"==$letter && "${gameBoard[5]}"==$letter && "${gameBoard[8]}"==$letter ]]
then
      result="Wins"
elif [[ "${gameBoard[0]}"==$letter && "${gameBoard[4]}"==$letter && "${gameBoard[8]}"==$letter ]]
then
      result="Wins"
elif [[ "${gameBoard[2]}"==$letter && "${gameBoard[4]}"==$letter && "${gameBoard[6]}"==$letter ]]
then
      result="Wins"
else
		flag=0
		for((index=0; index<${#gameBoard[@]}; index++))
		do
			if [[ "${gameBoard[letter]}"!=X  || "${gameBoard[letter]}"!=O ]]
			then
					flag=1
			fi
		done

	if [ $flag==0 ]
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
playerLetter=$2
compPlay=0
checkWinningMove $computerLetter
if(($compPlay==0))
then
	blockPlayerWin $playerLetter $computerLetter
fi

if(($compPlay==0))
then
	read response
#response=$((RANDOM%9))
#IF NO VALUE IS ASSIGN TO THE INDEX GO AHEAD ELSE RETURN FUNCTION
	if [[ "{gameBoard[$response]}"!=X && "${gameBoard[$response]}"!=O ]]
	then
			echo "Computer turn: "
			gameBoard[$response]="$computerLetter"
	else
		computerTurn $computerLetter
	fi
fi
displayBoard
}


function checkWinningMove(){
	local letter=$1
	index=0
while(($index<8))
do
	if [[ ${gameBoard[$index]} == $letter && ${gameBoard[$((index+1))]} == $letter && ${gameBoard[$((index+2))]} == $IS_EMPTY ]]
	then
			gameBoard[$((index+2))]=$letter
			compPlay=1
			return
		elif [[ ${gameBoard[$index]} == $letter && ${gameBoard[$((index+2))]} == $letter && ${gameBoard[$((index+1))]} == $IS_EMPTY ]]
      then
         gameBoard[$((index+1))]=$letter
         compPlay=1
         return
		elif [[ ${gameBoard[$((index+2))]} == $letter && ${gameBoard[$((index+1))]} == $letter && ${gameBoard[$index]} == $IS_EMPTY ]]
      then
         gameBoard[$index]=$letter
         compPlay=1
         return
		elif [[ ${gameBoard[$index]} == $letter && ${gameBoard[$((index+3))]} == $letter && ${gameBoard[$((index+6))]} == $IS_EMPTY ]]
      then
         gameBoard[$((index+6))]=$letter
         compPlay=1
         return
		elif [[ ${gameBoard[$index]} == $letter && ${gameBoard[$((index+6))]} == $letter && ${gameBoard[$((index+3))]} == $IS_EMPTY ]]
      then
         gameBoard[$((index+3))]=$letter
         compPlay=1
         return
		elif [[ ${gameBoard[$((index+3))]} == $letter && ${gameBoard[$((index+6))]} == $letter && ${gameBoard[$index]} == $IS_EMPTY ]]
      then
         gameBoard[$index]=$letter
         compPlay=1
         return
	fi
		index=$((index+3))
done
	if [[ ${gameBoard[0]} == $letter && ${gameBoard[8]} == $letter && ${gameBoard[4]} == $IS_EMPTY ]]
   then
			gameBoard[4]=$letter
			compPlay=1
   	   return
		elif [[ ${gameBoard[0]} == $letter && ${gameBoard[4]} == $letter && ${gameBoard[8]} == $IS_EMPTY ]]
      then
         gameBoard[8]=$letter
         compPlay=1
         return
		elif [[ ${GameBoard[8]} == $letter && ${gameBoard[4]} == $letter && ${gameBoard[0]} == $IS_EMPTY ]]
      then
         gameBoard[0]=$letter
         compPlay=1
         return
		elif [[ ${gameBoard[2]} == $letter && ${gameBoard[4]} == $letter && ${gameBoard[6]} == $IS_EMPTY ]]
      then
         gameBoard[6]=$letter
         compPlay=1
         return
		elif [[ ${gameBoard[2]} == $letter && ${gameBoard[6]} == $letter && ${gameBoard[4]} == $IS_EMPTY ]]
      then
         gameBoard[4]=$letter
         compPlay=1
         return
		elif [[ ${gameBoard[4]} == $letter && ${gameBoard[6]} == $letter && ${gameBoard[2]} == $IS_EMPTY ]]
      then
         gameBoard[2]=$letter
         compPlay=1
         return
	fi
}

function blockPlayerWin(){
	compPlay=0
   letter=$1
	computerLetter=$2
   index=0
while(($index<8))
do
   if [[ ${gameBoard[$index]} == $letter && ${gameBoard[$((index+1))]} == $letter && ${gameBoard[$((index+2))]} == $IS_EMPTY ]]
   then
         gameBoard[$((index+2))]=$letter
         compPlay=1
         return
      elif [[ ${gameBoard[$index]} == $letter && ${gameBoard[$((index+2))]} == $letter && ${gameBoard[$((index+1))]} == $IS_EMPTY ]]
      then
         gameBoard[$((index+1))]=$letter
         compPlay=1
         return
      elif [[ ${gameBoard[$((index+2))]} == $letter && ${gameBoard[$((index+1))]} == $letter && ${gameBoard[$index]} == $IS_EMPTY ]]
      then
         gameBoard[$index]=$letter
         compPlay=1
         return
      elif [[ ${gameBoard[$index]} == $letter && ${gameBoard[$((index+3))]} == $letter && ${gameBoard[$((index+6))]} == $IS_EMPTY ]]
      then
         gameBoard[$((index+6))]=$letter
         compPlay=1
         return
		 elif [[ ${gameBoard[$index]} == $letter && ${gameBoard[$((index+6))]} == $letter && ${gameBoard[$((index+3))]} == $IS_EMPTY ]]
      then
         gameBoard[$((index+3))]=$letter
         compPlay=1
         return
		  elif [[ ${gameBoard[$((index+3))]} == $letter && ${gameBoard[$((index+6))]} == $letter && ${gameBoard[$index]} == $IS_EMPTY ]]
      then
         gameBoard[$index]=$letter
         compPlay=1
         return
   fi
      index=$((index+3))
done
   if [[ ${gameBoard[0]} == $letter && ${gameBoard[8]} == $letter && ${gameBoard[4]} == $IS_EMPTY ]]
   then
         gameBoard[4]=$letter
         compPlay=1
         return
		  elif [[ ${gameBoard[0]} == $letter && ${gameBoard[4]} == $letter && ${gameBoard[8]} == $IS_EMPTY ]]
      then
         gameBoard[8]=$letter
         compPlay=1
         return
      elif [[ ${gameBoard[8]} == $letter && ${gameBoard[4]} == $letter && ${gameBoard[0]} == $IS_EMPTY ]]
      then
         gameBoard[0]=$letter
         compPlay=1
         return
      elif [[ ${gameBoard[2]} == $letter && ${gameBoard[4]} == $letter && ${gameBoard[6]} == $IS_EMPTY ]]
      then
         gameBoard[6]=$letter
         compPlay=1
         return
      elif [[ ${gameBoard[2]} == $letter && ${gameBoard[6]} == $letter && ${gameBoard[4]} == $IS_EMPTY ]]
      then
         gameBoard[4]=$letter
         compPlay=1
         return
		     elif [[ ${gameBoard[4]} == $letter && ${gameBoard[6]} == $letter && ${gameBoard[2]} == $IS_EMPTY ]]
      then
         gameBoard[2]=$letter
         compPlay=1
         return
   fi
}

function alternatePlay(){
chance="$(firstChance)"
flag=0
if [[ "$chance" == "computerChance" ]]
then
		flag=1
fi
while((0==0))
do
	if [[ $flag%2==0 ]]
	then
		computerTurn $computerLetter
		result="$(checkWin $computerLetter)"
		if [[ $result=="wins" || $result=="draw" ]]
		then
			printf "computer $result\n"
			break
		fi
	else
	playerTurn $playerLetter
	result="$(checkWin $playerLetter)"
	if [[$result=="wins" || $result=="draw" ]]
	then
			printf "player $result\n"
			break
	fi
	fi
		flag=$((flag+1))
done
}
displayBoard
assignLetter
alternatePlay
