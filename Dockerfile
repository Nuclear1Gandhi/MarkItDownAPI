# Use Python 3.10 slim base image
FROM python:3.10-slim

# Set environment variables
ENV MARK_IT_DOWN_SECRET=dev-secret
ENV CORS_DOMAIN=*

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements.txt file to install dependencies
COPY requirements.txt .
RUN python -m pip install --upgrade pip && pip install -r requirements.txt

# Install MarkItDown via pip (from PyPI)
RUN pip install markitdown

# Copy the rest of your app files into the container
COPY . .

# Set the working directory to the folder where your app.py is located
WORKDIR /app/app

# Expose port 5000 for the Flask app
EXPOSE 5000

# Set the default command to run your Flask app
CMD ["gunicorn", "-b", "0.0.0.0:5000", "-t", "300", "app:app"]
