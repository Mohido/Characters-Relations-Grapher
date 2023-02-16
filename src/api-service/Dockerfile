####
# A production dockerizing file. Make sure to build the project before using this dockerfile. Building the project can be done
# with `npm run build`. This create an `out` folder containing the result of the build.


FROM node:alpine

# ----------- Installing Extra Packages
# Vim Editor for editing code and testing in case of container failure
# RUN apt-get update && apt-get install apt-file -y && apt-file update && apt-get install vim -y 

# ---------- Running the server
WORKDIR /usr/src/app
COPY out/ .
COPY ./package.json ./package.json


EXPOSE 5001
# RUN apk add nodejs npm
RUN npm install --omit=dev
CMD ["node", "server.js"]