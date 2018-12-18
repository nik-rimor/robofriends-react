# base image
FROM node:8.14-alpine

# Create app directory and use it as the working directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# add `/usr/src/app/node_modules/.bin to $PATH
ENV PATH /usr/src/app/node_modules/.bin:$PATH

# install and cache dependencies
COPY package.json /usr/src/app/package.json
COPY yarn.lock /usr/src/app/yarn.lock
RUN npm install

# copy webpackDevServer config with modified watchOptions 
# where poll: 3000  is added to check for changes every 3 seconds
# this gives a 'warm' reload ability when working with webpack in 
# docker container on Microsoft Windows
COPY WindowsDockerReact/webpackDevServer.config.js /usr/src/app/node_modules/react-scripts/config/webpackDevServer.config.js

# start app (developer environment)
CMD ["yarn", "start"]