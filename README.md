# Weather MCP Server

A Model Context Protocol (MCP) server that provides weather information for different regions around the world.

## Overview

This MCP server uses the [wttr.in](https://wttr.in/) API to fetch weather data and serves it through a standardized MCP interface. It allows AI models and other clients to request weather information for any region by name.

## Features

- Fetch weather information for any city or region worldwide
- Uses the free wttr.in API (no API key required)
- Implemented as a FastMCP server for easy integration with AI models
- Docker support for easy deployment
- Minimal dependencies for fast startup and low resource usage

## Requirements

- Python 3.10+
- Only 2 dependencies:
  - `requests` - HTTP client for wttr.in API
  - `fastmcp` - MCP framework (includes uvicorn and starlette)

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/hydavinci/weather_mcp.git
   cd weather_mcp
   ```

2. Install dependencies using uv (recommended):
   ```bash
   uv sync
   ```

   Or using pip:
   ```bash
   pip install requests fastmcp
   ```

## Usage

### Running the server locally

**HTTP mode (recommended for web clients):**
```bash
# PowerShell
$env:TRANSPORT="http"; python src/server.py

# Bash/Linux
TRANSPORT=http python src/server.py
```

**stdio mode (for local MCP clients):**
```bash
python src/server.py
```

The server will start on port 8081 by default for HTTP mode.

### Using Docker

Build the Docker image:
```bash
docker build -t weather-mcp-server .
```

Run the container:
```bash
docker run -p 8081:8081 weather-mcp-server
```

## API Usage

The server exposes a single MCP tool:

### `get_weather`

Fetches weather information for the specified region.

**Parameters:**
- `region_name` (string, required): The name of the city or region to get weather for.

**Returns:**
- JSON object with comprehensive weather information from wttr.in

**Example weather data includes:**
- Current conditions and temperature
- 3-day forecast with hourly details
- Astronomical data (sunrise, sunset, moon phase)
- Weather descriptions and codes
- Humidity, pressure, wind information
- UV index and visibility

## Testing

You can test the weather functionality directly by running:

```bash
python src/weather_fetcher.py
```

This will fetch and display weather information for Suzhou (default city).

## Environment Variables

- `TRANSPORT`: Set to "http" for HTTP mode, otherwise defaults to stdio mode
- `PORT`: Port for HTTP mode (default: 8081)
- `SERVER_TOKEN`: Optional server token for stdio mode

## Project Structure

```
weather_mcp/
├── src/
│   ├── server.py           # Main MCP server
│   ├── weather_fetcher.py  # Weather API client
│   └── middleware.py       # HTTP middleware
├── pyproject.toml          # Project configuration
├── Dockerfile             # Container configuration
├── smithery.yaml          # Smithery deployment config
└── README.md              # This file
```

## License

See the [LICENSE](LICENSE) file for details.

Build the Docker image:
```bash
docker build -t weather-mcp-server .
```

Run the container:
```bash
docker run -p 8000:8000 weather-mcp-server
```

## API Usage

The server exposes a single MCP handler:

### `get_weather`

Fetches weather information for the specified region.

**Parameters:**
- `region_name` (string, required): The name of the city or region to get weather for.

**Returns:**
- JSON object with weather information from wttr.in

**Example:**
```python
# Example client code
from mcp.client import MCPClient

async with MCPClient("http://localhost:8000") as client:
    weather_data = await client.get_weather(region_name="London")
    print(weather_data)
```

## Testing

You can test the weather functionality directly by running:

```bash
python weather_fetcher.py
```

This will fetch and display weather information for Suzhou (default city).

## License

See the [LICENSE](LICENSE) file for details.