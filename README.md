# Data-Intensive Systems - Assignment 3
## Distributed Database System with Replication and Fragmentation

### Project Overview
This project implements a distributed database system with 3 PostgreSQL instances demonstrating:
- **Data Replication**: 50% of data is replicated across all databases (categories and global products)
- **Data Fragmentation**: 50% of data is unique to each database (region-specific customers, orders, products)

### Architecture
- **3 PostgreSQL Databases**: North, South, and East regions
- **5 Tables per Database**: categories, products, customers, orders, order_items
- **10+ Records per Table**: Each table contains minimum 10 records
- **NestJS Backend**: REST API for database operations
- **Web Frontend**: Simple UI for database selection and data manipulation

### Database Distribution Strategy

#### Replicated Data (Same in all databases):
- All 10 categories
- 5 global products (IDs 1-5)

#### Fragmented Data (Different per database):
- **North Region**:
  - Products: IDs 101-105 (winter/cold climate products)
  - Customers: IDs 1-12 (North region customers)
  - Orders & Order Items: North-specific transactions

- **South Region**:
  - Products: IDs 201-205 (beach/warm climate products)
  - Customers: IDs 21-32 (South region customers)
  - Orders & Order Items: South-specific transactions

- **East Region**:
  - Products: IDs 301-305 (tech/education products)
  - Customers: IDs 41-52 (East region customers)
  - Orders & Order Items: East-specific transactions

---

## Setup Instructions

### Prerequisites
- Docker and Docker Compose
- Node.js (v18 or higher)
- npm

### Installation Steps

1. **Clone/Download the project**
   ```bash
   cd "E:\learn\Assignment 3 - Data Intensive"
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Start PostgreSQL databases**
   ```bash
   docker-compose up -d
   ```

   This will start 3 PostgreSQL containers:
   - North DB: localhost:5432
   - South DB: localhost:5433
   - East DB: localhost:5434

4. **Wait for databases to initialize**
   ```bash
   docker-compose logs -f
   ```
   Wait until you see "database system is ready to accept connections" for all 3 databases.

5. **Start the application**
   ```bash
   npm run start:dev
   ```

6. **Access the application**
   - Open browser: http://localhost:3000
   - API: http://localhost:3000/api

---

## Database Restoration

### Method 1: Using the restoration script (Recommended)
```bash
npm run restore
```

### Method 2: Using Docker Compose (Complete reset)
```bash
docker-compose down -v
docker-compose up -d
```

### Method 3: Manual SQL restore
```bash
# North database
docker exec -i postgres-north psql -U dbuser -d ecommerce_north < database/migrations/init-schema.sql
docker exec -i postgres-north psql -U dbuser -d ecommerce_north < database/seeds/seed-north.sql

# South database
docker exec -i postgres-south psql -U dbuser -d ecommerce_south < database/migrations/init-schema.sql
docker exec -i postgres-south psql -U dbuser -d ecommerce_south < database/seeds/seed-south.sql

# East database
docker exec -i postgres-east psql -U dbuser -d ecommerce_east < database/migrations/init-schema.sql
docker exec -i postgres-east psql -U dbuser -d ecommerce_east < database/seeds/seed-east.sql
```

---

## API Endpoints

### Database Management
- `GET /api/databases` - List all available databases
- `POST /api/databases/select` - Select active database
  ```json
  { "database": "NORTH" | "SOUTH" | "EAST" }
  ```

### Table Operations
- `GET /api/tables` - List all tables in selected database
- `GET /api/tables/:tableName` - Get all records from a table
- `GET /api/tables/:tableName/:id` - Get single record by ID
- `PUT /api/tables/:tableName/:id` - Update a record
  ```json
  { "field1": "value1", "field2": "value2" }
  ```

### Restoration
- `POST /api/restore` - Restore all databases to original state

---

## Development Commands

```bash
# Install dependencies
npm install

# Start databases
docker-compose up -d

# Stop databases
docker-compose down

# View database logs
docker-compose logs -f

