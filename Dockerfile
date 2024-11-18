# Use a Node.js base image to build the application
FROM node:14 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Build the Angular project
RUN npm run build --prod

# Serve the application using Nginx
FROM nginx:alpine

# Copy the built application from the build stage
COPY --from=build /app/dist/crudtuto-Front /usr/share/nginx/html

# Expose port 80 to access the app
EXPOSE 4200

# Run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
