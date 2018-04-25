# Stage 1 - the build process
FROM node:9.10 as build-deps

RUN mkdir /app
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH

# install and cache app dependencies
COPY package.json yarn.lock ./
RUN yarn

COPY . ./
RUN yarn build

# Stage 2 - the production environment
FROM nginx:1.12-alpine
COPY --from=build-deps /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]


# docker build . -t lymanlai/cra-docker
# docker run -p 8080:80 lymanlai/cra-docker