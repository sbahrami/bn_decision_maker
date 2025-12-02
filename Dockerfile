# Uses Streamlit and pyAgrum; installs graphviz for visualization
FROM python:3.11-slim

RUN apt-get update && apt-get install -y graphviz && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy requirements first to leverage Docker layer caching
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# Copy your app code (adjust paths if your app is nested)
COPY . /app

EXPOSE 8501
ENV PYTHONUNBUFFERED=1

CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]