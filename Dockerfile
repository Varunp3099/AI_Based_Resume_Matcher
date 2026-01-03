# ==============================
# Base image (Python 3.11)
# ==============================
FROM python:3.11-slim

# ==============================
# System dependencies
# ==============================
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# ==============================
# Set working directory
# ==============================
WORKDIR /app

# ==============================
# Copy dependency files
# ==============================
COPY requirements.txt .

# ==============================
# Install Python dependencies
# ==============================
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# ==============================
# Download NLP models
# ==============================
RUN python -m spacy download en_core_web_sm \
    && python -m nltk.downloader punkt wordnet stopwords

# ==============================
# Copy project files
# ==============================
COPY . .

# ==============================
# Expose ports
# ==============================
EXPOSE 8000 8501

# ==============================
# Default command
# ==============================
CMD ["python", "main.py"]
