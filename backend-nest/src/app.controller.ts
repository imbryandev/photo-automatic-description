import {
  BadRequestException,
  Controller,
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
  async describeImage(
    @UploadedFile() file: Express.Multer.File,
  ): Promise<DescribeResponse> {
    if (!file) throw new BadRequestException('No file uploaded');

    try {
      return await this.appService.describeImage(file);
    } catch (e) {
      throw new BadRequestException(`Error processing image: ${e}`);
    }
  }
}
