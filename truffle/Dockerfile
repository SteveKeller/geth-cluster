FROM node:9.11.1-alpine

# set timezone for alpine image
RUN apk --no-cache add tzdata
RUN cp /usr/share/zoneinfo/Europe/Zurich /etc/localtime
RUN echo "Europe/Zurich" >  /etc/timezone

# install truffle with deps
RUN apk add -t .gyp --no-cache git python g++ make 
RUN npm install -g truffle
RUN apk del .gyp

# make directory for smart contracts
RUN mkdir -p /dapp
WORKDIR /dapp

# copy smart contract in container
COPY sc/ /dapp

# set container entry point to truffle application
ENTRYPOINT ["truffle"]
