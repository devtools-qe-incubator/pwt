FROM registry.access.redhat.com/ubi9/ubi-minimal@sha256:bdb50787faf8f9416ee7d669ccbbc0727bd8920d043fb8144987698788399a01 as init

ARG OS

COPY dependencies/*.zip /tmp/dependecies.zip

RUN microdnf install -y tar xz zip \
    && mkdir -p pwt/.node \
    && mkdir -p pwt/node_modules \
    && mkdir /dist \
    && unzip /tmp/dependecies.zip -d pwt/node_modules \
    && chmod +x pwt/node_modules/.bin/* 

COPY cli/${OS}/* pwt

FROM init as windows

WORKDIR /pwt

ARG ARCH NODEJS_VERSION

ENV NODEJS_URL https://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-win-x64.zip

RUN curl -LO ${NODEJS_URL} \
    && unzip -d .node $(basename  "${NODEJS_URL}") \
    && f=(.node/*) \
    && mv .node/*/* .node \
    && rmdir "${f[@]}" \
    && rm $(basename  "${NODEJS_URL}") \
    && zip -r /dist/pwt-windows-${ARCH}.zip ./

FROM init as linux

WORKDIR /pwt

ARG ARCH NODEJS_VERSION

ENV NODEJS_URL https://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-linux-${ARCH}.tar.xz

RUN curl -LO ${NODEJS_URL} \
    && tar xf $(basename  "${NODEJS_URL}") -C .node --strip-components 1 \
    && rm $(basename  "${NODEJS_URL}") \
    && tar cfJv /dist/pwt-linux-${ARCH}.tar.xz .

FROM init as darwin

WORKDIR /pwt

ARG ARCH NODEJS_VERSION

ENV NODEJS_URL https://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-darwin-${ARCH}.tar.xz

RUN curl -LO ${NODEJS_URL} \
    && tar xf $(basename  "${NODEJS_URL}") -C .node --strip-components 1 \
    && rm $(basename  "${NODEJS_URL}") \
    && tar cfJv /dist/pwt-darwin-${ARCH}.tar.xz .
