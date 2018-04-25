FROM node:9.1

RUN mkdir /app
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH

# install and cache app dependencies
COPY package.json yarn.lock ./
RUN yarn

CMD ["npm", "start"]