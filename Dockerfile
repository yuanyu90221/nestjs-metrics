FROM node:alpine AS dev
WORKDIR /usr/src/app
COPY package.json ./
COPY yarn.lock ./
RUN yarn install --frozen-lockfile
COPY . .
RUN yarn run build
FROM node:alpine as prod
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}
WORKDIR /usr/src/app
COPY package.json ./
COPY yarn.lock ./
RUN yarn install --production=true --frozen-lockfile
COPY . .
COPY --from=dev /usr/src/app/dist ./dist
USER node
CMD [ "node", "dist/main" ]