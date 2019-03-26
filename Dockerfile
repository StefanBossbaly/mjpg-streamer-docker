FROM alpine:latest

RUN apk --update --no-cache add --virtual build-dependencies git make cmake gcc g++ linux-headers musl-dev libjpeg-turbo-dev

RUN git clone https://github.com/jacksonliam/mjpg-streamer.git

WORKDIR /mjpg-streamer/mjpg-streamer-experimental

RUN make && \
    make install

# Cleanup
RUN rm -fr /mjpg-streamer
RUN apk del build-dependencies
