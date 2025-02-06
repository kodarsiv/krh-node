# 🚀 krh-node
A powerful response management package for Node.js, featuring **multi-language support**, **dynamic response codes**, and **high-performance storage with Redis & SQLite**.

---

## 📌 Features
👉 **Automatic Response Formatting** – Simplifies handling success and error responses.  
👉 **Multi-Language Support** – Fetches localized messages from **Redis & SQLite**.  
👉 **Dynamic Storage** – Uses **Redis for caching**, with **SQLite as a fallback**.  
👉 **Optimized for Scalability** – Works in both single-server and distributed environments.  
👉 **Fully Configurable** – Manage response codes, messages, and settings via `config.yml`.

---

## 📚 Installation
### **1️⃣ Clone the Repository**
```bash
git clone https://github.com/YOUR_GITHUB_USERNAME/krh-node.git
cd krh-node
```

This **automatically creates the project structure, installs dependencies, and initializes databases**.

### **2️⃣ Start the Server**
```bash
npm run dev
```
or for production:
```bash
npm run build && npm start
```

---

## ⚙️ Configuration
All settings are stored in **`config/config.yml`**:
```yaml
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
```

### **Environment Variables**
Modify `.env` for **custom Redis & SQLite settings**:
```ini
REDIS_HOST=localhost
REDIS_PORT=6379
SQLITE_DB_PATH=./storage-data/messages.db
```

---

## 🛠 Usage
### **1️⃣ Middleware Usage (Express)**
Add the middleware to your **Express app**:
```ts
import express from 'express';
import { responseManager } from './src/middleware/responseHandler';

const app = express();
app.use(responseManager());

app.get('/user', (req, res) => {
  res.success(200101, { user: 'Alice' });
});

app.get('/error', (req, res) => {
  res.error(400101, "Invalid request");
});

app.listen(3000, () => console.log('Server running on port 3000'));
```

### **2️⃣ Fetching Messages from Storage**
```ts
import { messageStorage } from './src/storage';

async function testStorage() {
  await messageStorage.setMessage(200101, 'en', 'User retrieved successfully');
  const msg = await messageStorage.getMessage(200101, 'en');
  console.log(msg); // Output: User retrieved successfully
}

testStorage();
```

---

## 📚 API Reference

### **`res.success(code, data, customMessage?)`**
👉 **Automatically sets HTTP status** (based on code).  
👉 **Fetches localized message** if no `customMessage` is provided.  
👉 **Wraps response in a standard format**.

#### **Example**
```ts
res.success(200101, { user: 'Alice' });
// Response:
{
  "status": "success",
  "code": 200101,
  "message": "User retrieved successfully",
  "data": { "user": "Alice" }
}
```

---

### **`res.error(code, errorDetails, customMessage?)`**
🚨 **Standardized error handling**.  
🚨 **Automatically maps HTTP status** from code.  
🚨 **Includes error details** for debugging.

#### **Example**
```ts
res.error(400101, "Invalid input");
// Response:
{
  "status": "error",
  "code": 400101,
  "message": "Validation failed. Please check your input.",
  "error": "Invalid input"
}
```

---

## 🏢 Project Structure
```
krh-node/
├── config/
│   └── config.yml              # Package-wide configuration
├── src/
│   ├── bootstrap/              # Handles DB & Redis connections
│   ├── config/                 # Loads configuration settings
│   ├── core/                   # Core logic (Code Registry, Localization, Errors)
│   ├── middleware/             # Express middleware
│   ├── services/               # Business logic for response handling
│   ├── storage/                # SQLite & Redis storage providers
│   ├── types/                  # TypeScript interfaces
│   ├── utils/                  # Helpers (logging, validation, etc.)
│   ├── index.ts                # Main entry file
├── storage-data/                # SQLite database & migrations
├── tests/                      # Unit & Integration tests
```

