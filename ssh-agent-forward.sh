boot2docker ssh -A
docker run -i -t -v $(readlink -f $SSH_AUTH_SOCK):/ssh-agent -e SSH_AUTH_SOCK=/ssh-agent ubuntu /bin/bash
