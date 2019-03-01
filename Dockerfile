FROM nginx:latest

WORKDIR /etc/nginx/app/

RUN mkdir conf

COPY . .

ENTRYPOINT [ "./entrypoint.sh" ]
CMD ["nginx", "-g", "daemon off;"]



