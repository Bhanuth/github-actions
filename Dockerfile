# Use an official Node.js runtime as a parent image
FROM node:nginx
# Set the working directory to /app
WORKDIR /app
# Copy the HTML, CSS, and JS files to the container
COPY index.html .
# Expose port 80 for incoming traffic
EXPOSE 80
# Run a command to start the web server
CMD ["npx", "http-server", "-p", "80"]
