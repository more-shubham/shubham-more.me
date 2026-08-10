#!/bin/bash
set -e

# Load AWS configuration
[ -f .env.aws ] && export $(cat .env.aws | grep -v '^#' | xargs)
BUCKET="${AWS_S3_BUCKET:-shubham-more.me}"
REGION="${AWS_REGION:-us-east-1}"

# 1. Parallel Nuxt static generation
export NITRO_PRERENDER_CONCURRENCY=128
export NODE_OPTIONS="--max-old-space-size=4096"
pnpm generate

# 2. Maximize AWS CLI network concurrency & socket pool
aws configure set default.s3.max_concurrent_requests 128
aws configure set default.s3.max_queue_size 50000
aws configure set default.s3.multipart_threshold 8MB
aws configure set default.s3.multipart_chunksize 8MB

# 3. High-throughput differential parallel sync
aws s3 sync .output/public "s3://$BUCKET" \
  --delete \
  --region "$REGION"

echo "✓ High-performance sync complete: s3://$BUCKET"
