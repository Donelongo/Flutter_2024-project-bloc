// // Import the necessary packages and your service
// import { Test, TestingModule } from '@nestjs/testing';
// import { AdminService } from './admin.service';

// describe('AdminService', () => {
//   let service: AdminService;

//   beforeEach(async () => {
//     const module: TestingModule = await Test.createTestingModule({
//       providers: [AdminService],
//     }).compile();

//     service = module.get<AdminService>(AdminService);
//   });

//   it('should return all users with their notes', async () => {
//     const result = await service.getAllUsersWithNotes();
//     expect(result).toBeDefined();
//     expect(result).toBeInstanceOf(Object);
//   });
// });