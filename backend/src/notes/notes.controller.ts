import {
  Body,
  Res,
  Controller,
  HttpStatus,
  Headers,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  Req,
  UseGuards,
} from '@nestjs/common';
import { NotesService } from './notes.service';
import { Response } from 'express';
import { CreateNotesDto } from './dto/create-notes.dto';
import { UpdateNotesDto } from './dto/update-notes.dto';
import { JwtAuthGuard } from 'src/auth/auth.guard';
import { AuthService } from 'src/auth/auth.service';

@Controller('notes')
export class NotesController {
  constructor(private readonly notesService: NotesService) {}

  //create notes by users

  @UseGuards(JwtAuthGuard)
  @Post()
  async create(
    @Body() createNoteDto: CreateNotesDto,
    @Headers() headers: any,
    @Res() res: Response,
  ) {
    try {
      const createdNote = await this.notesService.create(
        createNoteDto,
        headers,
      );
      return res.status(HttpStatus.CREATED).json({
        id: createdNote.notesid,
        title: createdNote.title,
        content: createdNote.content,
        userId: createdNote.userId,
        index: createdNote.index,
        createdAt: createdNote.createdAt,
        updatedAt: createdNote.updatedAt,
      });
    } catch (error) {
      return res.status(HttpStatus.INTERNAL_SERVER_ERROR).json({
        message: 'Failed to create note',
        error: error.message,
      });
    }
  }

  //Delete notes By Id
  @UseGuards(JwtAuthGuard)
  @Delete(':id')
  remove(@Param('id') id: string, @Req() req: any) {
    return this.notesService.remove(id, req.headers['user-id']);
  }

  //findnotes get
  // @UseGuards(JwtAuthGuard)
  // @Get(':id')
  // findById(@Param('id') id: string, @Req() req: any) {
  //   return this.notesService.findById(id, req.headers['user-id']);
  // }

  @UseGuards(JwtAuthGuard)
  @Get(':id')
  findById(@Param('id') id: string, @Headers() headers: any) {
    return this.notesService.findById(id, headers['user-id']);
  }

  //find all notes from my data base by user id
  @UseGuards(JwtAuthGuard)
  @Get()
  findAll(@Req() req: any) {
    return this.notesService.findAll(req.headers['user-id']);
  }

  //editing notes
  @UseGuards(JwtAuthGuard)
  @Patch(':id')
  update(
    @Body() updateNoteDto: UpdateNotesDto,
    @Param('id') id: string,
    @Req() req: any,
  ) {
    return this.notesService.update(id, updateNoteDto, req.headers['user-id']);
  }
}
