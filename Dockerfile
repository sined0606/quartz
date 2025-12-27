FROM node:22-slim AS builder
WORKDIR /usr/src/app
COPY package.json .
COPY package-lock.json* .
RUN npm ci

FROM node:22-slim
RUN apt-get update && apt-get install -y cron && rm -rf /var/lib/apt/lists/*
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app/ /usr/src/app/
COPY . .
CMD ["npx", "quartz", "build", "--serve"]
