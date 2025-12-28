FROM python:3.9-slim

# Install system dependencies for VTK
RUN apt-get update && apt-get install -y \
    libgl1 \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgomp1 \
    libosmesa6 \
    libegl1 \
    libgles2 \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements and install Python dependencies
COPY 04_application/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir trame-components

# Copy data directory and application
COPY data /app/data
COPY 04_application/app.py .

# Expose port
EXPOSE 8080

# Run the application
CMD ["python", "app.py", "--port", "8080"]