# Start application (development mode with hot reload)
npm run start:dev

# Build application
npm run build

# Start production server
npm run start:prod

# Restore databases
npm run restore
```

---

## Testing the Application

### 1. Verify Databases are Running
```bash
docker ps
```
You should see 3 containers: postgres-north, postgres-south, postgres-east

### 2. Test Database Connections
```bash
# Connect to North database
docker exec -it postgres-north psql -U dbuser -d ecommerce_north

# In psql, run:
SELECT COUNT(*) FROM categories;  -- Should return 10
SELECT COUNT(*) FROM products;    -- Should return 10 (5 global + 5 regional)
SELECT COUNT(*) FROM customers;   -- Should return 12
\q
```

### 3. Test Application Features
1. Open http://localhost:3000
2. Select a database (North/South/East)
3. View data from different tables
4. Click "📥 Download as CSV" button to export table data
5. Update a record using the Edit button
6. Switch to a different database
7. Verify the update only affected the selected database

---

## Project Structure

```
Assignment 3 - Data Intensive/
├── src/
│   ├── main.ts                 # Application entry point
│   ├── app.module.ts           # Root module
│   ├── database/               # Database configuration
│   ├── modules/
│   │   ├── databases/          # Database selection module
│   │   ├── tables/             # Table operations module
│   │   └── data/               # Data manipulation module
│   └── common/                 # Shared utilities
├── database/
│   ├── migrations/
│   │   └── init-schema.sql     # Database schema
│   └── seeds/
│       ├── seed-north.sql      # North region data
│       ├── seed-south.sql      # South region data
│       └── seed-east.sql       # East region data
├── scripts/
│   └── restore-databases.ts    # Restoration script
├── docker-compose.yml          # Docker configuration
├── package.json
└── README.md
```

---

## Grading Criteria Checklist

- ✅ **3 Points**: Three PostgreSQL databases created
  - postgres-north (port 5432)
  - postgres-south (port 5433)
  - postgres-east (port 5434)

- ✅ **3 Points**: Databases contain correct amount of data
  - 5 tables per database (categories, products, customers, orders, order_items)
  - 10+ records per table
  - 50% replicated data (categories, global products)
  - 50% fragmented data (regional products, customers, orders)

- ✅ **2 Points**: Database selection functionality
  - UI allows selecting North/South/East database
  - Application connects to selected database
  - Database switching works correctly

- ✅ **2 Points**: Data operations
  - Print data: Download table data as CSV file (1 point)
  - Update data: Modify records in selected database (1 point)

---

## Troubleshooting

### Databases won't start
```bash
docker-compose down -v
docker-compose up -d
```

### Port already in use
Edit `docker-compose.yml` and change the port mappings:
```yaml
ports:
  - "5435:5432"  # Change 5432 to 5435
```

### Application can't connect to databases
1. Verify databases are running: `docker ps`
2. Check `.env` file has correct connection details
3. Ensure ports 5432, 5433, 5434 are not blocked by firewall

### Seed data not loading
```bash
docker-compose down -v
docker-compose up -d --force-recreate
```

---

## Video Demonstration Script

1. **Show databases running**: `docker ps`
2. **Open application**: Navigate to http://localhost:3000
3. **Demonstrate database selection**: Switch between North, South, East
4. **View replicated data**: Show categories are the same in all databases
5. **View fragmented data**: Show different customers in each database
6. **Print/Download data**: Click "📥 Download as CSV" button and show downloaded file
7. **Update operation**: Update a record in North database using Edit button
8. **Verify isolation**: Show the record in South database is unchanged
9. **Restoration**: Run `npm run restore` and verify data is reset

---

## Technologies Used

- **Backend**: NestJS, TypeScript
- **Database**: PostgreSQL 16
- **ORM**: TypeORM
- **Containerization**: Docker, Docker Compose
- **Frontend**: HTML, CSS, JavaScript (or React)

---

## Author

Data-Intensive Systems Assignment 3
Course: CT80A0000
Deadline: 16.11.2025
