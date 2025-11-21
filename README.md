# Distributed Database System

## Prerequisites
- Docker and Docker Compose
- Node.js (v18 or higher)
- npm

## How to Run

1. **Install dependencies**
   ```bash
   npm install
   ```

2. **Start the databases**
   ```bash
   docker-compose up -d
   ```

3. **Wait for databases to initialize** (about 30 seconds)
   ```bash
   docker-compose logs -f
   ```
   Wait until you see "database system is ready to accept connections" for all databases.

4. **Start the application**
   ```bash
   npm run start:dev
   ```

5. **Access the application**
   - Open your browser and go to: http://localhost:3000

## Database Restoration

To restore databases to original state:

```bash
npm run restore
```

Or use Docker reset:

```bash
docker-compose down -v
docker-compose up -d
```

## Stopping the Application

```bash
# Stop the application: Ctrl+C

# Stop the databases:
docker-compose down
```
