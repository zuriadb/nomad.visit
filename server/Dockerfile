FROM node:20-alpine

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci
COPY . .
RUN chmod +x ./node_modules/.bin/*
EXPOSE 3006
CMD ["npx", "nest", "start", "--watch"]