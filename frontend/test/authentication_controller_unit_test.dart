// // Import the necessary packages and your controller
// import { Test, TestingModule } from '@nestjs/testing';
// import { AuthController } from './auth.controller';
// import { AuthService } from './auth.service';

// describe('AuthController', () => {
//   let controller: AuthController;
//   let authService: AuthService;

//   beforeEach(async () => {
//     authService = { login: jest.fn(), validateUser: jest.fn() } as any;

//     const module: TestingModule = await Test.createTestingModule({
//       controllers: [AuthController],
//       providers: [
//         { provide: AuthService, useValue: authService },
//       ],
//     }).compile();

//     controller = module.get<AuthController>(AuthController);
//   });

//   it('should login a user', async () => {
//     const dto = { username: 'test', password: 'test' };
//     (authService.login as jest.Mock).mockResolvedValue('test-token');

//     expect(await controller.login(dto, {}, {})).toBe('test-token');
//     expect(authService.login).toHaveBeenCalledWith(dto.username, dto.password);
//   });
// });