# Cheatsheet for Docker and Singularity

[Docker](##Docker)
[Singularity](##Singularity) 

## Docker 

### Remove an image 
More [info](https://docs.docker.com/reference/cli/docker/image/rm/). Options are to force `-f, --force` and not to delete untagged parents `--no-prune`. 
```bash
docker image rm [options] <image> 
docker image remove <image>
```

### Remove a container 
More [info](https://docs.docker.com/reference/cli/docker/container/rm/). Options are force as above, remove a specific link `-l, --link`, and remove anonymous volumes associated with the container `-v, --volumes`. 
```bash
docker container rm [options] <container>
docker container remove <container> 
```

## Singularity
Bind a file path which isn't typically mounted by singularity be default e.g. an external disk at `/mnt/hdd`. [More info](https://singularity-tutorial.github.io/05-bind-mounts/).
```bash
singularity exec --bind /mnt/hdd lolcow.sif echo "cow"
singularity run --bind /mnt/hdd lolcow.sif echo "cow"
```


