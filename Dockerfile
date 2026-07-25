# Stage 1: Dependency Caching Stage
FROM node:22-alpine AS deps

WORKDIR /app
ENV CI=true

# Enable pnpm via corepack
RUN corepack enable && corepack prepare pnpm@latest --activate

# Copy package manifests
COPY package.json pnpm-lock.yaml ./

# Install dependencies
RUN pnpm install --frozen-lockfile --ignore-scripts

# Stage 2: Application Builder
FROM node:22-alpine AS builder

WORKDIR /app
ENV CI=true
ENV NODE_OPTIONS="--max-old-space-size=4096"

# Enable pnpm via corepack
RUN corepack enable && corepack prepare pnpm@latest --activate

# Copy cached node_modules and app source
COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Generate static production bundle
RUN pnpm build

# Stage 3: Ultra-lightweight Caddy 2 Alpine runner (~45MB)
FROM caddy:2-alpine AS runner

# Copy generated static assets from Nitro output to Caddy html root
COPY --from=builder /app/.output/public /usr/share/caddy

EXPOSE 3000

# Serve static files on port 3000
CMD ["caddy", "file-server", "--listen", ":3000", "--root", "/usr/share/caddy"]
