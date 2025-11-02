import {
  BadRequestException,
  Controller,
  HttpCode,
  Post,
  UploadedFile,
  UseInterceptors,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { AppService } from './app.service';
import { DescribeResponse } from './interfaces/describe-response.interface';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Post('describe')
  @UseInterceptors(FileInterceptor('file'))
  @HttpCode(200)
  async describeImage(
    @UploadedFile() file: Express.Multer.File,
  ): Promise<DescribeResponse> {
    console.log('Enter describe image endpoint');

    if (!file) throw new BadRequestException('No file uploaded');

    try {
      const description = await this.appService.describeImage(file);
      return description;
    } catch (e) {
      console.error('❌ Error al procesar imagen:', e);
      throw new BadRequestException(`Error processing image: ${e}`);
    }
  }
}
