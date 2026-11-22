# Stage 1: build the site
FROM node:20-alpine AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY build.js ./
COPY src ./src
COPY styles ./styles
RUN npm run build

# Stage 2: serve it with nginx
FROM nginx:1.27-alpine
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
