import { Role } from "src/auth /roles/roles.enum";

export interface IUser {
  id: string;
  email: string;
  passwordHash: string;
  username: string;
  role: Role;
  avatarUrl?: string;
  refresh_token?: string;
}
