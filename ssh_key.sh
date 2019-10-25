#/bin/bash
#testtogitcommit

#copy ssh identity to server

echo "type server where SSH indentity should be transfered:"

        read server


for	i	in $server;
	do ssh-copy-id -i ~/.ssh/id_rsa.pub $i;
done

#dd
