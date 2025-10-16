FROM public.ecr.aws/docker/library/node:20-alpine

# Install Python and pip
RUN apk add --no-cache python3 py3-pip

# Install Python dependencies
RUN pip install --break-system-packages requests fastmcp

RUN npm install -g supergateway

COPY . .

EXPOSE 8080

ENTRYPOINT ["supergateway"]

CMD ["--stdio", "python src/server.py", "--outputTransport", "streamableHttp", "--healthEndpoint", "/ping", "--port", "8080"]

