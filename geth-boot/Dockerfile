# take geth image with alltools (bootstrap tool)
FROM ethereum/client-go:alltools-v1.8.8

# set timezone for  apline image
RUN apk --no-cache add tzdata
RUN cp /usr/share/zoneinfo/Europe/Zurich /etc/localtime
RUN echo "Europe/Zurich" >  /etc/timezone

# create local data directory for geth
RUN mkdir /privatechain

# copy own bootkey
ADD bootnode.key /privatechain/bootnode.key

# define entrypoint
ENTRYPOINT ["bootnode"]
