# Stage 1: Build the application
FROM node:lts-alpine3.23 as builder
WORKDIR /app

RUN addgroup -g 1001 -S nodejs && adduser -S nodejs -u 1001 -G nodejs && chown -R nodejs:nodejs /app
COPY package*.json ./
# assuming package-lock.json is present, if not, it will be ignored
USER nodejs
RUN npm ci

COPY . .
RUN npm run build

# Stage 2: Final image

FROM node:lts-alpine3.23 as Final
WORKDIR /app

COPY --from=builder --chown=nodejs:nodejs /app/node_modules ./node_modules
COPY --from=builder --chown=nodejs:nodejs /app/package*.json ./
COPY --from=builder --chown=nodejs:nodejs /app/dist ./dist

USER nodejs

EXPOSE 3000
CMD ["node", "dist/server.js"]

