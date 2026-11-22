FROM nginx:alpine

# Serve the static site from the standard Nginx web root.
COPY src/ /usr/share/nginx/html/
COPY styles/ /usr/share/nginx/html/styles/

EXPOSE 80
