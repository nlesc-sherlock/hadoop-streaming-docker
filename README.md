# Hadoop streaming python inside docker

Run Python hadoop streaming example by running mapper/reducer inside docker container.

Python code taken from http://www.michael-noll.com/tutorials/writing-an-hadoop-mapreduce-program-in-python/

This setup will work under the following conditions:
 * The docker container will be started by the yarn user, so make sure that one is part of the docker group. Also the /var/run/docker.sock should be group writeable.
 * stdin and stdout of the docker container are connected to those of the hadoop mapper; this can be done by using docker run -i, see the mapper.sh script.
 * The container should operate on a line-by-line basis: read something from stdin, and write a response to stdout, until an end-of-file is encounterd, or the pipe is closed. You can not read the whole of stdin, do processing, and write to stdout.

http://stackoverflow.com/questions/11041253/set-hadoop-system-user-for-client-embedded-in-java-webapp

  970  runuser hdfs -s /bin/bash /bin/bash -c "hadoop fs -chown jiska /usr/jiska"
  971  runuser hdfs -s /bin/bash /bin/bash -c "hadoop fs -chown jiska /user/jiska"

# Build

```
docker build -t mapred-python .
```

# Run example

```
# upload test dataset
hdfs dfs -put data/gutenberg
```

## Without docker

```
yarn jar /usr/hdp/current/hadoop-mapreduce-client/hadoop-streaming.jar \
-file mapper.py -mapper mapper.py \
-file reducer.py -reducer reducer.py \
-input /user/vagrant/gutenberg/* \
-output /user/vagrant/gutenberg-pyout
```

## With docker


```
yarn jar /usr/hdp/current/hadoop-mapreduce-client/hadoop-streaming.jar \
-mapper mapper.sh -file mapper.sh \
-reducer reducer.sh -file reducer.sh \
-input /user/vagrant/gutenberg/* -output /user/vagrant/gutenberg-output

```

