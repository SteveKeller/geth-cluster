FROM ethereum/client-go:alltools-v1.8.13

# set timezone for  apline image 
RUN apk --no-cache add tzdata
RUN cp /usr/share/zoneinfo/Europe/Zurich /etc/localtime
RUN echo "Europe/Zurich" >  /etc/timezone

# create local directory
RUN mkdir /privatechain

# add files for ethereum chain
ADD genesis.json /privatechain/genesis.json
ADD passfile /privatechain/passfile

# init ethereum chain andd create first account
RUN geth --datadir "/privatechain" init /privatechain/genesis.json
RUN geth --datadir "/privatechain" --password /privatechain/passfile account new | awk -F '[{}]' '{print $(NF-1)}' > /privatechain/accID
RUN mkdir /privatechain/.ethash

# define entry point 
ENTRYPOINT ["geth"]
