import {
  CanActivate,
  ExecutionContext,
  ForbiddenException,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { ROLES_KEY } from './roles.decorator';
import { Role } from './roles.enum';

@Injectable()
export class RolesGuard implements CanActivate {
  constructor(private reflector: Reflector) {}

  canActivate(context: ExecutionContext): boolean {
    const requiredRoles = this.reflector.getAllAndOverride<Role[]>(ROLES_KEY, [
      context.getHandler(),
      context.getClass(),
    ]);

    if (!requiredRoles) {
      return true;
    }
    const { user } = context.switchToHttp().getRequest();
    if (!user) {
      throw new UnauthorizedException('User not authentificated');
    }

    if (!this.hasRole(user.role, requiredRoles)) {
      throw new ForbiddenException(
        `User with role ${user.role} does not have required permissions`,
      );
    }
    return true;
  }

  private hasRole(userRole: Role, requiredRoles: Role[]): boolean {
    return requiredRoles.some((role) => role === userRole);
  }
}
