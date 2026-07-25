# Multi-stage build for Nuxt 3 Static Portfolio
FROM node:22-alpine AS builder

WORKDIR /app

# Enable pnpm via corepack
RUN corepack enable && corepack prepare pnpm@latest --activate

# Copy package manifests
COPY package.json pnpm-lock.yaml ./

# Install dependencies
RUN pnpm install --frozen-lockfile

# Copy application source
COPY . .

# Generate production static bundle
RUN pnpm build

# Production runner: Nginx Alpine
FROM nginx:1.27-alpine AS runner

# Copy generated static assets from Nitro output
COPY --from=builder /app/.output/public /usr/share/nginx/html

# Expose default HTTP port
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
