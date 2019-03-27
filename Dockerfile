FROM alpine:3.7

# PATHS
ENV PACKAGES="\
      musl-dev \
      libjpeg-turbo-dev \
    " \
    BUILD_PACKAGES="\
      git \
      make \
      cmake \
      gcc \
      g++ \
      linux-headers \
    " \
    LD_LIBRARY_PATH="/usr/local/lib/mjpg-streamer"

RUN set -ex ;\
    apk add --update $PACKAGES ;\
    apk add --update --no-cache --virtual build-dependencies $BUILD_PACKAGES ;\
    git clone https://github.com/jacksonliam/mjpg-streamer.git ;\
    make -C /mjpg-streamer/mjpg-streamer-experimental ;\
    make -C /mjpg-streamer/mjpg-streamer-experimental install ;\
    rm -fr /mjpg-streamer ;\
    apk del --no-cache --purge build-dependencies ;\
    rm -rf /var/cache/apk/*

ENTRYPOINT ["mjpg_streamer"]
