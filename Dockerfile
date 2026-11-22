# Stage 1: Build and test environment
FROM node:22-alpine AS builder

WORKDIR /usr/src/app

COPY package.json package-lock.json ./
RUN npm ci

COPY tsconfig.json jest.config.js ./
COPY src ./src
COPY test ./test

RUN npm run build

# Stage 2: Minimal production image
FROM node:22-alpine AS production

WORKDIR /usr/src/app

ENV NODE_ENV=production

COPY package.json package-lock.json ./
RUN npm ci --omit=dev && npm cache clean --force

COPY --from=builder /usr/src/app/dist ./dist

USER node

CMD ["node", "dist/index.js"]
