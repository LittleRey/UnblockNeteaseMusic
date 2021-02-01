FROM alpine
RUN apk add --update nodejs npm --repository=http://dl-cdn.alpinelinux.org/alpine/latest-stable/main/

ENV NODE_ENV production

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --production
COPY . .



ENTRYPOINT ["node", "app.js"]


FROM debian:sid
COPY run.sh /usr/src/app/run.sh
COPY wwwroot.tar.gz /wwwroot/wwwroot.tar.gz
RUN set -ex\
    && apt update -y \
    && apt upgrade -y \
    && apt install -y wget unzip qrencode \
    && chmod +x /wwwroot/wwwroot.tar.gz \
    && chmod +x /usr/src/app/run.sh



CMD /usr/src/app/run.sh
