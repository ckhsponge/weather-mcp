FROM public.ecr.aws/docker/library/node:20-alpine

RUN pwd

# Install Python, pip, and git
RUN apk add --no-cache python3 py3-pip git

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

