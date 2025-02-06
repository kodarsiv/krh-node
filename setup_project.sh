#!/bin/bash

echo "🚀 Setting up the project structure..."


# Create directories
mkdir -p ./{config,src/bootstrap,src/config,src/core,src/middleware,src/services,src/storage,src/types,src/utils,tests/unit,tests/integration,storage-data/migrations,scripts}

# Create essential files
touch ./{.env,.gitignore,README.md,package.json,tsconfig.json}
touch ./config/config.yml
touch ./src/{index.ts,config/index.ts,core/codeRegistry.ts,core/localization.ts,core/errors.ts}
touch ./src/middleware/{responseHandler.ts,errorHandler.ts}
touch ./src/services/{messageService.ts,codeService.ts}
touch ./src/storage/{index.ts,sqliteStorage.ts,redisStorage.ts,storageProvider.ts}
touch ./src/types/{configTypes.ts,responseTypes.ts}
touch ./src/utils/{logger.ts,validator.ts}
touch ./tests/{setupTest.ts}
touch ./storage-data/migrations/init.sql
touch ./scripts/{migrate.js,seed.js}

# Populate .gitignore
cat <<EOL > ./.gitignore
# Node modules
node_modules/
dist/
storage-data/messages.db
.env
EOL

# Populate .env
cat <<EOL > ./.env
# Environment Variables
REDIS_HOST=localhost
REDIS_PORT=6379
SQLITE_DB_PATH=./storage-data/messages.db
EOL

# Populate tsconfig.json
cat <<EOL > ./tsconfig.json
{
  "compilerOptions": {
    "target": "ES6",
    "module": "CommonJS",
    "strict": true,
    "outDir": "dist",
    "rootDir": "src",
    "resolveJsonModule": true
  }
}
EOL

# Populate config.yml
cat <<EOL > ./config/config.yml
supportedLanguages: ['en', 'fr']
codeCategories:
  auth: 200100
  payment: 200200
  validation: 400100
storage:
  sqlite:
    path: './storage-data/messages.db'
  redis:
    host: 'localhost'
    port: 6379
EOL

# Populate init.sql for SQLite migrations
cat <<EOL > ./storage-data/migrations/init.sql
CREATE TABLE IF NOT EXISTS messages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    code INTEGER NOT NULL,
    language TEXT NOT NULL,
    message TEXT NOT NULL,
    UNIQUE(code, language)
);
EOL

# Initialize a git repository
git init
npm init -y
echo "✅ project initialized successfully!"
