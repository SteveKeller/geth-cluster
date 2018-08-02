FROM node:8.10.0

# make directory for explorer application and copy it inside
RUN mkdir /expl
COPY --chown=node:node explorer/ /expl
RUN chown node:node /expl

# make startscript.sh executable
RUN chmod +x /expl/startscript.sh

# change workdir
WORKDIR /expl

# upgrade npm to latest
RUN npm install npm@latest -g

# change user
USER node

# install npm packages
RUN npm install
RUN node_modules/.bin/bower install

# expose port 8000 outside container
EXPOSE 8000

# set entry point to the executable startscript.sh
ENTRYPOINT ["/expl/startscript.sh"]
