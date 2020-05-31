# FROM python:3.7.3-stretch
# Docker Needs a FROM statement even it there is nothing to build from
FROM scratch
## Step 1:
# Create a working directory
WORKDIR /capstone
## Step 2:
# Copy source code to working directory
COPY . index.html /capstone/
