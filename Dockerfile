#FROM public.ecr.aws/docker/library/node:20-alpine
FROM ghcr.io/astral-sh/uv:python3.13-bookworm-slim

RUN pwd

# Install Node.js 20, git and dependencies
RUN apt-get update && apt-get install -y curl git && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --break-system-packages requests fastmcp

RUN git clone https://github.com/ckhsponge/supergateway.git /app/supergateway
RUN cd /app/supergateway && npm install
RUN cd /app/supergateway && npm run build

COPY . .

WORKDIR /app/supergateway

EXPOSE 8080

ENTRYPOINT ["node", "/app/supergateway/dist/index.js"]

CMD ["--stdio", "python /src/server.py", "--outputTransport", "streamableHttp", "--healthEndpoint", "/ping", "--port", "8080", "--streamableHttpPath", "/invocations"]

# docker build -t supergateway .

# docker run -it --rm -p 8080:8080 supergateway

