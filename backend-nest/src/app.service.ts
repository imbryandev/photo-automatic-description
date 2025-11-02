import { Injectable, ServiceUnavailableException } from '@nestjs/common';
import * as dotenv from 'dotenv';
import OpenAI, { RateLimitError } from 'openai';
import { DescribeResponse } from './interfaces/describe-response.interface';

dotenv.config();

@Injectable()
export class AppService {
  private openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });

  async describeImage(file: Express.Multer.File): Promise<DescribeResponse> {
    if (!file) throw new ServiceUnavailableException('Archivo no válido');

    const base64Image = file.buffer.toString('base64');

    // Número máximo de reintentos si ocurre un rate limit
    const maxRetries = 5;
    let attempt = 0;

    while (attempt < maxRetries) {
      try {
        console.log(`🧠 Enviando imagen a OpenAI (intento ${attempt + 1})...`);

        const response = await this.openai.responses.create({
          model: 'gpt-4o-mini',
          input: [
            {
              role: 'user',
              content: [
                {
                  type: 'input_text',
                  text: `Describe esta imagen de manera breve.`,
                },
                {
                  type: 'input_image',
                  image_url: `data:image/jpeg;base64,${base64Image}`,
                  detail: 'auto',
                },
              ],
            },
          ],
        });

        return { description: response.output_text };
      } catch (error: any) {
        attempt++;

        // Caso: límite de solicitudes alcanzado
        if (error.status === 429 || error instanceof RateLimitError) {
          const waitTime = 5 * attempt; // espera creciente (5s, 10s, 15s...)
          console.warn(
            `⚠️ Rate limit alcanzado. Reintentando en ${waitTime} segundos... (intento ${attempt}/${maxRetries})`,
          );
          await new Promise((r) => setTimeout(r, waitTime * 1000));
          continue;
        }

        // Caso: error de red o API
        if (error.code === 'ENOTFOUND' || error.code === 'ECONNRESET') {
          console.error(
            '🌐 Error de red al conectar con OpenAI:',
            error.message,
          );
          await new Promise((r) => setTimeout(r, 3000));
          continue;
        }

        // Cualquier otro error (por ejemplo, clave API inválida)
        console.error('❌ Error al procesar la imagen:', error);
        throw new ServiceUnavailableException(
          `Error al procesar la imagen: ${error.message ?? error}`,
        );
      }
    }

    throw new ServiceUnavailableException(
      'No se pudo procesar la imagen tras varios intentos (Rate limit persistente)',
    );
  }
}
