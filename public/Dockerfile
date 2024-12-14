# Use Node.js LTS version as the base image
FROM node:20-slim

# Set working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json first to leverage Docker cache
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose port 8189
EXPOSE 8189

# Set environment variable for React to use the correct port
ENV PORT=8189

# Start the development server
CMD ["npm", "start"]
