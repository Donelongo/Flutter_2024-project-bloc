import { Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { UsersService } from 'src/users/users.service';
import * as bcrypt from 'bcrypt';
import { jwtConstants } from './constants';

@Injectable()
export class AuthService {
  constructor(
    private readonly usersService: UsersService,
    private readonly jwtService: JwtService,
  ) {}

  async generateJwtToken(user: any): Promise<string> {
    const payload = { id: user._id, role: user.role }; // Ensure _id is used if Mongoose
    return this.jwtService.signAsync(payload, { secret: jwtConstants.secret });
  }

  async validateUser(email: string, password: string): Promise<any> {
    const user = await this.usersService.findByEmail(email);
    console.log(user.username)
    if (!user) {
      throw new UnauthorizedException('Incorrect email');
    }
    const passwordMatches = await bcrypt.compare(password, user.password);
    if (!passwordMatches) {
      throw new UnauthorizedException('Incorrect password');
    }
    return user;
  }

  //: { id: user._id, email: user.email, role: user.role }

  async login(email: string, password: string): Promise<any> {
    const user = await this.validateUser(email, password);
    if (user) {
      const access_token = await this.generateJwtToken(user);
      return { access_token, user }; // Ensure _id is used if Mongoose
    } else {
      throw new UnauthorizedException('Invalid credentials');
    }
  }

  async validateToken(request: any): Promise<boolean> {
    const bearerToken = request.headers.authorization;
    if (!bearerToken) {
      throw new UnauthorizedException('Authorization header not found');
    }
    const token = bearerToken.replace('Bearer ', '');
    try {
      const decoded = this.jwtService.verify(token, {
        secret: jwtConstants.secret,
      });
      const { id, role } = decoded;
      // Here you should find the user by id and attach it to the request
      const user = await this.usersService.findOne(id);
      if (!user) {
        throw new UnauthorizedException('User not found');
      }
      request.user = user;
      return true;
    } catch (error) {
      throw new UnauthorizedException('Invalid token');
    }
  }
}
