#/bin/bash

#get info:  CPU / RAM / backup / release OS 

echo "type hostname/s which you need"

	read server

echo " select which info you want"

##functions for CPU|RAM|BACKUP|RELEASE OS

cpu ()
{
        for i in $server;
		do 
			ssh  -t $i '/bin/hostname; cat /proc/cpuinfo | grep -a -m 2 -h "model name\|cpu cores" 2>/dev/null'
					
		done
	exit 0
}

ram ()
{
	for i in $server;
                do
                        ssh -t $i '/bin/hostname; cat /proc/meminfo | grep MemTotal' 2> /dev/null;
                done
        exit 0
}


backup ()
{
        for i in $server;
                do
                        ssh  -t $i '/bin/hostname; /usr/openv/netbackup/bin/bpclimagelist | head -n 3' 2> /dev/null

                done
        exit 0
}

release ()
{
        for i in $server;
                do
                        ssh  -t $i '/bin/hostname; cat /etc/system-release' 2> /dev/null

                done
        exit 0
}


select env in cpu ram backup release

        do
                case $env in

                        cpu)		cpu             ;;
			ram)		ram		;;
			backup)		backup		;;
			release)	release		;;
                        *)
                                        echo "choose 1 selection at least or exit"
                                        break
                        ;;
                esac
        done
