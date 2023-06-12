FROM nginx:1.25.0
COPY html /usr/share/nginx/html
HEALTHCHECK --interval=5s --timeout=10s --start-period=5s --retries=3 CMD [ "wget", "-q","-O","-","-U","healthcheck","http://localhost:80/","||"."exit","1" ]