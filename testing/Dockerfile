FROM node:9.11.1-alpine

# set timezone for apline image
RUN apk --no-cache add tzdata
RUN cp /usr/share/zoneinfo/Europe/Zurich /etc/localtime
RUN echo "Europe/Zurich" >  /etc/timezone

# add git to alpine
RUN apk --no-cache add git

# define workdir
RUN mkdir /data
WORKDIR /data

# copy npm files
COPY package.json .
COPY tests.js . 

RUN npm install

# start npm test
CMD npm test
