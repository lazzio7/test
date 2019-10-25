#!/bin/bash
##dorobit script na add hostov cez read..
#update HPSAM according : 
#	HPSAM SK - Erik
#	HPSAM DE - Uwe
#	HPSAM DE  - Martin

#order of patching is according TEAMS ...  -->
#					ERIK 	->	PRIMARY		|	BACKUP
#				       	Uwe  	->	FIRST		|	SECOND
#					Martin	->	PRODUCTION	|	REFERENCE
#					Lenka	->	PRODCUTION	|	TEST
#					Maros	->	ROUND 1,2,3,4,5
#					BRANO	->	PRIMARY		|	BACKUP
#					KAI	->	PRIMARY
			       	  	       


##paths to list of CIs

#testing
TEST=`cat ~/scripts/application/test`
LOCALHOST=`cat ~/scripts/application/localhost`


#production
CI="/home/llegat/scripts/application/"
ERIK=`cat ~/scripts/application/SK_HPSAM_ERIK_PRIMARY`
ERIK=`cat ~/scripts/application/SK_HPSAM_ERIK_BACKUP`

UWE=`cat ~/scripts/application/DE_HPSAM_UWE_FIRST`
UWE=`cat ~/scripts/application/DE_HPSAM_UWE_SECOND`


MARTIN=`cat ~/scripts/application/DE_HPSAM_MARTIN_PRIMARY`
MARTIN=`cat ~/scripts/application/DE_HPSAM_MARTIN_REFERENCE`


LENKA=`cat ~/scripts/application/SK_MAINFRAME_PRIMARY`
LENKA=`cat ~/scripts/application/SK_MAINFRAME_TEST`


MAROS=`cat ~/scripts/application/SK_HPSAM_MAROS_round1`
MAROS=`cat ~/scripts/application/SK_HPSAM_MAROS_round2`
MAROS=`cat ~/scripts/application/SK_HPSAM_MAROS_round3`
MAROS=`cat ~/scripts/application/SK_HPSAM_MAROS_round4`
MAROS=`cat ~/scripts/application/SK_HPSAM_MAROS_round5`


BRANO=`cat ~/scripts/application/SK_HPSAM_BRANO_PRIMARY`
BRANO=`cat ~/scripts/application/SK_HPSAM_BRANO_BACKUP`


KAI=`cat ~/scripts/application/DE_HPSAM_KAI_PRIMARY`


#array pre premenne,,ale neviem ci sa to da,, zatial nic :))
#choices[1]=`cat ~/scripts/application/test`

N=`echo -e \"\n\";`

NC='\033[0m'
Y='\033[1;33m'

#LL=`ls ~/scripts/application | grep -v *.sh`
LL=`ls ~/scripts/application/`


## functions for go/nogo + patching it self + check 
###zistit ako dostat for za env zoznam strojov ,,takisto pri patch_RHEL do premennej za CIs.....,a potom aj vypisat(pole) ? 

update ()
{
for i in $env ;   
	do ssh -t $i	'	
		echo "current version $N"
		`/bin/cat /etc/system-release` "Installed sleep 1"

		echo " version which will be installed $N"
		yum info redhat-release-server |grep -A4  -e "Available sleep 1"

		/usr/bin/sudo su -l -c "
		hostname; 
		echo start yum update;echo $N;
		/usr/bin/yum update; 
		echo $?;echo $N
		/bin/cat /etc/system-release"
           		';
	done
exit 0
}


patch_RHEL()
{
echo -e "\n >>> $RED$env$NC <<< environment has benn choosen, it contains following CIs:\n\n$Y`cat $CI$env |sort`$NC\n\n`sleep 3`Would you like to continue and start patching selected systems? \n\n`sleep 1`"
#read -p "	type yes or no:      " 

echo -e "\n`sleep 1`"


#	if [[ $REPLY == yes ]]
#		then
#			echo -ne '\n loading...\n\n'
#			echo -ne '####                (33%)\r'
#			sleep 1
#			echo -ne '########            (66%)\r'
#			sleep 1
#			echo -ne '############        (100%)\r'
#			echo -ne '\n'
#
#
#				update
#		else
#			echo -ne "patching canceled\nexit\n"
#		exit 0
#	fi

select yn in "Yes" "No"
	do
		case $yn in
    			Yes)
				echo -ne '\n loading...\n\n'
                       		echo -ne '####                (33%)\r'
                       		sleep 1
                       		echo -ne '########            (66%)\r'
                       		sleep 1
                       		echo -ne '############        (100%)\r'
                       		echo -ne '\n'

	    			update;;
			No)	exit;; 
                esac
         done



}
##########################



##start patching script
echo -e	"`clear`    -------- patching HPSAM  -------- `sleep 1` \n\n\n has been initiated \n\n`sleep 1`"
echo -e	"     choose an environment please:  \n\n\n`sleep 1`"






##choose environment and call functions
select env in $LL

	do
		case $env in
			test)		
					patch_RHEL
	        	;;
			localhost)	
					patch_RHEL
                	;;
			SK_HPSAM_ERIK_PRIMARY)
					patch_RHEL
			;;
			SK_HPSAM_ERIK_BACKUP)
					patch_RHEL
			;;
			DE_HPSAM_UWE_FIRST)
					patch_RHEL
			;;
			DE_HPSAM_UWE_SECOND)
					patch_RHEL
			;;
			DE_HPSAM_MARTIN_PRIMARY)
					patch_RHEL
			;;
			DE_HPSAM_MARTIN_SECONDARY)
					patch_RHEL
			;;
			SK_MAINFRAME_PRIMARY)
					patch_RHEL
			;;
			SK_MAINFRAME_TEST)
					patch_RHEL
			;;
			SK_HPSAM_MAROS_round1)
					patch_RHEL
			;;
			SK_HPSAM_MAROS_round2)
					patch_RHEL
			;;
			SK_HPSAM_MAROS_round3)
					patch_RHEL
			;;
			SK_HPSAM_MAROS_round4)
					patch_RHEL
			;;
			SK_HPSAM_MAROS_round5)
					patch_RHEL
			;;
			SK_HPSAM_BRANO_PRIMARY)
					patch_RHEL
			;;
			SK_HPSAM_BRANO_BACKUP)
					patch_RHEL
			;;
			DE_HPSAM_KAI_PRIMARY)
					patch_RHEL
			;;

			*)		
					echo "try again"
					break
			;;
		esac
	done


