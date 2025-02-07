# Use an official Node.js runtime as a parent image
FROM node:18-alpine

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json first
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy the rest of the application
COPY . .

# Copy environment variables
COPY .env .env

# Expose the port the app runs on
EXPOSE 3000

# Start the application
CMD ["node", "server.js"]
