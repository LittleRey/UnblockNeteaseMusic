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
RUN chmod +x /usr/src/app/run.sh



CMD /usr/src/app/run.sh
