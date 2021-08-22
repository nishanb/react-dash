#Build Phase
FROM node:alpine as builder

WORKDIR /app

COPY ./package.json .
RUN npm install

COPY . .
RUN npm run build

#RUN Phase ( specifying from refers to a new stage terminates the last)
FROM nginx:alpine

EXPOSE 80

#copy from last phase
COPY --from=builder /app/build /usr/share/nginx/html