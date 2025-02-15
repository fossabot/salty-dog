FROM node:11-stretch

# copy config, which changes rarely
COPY docs/config-docker.yml /root/.salty-dog.yml

# copy package first, to invalidate other layers when version changes
COPY package.json /salty-dog/package.json

# copy chunks, largest to smallest (entrypoint)
COPY out/vendor.js /salty-dog/out/vendor.js
COPY out/main.js /salty-dog/out/main.js
COPY out/index.js /salty-dog/out/index.js

# set up as global cli tool
WORKDIR /salty-dog
RUN yarn global add file:$(pwd)
ENV PATH="${PATH}:$(yarn global bin)"

COPY rules /salty-dog/rules

ENTRYPOINT [ "node", "/salty-dog/out/index.js" ]
CMD [ "--help" ]