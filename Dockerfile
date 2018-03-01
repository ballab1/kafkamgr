FROM openjdk_8u131.11-r2:20180225

# name and version of this docker image
ARG CONTAINER_NAME=kafkamgr
ARG CONTAINER_VERSION=1.0.0

LABEL org_name=$CONTAINER_NAME \
      version=$CONTAINER_VERSION 

# set to non zero for the framework to show verbose action scripts
ARG DEBUG_TRACE=0


ARG KM_ARGS: "-Djava.net.preferIPv4Stack=true"
ARG KM_VERSION=1.3.3.16
ENV APPLICATION_SECRET: letmein
ENV ZK_HOSTS=localhost:2181


# Add configuration and customizations
COPY build /tmp/

# build content
RUN set -o verbose \
    && chmod u+rwx /tmp/build.sh \
    && /tmp/build.sh "$CONTAINER_NAME"
RUN [[ $DEBUG_TRACE == 0 ]] && rm -rf /tmp/* 


WORKDIR /kafka-manager-${KM_VERSION}
EXPOSE 9000

ENTRYPOINT [ "docker-entrypoint.sh" ]
#CMD ["$CONTAINER_NAME"]
CMD ["kafkamgr"]
