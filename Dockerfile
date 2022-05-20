FROM alpine:3.14

WORKDIR /app

# Node 14.19.0 and Npm 7.17.0
RUN apk --update --no-cache upgrade \
    && apk add bash \
    && apk add nano \
    && apk add nodejs npm \
    && apk add gmp gmp-dev \
    && apk add git

# Java 11.0.14
RUN  apk update \
  && apk upgrade \
  && apk add ca-certificates \
  && update-ca-certificates \
  && apk add --update coreutils && rm -rf /var/cache/apk/*   \
  && apk add --update openjdk11 tzdata curl unzip bash \
  && apk add --no-cache nss \
  && rm -rf /var/cache/apk/*

# Body
COPY package-lock.json package.json /app/
RUN npm ci --loglevel verbose
COPY . .
EXPOSE 8085
CMD [ "npm", "start" ]



