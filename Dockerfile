# Multi-stage build for Nuxt 3 Static Portfolio using ultra-lightweight Caddy (~45MB)
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

# Stage 2: Ultra-lightweight Caddy 2 Alpine runner (~45MB total image)
FROM caddy:2-alpine AS runner

# Copy generated static assets from Nitro output to Caddy html root
COPY --from=builder /app/.output/public /usr/share/caddy

EXPOSE 3000

# Serve static files with SPA fallback natively on port 3000 (Zero config files needed)
CMD ["caddy", "file-server", "--listen", ":3000", "--root", "/usr/share/caddy", "--try-files", "{path}", "{path}/", "/index.html"]
