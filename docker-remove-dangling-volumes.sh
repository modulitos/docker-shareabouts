docker volume rm $(docker volume ls -qf dangling=true)
