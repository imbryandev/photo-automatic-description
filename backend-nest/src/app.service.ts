import { Injectable } from '@nestjs/common';
import * as dotenv from 'dotenv';
import OpenAI from 'openai';
import { DescribeResponse } from './interfaces/describe-response.interface';
dotenv.config();

@Injectable()
export class AppService {
  private openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });

  async describeImage(file: Express.Multer.File): Promise<DescribeResponse> {
    // Convertimos la imagen a base64
    const base64Image = file.buffer.toString('base64');

    // Llamamos a ChatGPT con visión
    const response = await this.openai.responses.create({
      model: 'gpt-4o-mini',
      input: [
        {
          role: 'user',
          content: [
            { type: 'input_text', text: 'Describe brevemente esta imagen.' },
            {
              type: 'input_image',
              image_url: `data:image/jpeg;base64,${base64Image}`,
              detail: 'auto',
            },
          ],
        },
      ],
    });

    // Retornamos la descripción
    return { description: response.output_text };
  }
}
