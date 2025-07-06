# Use official Node.js Alpine image
FROM node:18-alpine

# Set working directory inside the container
WORKDIR /usr/src/app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the code
COPY . .

# Expose port (matches server.js)
EXPOSE 3000

# Start the app
CMD ["node", "server.js"]
