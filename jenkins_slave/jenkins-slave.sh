#!/usr/bin/env bash

# The MIT License
#
#  Copyright (c) 2015, CloudBees, Inc.
#
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in
#  all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#  THE SOFTWARE.

# Usage jenkins-slave.sh [options] -url http://jenkins SECRET SLAVE_NAME
# Optional environment variables :
# * JENKINS_TUNNEL : HOST:PORT for a tunnel to route TCP traffic to jenkins host, when jenkins can't be directly accessed over network
# * JENKINS_URL : alternate jenkins URL

if [ "${1:0:1}" == "-" ] ; then
    echo "call /home/jenkins/slave.jar to stat JNLP connection to Jenkins master with '$@'"
    java -jar /home/jenkins/slave.jar $@
elif [ "${1:0:3}" == "" ] ; then
    echo "call /home/jenkins/slave.jar to stat JNLP connection to Jenkins master"
    java -jar /home/jenkins/slave.jar -master $JENKINS_MASTER_URL -password $JENKINS_JNLP_PW -username $JENKINS_JNLP_USER $JENKINS_SLAVE_ADD_ARG
else
	# if `docker run` starts not with '-', we assume user is running alternate command like `bash` to inspect the image
	echo "call $@"
	exec "$@"
fi
