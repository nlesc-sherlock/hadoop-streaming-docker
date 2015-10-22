# Hadoop streaming python inside docker

Run Python hadoop streaming example by running mapper/reducer inside docker container.

Python code taken from http://www.michael-noll.com/tutorials/writing-an-hadoop-mapreduce-program-in-python/

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

