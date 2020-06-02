FROM nginx:1.18.0-alpine
## Step 1: Delete the one used by Nginx
RUN rm /usr/share/nginx/html/index.html

## Step 2:
# Replace the file we deleted with our file
COPY index.html /usr/share/nginx/html


# # FROM python:3.7.3-stretch
# # Docker Needs a FROM statement even it there is nothing to build from
# FROM scratch
# ## Step 1:
# # Create a working directory
# WORKDIR /capstone
# ## Step 2:
# # Copy source code to working directory
# COPY . index.html /capstone/
