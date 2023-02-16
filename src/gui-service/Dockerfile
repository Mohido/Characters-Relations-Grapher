####
# A production dockerizing file. Make sure to build the project before using this dockerfile. Building the project can be done
# with `npm run build`. This create an `dist` and `server` folders containing the result of the build.

FROM node:alpine

# ---------- Running the server
WORKDIR /usr/src/app
COPY ./dist/ ./dist/
COPY ./public/ ./public/
COPY ./server/ ./server/
COPY ./package.json ./package.json
ENV PORT=5000
EXPOSE 5000

# RUN apk add nodejs npm
RUN npm install --omit=dev
CMD npm run deploy