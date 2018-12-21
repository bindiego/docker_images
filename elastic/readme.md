# Run Elastic Stack in Docker

## Prerequisite
Please navigate into the parent folder, ubuntu & jdk, and run

```
make build
```

respectively to build the system and runtime images

## Run Elastic Stack (Elasticsearch & Kibana only)

```
make all
```

Should do the trick, you should be able to access your local elasticsearch on port 19200 and kibana on 15601 then.

### Allocate more heap for Elasticsearch

Simply update the Makefile, find the run_es task and change the `-m 2G`, which is the default value, to the twice of your desired heap size. For example, you are going to allocate 8GB for your jvm, then you need to use `-m 16G` in the Makefile. Finally, update the parameter `ES_HEAP` to the value, in this case, `-e ES_HEAP=8g`.

You almost done, I hight recommend you also update the `es.jvm.options` file in conf folder to reflect the heap value you updated in the Makefile. I am not a java expert, but I do see they all passed as parameters to the startup script. So, to be safe, you know.

### Use a differnet version of Elastic Stack

Simply update the environment variable `ES_VER` in dockerfiles respectively.

### More runtime memory for Kibana

Similar to Elasticsearch, find the run_kbn task in Makefile. Then change `-m 1G` to the number you want.

### IMPORTANT

All of the data will be written outside the container on your local disk. By default, a folder called data will be created at this project root. So you will not lose anything by restarting or upgrading your deployment.

## Clean up

```
make clean
```

Will simply do the job. It will stop all the running containers and remove them. 

But it will NOT remove the local data and the built docker images. You will have to clean them yourselves by `rm -rf <data_folder>` and `docker rmi <images>` for cleaning up everything.
