# Multi-stage build for Nuxt 3 Static Portfolio
FROM node:22-alpine AS builder

WORKDIR /app

ENV CI=true
ENV NODE_OPTIONS="--max-old-space-size=4096"

# Enable pnpm via corepack
RUN corepack enable && corepack prepare pnpm@latest --activate

# Copy application source
COPY package.json pnpm-lock.yaml ./
COPY . .

# Install dependencies
RUN pnpm install --frozen-lockfile --ignore-scripts

# Generate production static bundle
RUN pnpm build

# Production runner: Nginx Alpine
FROM nginx:1.27-alpine AS runner

# Copy generated static assets from Nitro output
COPY --from=builder /app/.output/public /usr/share/nginx/html

# Expose default HTTP port
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
