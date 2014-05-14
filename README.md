Easy Saltstack state testing with Docker
===========
This repo provides a Saltstack setup with one master and one minion to be able to test and work with states and pillars. By using docker it's easy to reproduce and test you code.

### Use the pre built image
The pre built image can be downloaded using docker directly. After that you do not need to use this command again, you will have the image on your machine.

	$ sudo docker pull jacksoncage/salt


### Build the docker image by yourself
If you prefer you can easily build the docker image by yourself. After this the image is ready for use on your machine and can be used for multiple starts.

	$ cd salt-docker
	$ sudo docker build -t jacksoncage/salt .


#### Start the container

	$ sudo docker run -i -t -p 4505 -p 4506 -v `pwd`/srv:/srv:rw jacksoncage/salt bash

By jumping in with bash your able to start salt by

	$ service salt-master start
	$ service salt-minion start
	$ salt-key -a saltmaster

Now your ready to write you states and test them out.