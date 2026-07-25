# Multi-stage build for Nuxt 3 Static Portfolio using `serve`
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

# Production runner: Lightweight Node Alpine with `serve`
FROM node:22-alpine AS runner

WORKDIR /app

# Install lightweight static file server `serve`
RUN npm install -g serve

# Copy generated static assets from Nitro output
COPY --from=builder /app/.output/public ./public

# Expose port 3000
EXPOSE 3000

# Serve static files with single-page app fallback (-s) on port 3000
CMD ["serve", "-s", "public", "-l", "3000"]
