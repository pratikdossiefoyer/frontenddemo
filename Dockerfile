FROM node:18.20.1-alpine as build

WORKDIR /app

COPY package*.json ./
RUN npm cache clean --force && \
    npm install --legacy-peer-deps --force && \
    npm install ajv

COPY . .
RUN npm rebuild && \
    npm run build

FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
