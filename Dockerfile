# Build Environment
FROM node:10.23.0 as build
WORKDIR /app
COPY package*.json ./
RUN npm ci --silent
COPY . ./
RUN npm run build

FROM nginx:1.18.0
COPY --from=build /app/build /usr/share/nginx/html/app
COPY nginx.conf /etc/nginx/conf.d/default.conf
CMD ["nginx", "-g", "daemon off;"]