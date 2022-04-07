#!/bin/bash

random(){
	num=`expr $(date +%s%N) % $1`;  #
	echo $num;
}

buQi(){
	if [ $1 -lt 10 ];then
		echo "$1$KongGe4";
	elif [ $1 -gt 9 ] && [ $1 -lt 100 ];then
		echo "$1$KongGe3";
	elif [ $1 -gt 99 ] && [ $1 -lt 1000 ];then
		echo "$1$KongGe2";
	else
		echo "$1$KongGe1";
	fi
}

print_help(){
	echo ' kousuanti [10 || 100] [lines]'
        echo ' kousuanti [10以内或者100以内] [行数]'
	echo ' 100以内的正确答案在DaAn.txt'
}

i=1;
KongGe1=' ';
KongGe2='  ';
KongGe3='   ';
KongGe4='    ';
KongGe5='     ';


if [ $1 -ne 10 ] && [ $1 -ne 100 ];then
	print_help;
	exit;
fi


if [ -e DaAn.txt ]; then 
	rm DaAn.txt; 
fi


for((i=1;i<=$2;i++));do
	lie=0;
	lin="";
	daAn="";
	if [ $1 -eq 10 ];then
		lie=5;
	else
		lie=4;
	fi

	for((j=1;j<=$lie;j++));do

		a=$(random $1);
		b=$(random $1);
		if [ $b -eq 0 ];then b=1; fi
		aAndb=`expr $a + $b`;
		aMulb=`expr $a \* $b`;
				
		if [ $1 -eq 10 ]; then
			printA=$KongGe1$a;
			printB=$b$KongGe1;
			if [ $aAndb -lt 10 ];then 
				printaAndb=${KongGe1}$aAndb; 
			else
				printaAndb=$aAndb;
			fi
			if [ $aMulb -lt 10 ];then 
				printaMulb=${KongGe1}$aMulb;
			else
				printaMulb=$aMulb;
			fi
		elif [ $1 -eq 100 ]; then
			if [ $a -lt 10 ]; then
				printA=$KongGe3$a;
			else
				printA=$KongGe2$a;
			fi
			
			if [ $b -lt 10 ]; then
				printB=$b$KongGe2;
			else
				printB=$b$KongGe1;
			fi
			
			if [ $aAndb -lt 10 ]; then
				printaAndb=$KongGe3$aAndb;
			elif [ $aAndb -gt 9 ] && [ $aAndb -lt 100 ]; then
				printaAndb=$KongGe2$aAndb;
			elif [ $aAndb -gt 99 ] && [ $aAndb -lt 1000 ]; then
				printaAndb=$KongGe1$aAndb;
			else
				printaAndb=$aAndb;
			fi
			
			if [ $aMulb -lt 10 ]; then
				printaMulb=$KongGe3$aMulb;
			elif [ $aMulb -gt 9 ] && [ $aMulb -lt 100 ]; then
				printaMulb=$KongGe2$aMulb;
			elif [ $aMulb -gt 99 ] && [ $aMulb -lt 1000 ];then
				printaMulb=$KongGe1$aMulb;
			else
				printaMulb=$aMulb;
			fi
			
		fi
		
		case `expr $a % 4` in
			0)
			lin="$lin $printA + $printB = $KongGe4";
			DaAn="$(buQi $aAndb)";
			daAn="$daAn $printA + $printB = $DaAn";
			;;
			1)
			lin="$lin ${printaAndb} - $printB = $KongGe4";
			DaAn="$(buQi $a)";
			daAn="$daAn ${printaAndb} - $printB = $DaAn";
			;;
			2)
			lin="$lin $printA × $printB = $KongGe4";
			DaAn="$(buQi $aMulb)";
			daAn="$daAn $printA × $printB = $DaAn";
			;;
			3)
			lin="$lin $printaMulb ÷ $printB = $KongGe4";
			DaAn="$(buQi $a)";
			daAn="$daAn $printaMulb ÷ $printB = $DaAn";
			;;
		esac
				
	done

	echo -e "$lin\n";
	echo -e "$daAn\n" >> ./DaAn.txt;
	
done
			
