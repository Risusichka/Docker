FROM node:20-bullseye-slim
WORKDIR /app
RUN apt-get update && apt-get install -y --no-install-recommends openssl ca-certificates && rm -rf /var/lib/apt/lists/*
COPY package.json package-lock.json* yarn.lock* pnpm-lock.yaml* ./
RUN npm ci || npm install
COPY . .
RUN npx prisma generate || true
# Build TypeScript ahead of time to avoid ts-node-dev in production
RUN npm run build
EXPOSE 3000
CMD ["npm","start"]



