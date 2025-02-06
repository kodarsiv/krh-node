export interface MessageStorage {
  getMessage(code: number, language: string): Promise<string | null>;
  setMessage(code: number, language: string, message: string): Promise<void>;
  updateMessage(code: number, language: string, message: string): Promise<void>;
}
