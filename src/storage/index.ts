import { SQLiteStorage } from './sqliteStorage';
import { RedisStorage } from './redisStorage';
import { MessageStorage } from './storageProvider';

export class UnifiedStorage implements MessageStorage {
  private redis: RedisStorage;
  private sqlite: SQLiteStorage;

  constructor() {
    this.redis = new RedisStorage();
    this.sqlite = new SQLiteStorage();
  }

  async getMessage(code: number, language: string): Promise<string | null> {
    let message = await this.redis.getMessage(code, language);
    if (!message) {
      console.log(`Message not found in Redis. Falling back to SQLite.`);
      message = await this.sqlite.getMessage(code, language);
      if (message) {
        await this.redis.setMessage(code, language, message);
      }
    }
    return message;
  }

  async setMessage(code: number, language: string, message: string): Promise<void> {
    await this.sqlite.setMessage(code, language, message);
    await this.redis.setMessage(code, language, message);
  }
}

export const messageStorage = new UnifiedStorage();
