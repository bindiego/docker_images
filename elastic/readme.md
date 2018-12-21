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

Simply update the environment variable `ES_VER` in dockerfiles respectively. This requires rebuild the images.

### More runtime memory for Kibana

Similar to Elasticsearch, find the run_kbn task in Makefile. Then change `-m 1G` in `run_kbn` task to the number you want.

### IMPORTANT

All of the data will be written outside the container on your local disk. By default, a folder called data will be created at this project root. So you will not lose anything by restarting or upgrading your deployment.

## Clean up

```
make clean
```

Will simply do the job. It will stop all the running containers and remove them. 

But it will NOT remove the local data and the built docker images. You will have to clean them yourselves by `rm -rf <data_folder>` and `docker rmi <images>` for cleaning up everything.

## 写在前面
请务必先到上级目录构建依赖的系统和java环境的镜像，ubuntu & jdk，分别执行

```
make build
```

就可以了。

## Elastic Stack 跑起来

执行

```
make all
```

就可以了，通过`docker ps`命令应该可以看到elasticsearch和kibana的实例，Elasticsearch会跑在本地19200端口，Kibana是15601.

### 为Elasticsearch使用更多的内存

这里只要更新Makefile里的参数就好了，首先找到 `run_es` 这个任务，更改`-e ES_HEAP`这个参数到你目标的内存大小，并且更新`-m`为其2倍的大小。

举例：我们现在要给ES 8GB的堆内存，那么需要设置这2个参数分别为：

```
-m 16g
-e ES_HEAP=8g
```

我自己测试到这里都OK，但是最好还是更新一下相应的 `es.jvm.options` 文件在conf这个文件夹下。我不是java专家，这些参数都会被传递到启动脚本，有些可能可以合并，但可能会有互斥的参数，所以安全起见，你懂的。

### 使用不同的版本

这里就非常直接了，直接更新Dockerfile里的 `ES_VER` 环境变量的值就好了。当然这个需要重新构建镜像。

### 为Kibana使用更多的内存

跟Elasticsearch一样，打开Makefile，在`run_kbn`这个任务下改变 `-m 1G` 这个默认参数就好了。

### 清理

```
make clean
```

这个命令就会简单清理掉本地的容器和构建过程中的一些没有用的镜像。但是不会清理本地的数据，数据会默认的放到当前一个叫data的文件夹下，为了是方便大家重启和升级的时候数据还在。这块需要手动清理。还有就是已经构建好的latest的镜像，也需要使用`docker rmi`手动删除。这样就会释放你磁盘上所有的空间了。

制作匆忙，肯定会有各种问题，欢迎大家指出。主要目的还是希望帮助新手能快速玩起来。谢谢！