# develop stage
FROM node:19-alpine3.16 as develop-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
# production stage
FROM nginx:1.23.3-alpine as production-stage
COPY --from=develop-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]
