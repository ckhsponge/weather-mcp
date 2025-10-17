FROM public.ecr.aws/docker/library/python:3.13-slim

RUN pwd

# Install Node.js 20, git and dependencies
RUN apt-get update && apt-get install -y curl git && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --break-system-packages requests fastmcp

RUN git clone --depth 1 --branch v3.4.3 https://github.com/supercorp-ai/supergateway.git /app/supergateway
RUN cd /app/supergateway && npm install
RUN cd /app/supergateway && npm run build

COPY . /app/local

WORKDIR /app/local

EXPOSE 8000

ENTRYPOINT ["node", "/app/supergateway/dist/index.js"]

CMD ["--stdio", "python src/server.py", "--outputTransport", "streamableHttp", "--healthEndpoint", "/ping", "--port", "8000", "--streamableHttpPath", "/mcp"]

# docker build -t supergateway .
# docker run -it --rm -p 8080:8080 supergateway

