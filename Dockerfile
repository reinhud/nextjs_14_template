# Use latest stable release of docker syntax.
# syntax=docker/dockerfile:1

#==============================================================================#
#========= Base Image =========#
#==============================================================================#
# Use slim, up to date, and official LTS version as base.

ARG NODE_VERSION=20.9.0
# Uses an official Node.js slim image as the base
FROM node:${NODE_VERSION}-bookworm-slim AS base

# Declaring the port the app runs on
ENV PORT=3000

# Setting up the environment for pnpm
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"

# Enabling Corepack to manage package managers like pnpm
RUN corepack enable

# Set the working directory for all stages
WORKDIR /workspace/next-app

RUN echo "Base image build successfully"


#==============================================================================#
#========= Production Dependancy Image =========#
#==============================================================================#

FROM base AS prod-deps

# Copying package.json and pnpm-lock.yaml for dependency installation
COPY /next-app/package.json /next-app/pnpm-lock.yaml ./

# Installing production dependencies without updating the lockfile
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --prod --frozen-lockfile

RUN echo "Dependancy image build successfully"


#==============================================================================#
#========= Development Image =========#
#==============================================================================#

FROM base AS dev

# Specify environment
ENV NODE_ENV=development

# Installing git 
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Copying installed node_modules for production dependencies
COPY --from=prod-deps /workspace/next-app/node_modules /workspace/next-app/node_modules

# Copying package.json and pnpm-lock.yaml for dependency installation
COPY /next-app/package.json /next-app/pnpm-lock.yaml ./

# Install all dependencies (will reuse production dependencies)
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install

RUN echo "Development image build successfully"


#==============================================================================#
#========= Builder Image =========#
#==============================================================================#

FROM base as builder 

# Copying the application 
COPY ./next-app ./

# Installing all dependencies, required for the build
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --frozen-lockfile

# Building the application
RUN pnpm run build

RUN echo "Builder image build successfully"


#==============================================================================#
#========= Production Image =========#
#==============================================================================#
FROM base as prod

# Specify environment
ENV NODE_ENV=production

# Copy the production dependencies
COPY --from=prod-deps /workspace/next-app/node_modules ./node_modules

# Copy only the built artifacts
COPY --from=builder /workspace/next-app/.next /workspace/next-app/.next

COPY ./next-app/public ./public

# Copying package.json is necessary to run scripts for starting the app
COPY ./next-app/package.json ./

# Exposing the port 
EXPOSE $PORT

# Switch to the non-root user
USER node

# Run the app
CMD ["pnpm", "start"]