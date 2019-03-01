FROM nginx:latest

WORKDIR /etc/nginx/app/

RUN mkdir conf

COPY . .

VOLUME [ "/etc/nginx/app" ]
ENTRYPOINT [ "./entrypoint.sh" ]
CMD ["nginx", "-g", "daemon off;"]



