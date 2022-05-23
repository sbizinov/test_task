# Used smallest possible image instead of ubuntu and fixed a ver by tag.
FROM node:current-alpine3.15
COPY ./src /app
RUN npm install --only=production
# I've exposed a port cause it seems useless to have app w/o opened listen port (: 
EXPOSE 8080
CMD ["node", "server.js"]
