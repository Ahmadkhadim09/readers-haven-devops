# ---------- Stage 1: builder ----------
# Node.js image used only to build the site with Parcel
FROM node:22-alpine AS builder

# Working directory inside the build container
WORKDIR /app

# Copy only the dependency files first so Docker can cache the npm ci layer
COPY package*.json ./

# Install the exact versions listed in package-lock.json
RUN npm ci

# Copy the website sources
COPY src/ ./src/
COPY styles/ ./styles/

# Build the static pages into /app/dist
RUN npm run build

# ---------- Stage 2: runtime ----------
# Small Nginx image that serves the built files only, with no Node.js and no node_modules
FROM nginx:1.27-alpine

# Copy only the built site from the builder stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Nginx listens on port 80
EXPOSE 80

# Run Nginx in the foreground so the container stays running
CMD ["nginx", "-g", "daemon off;"]
