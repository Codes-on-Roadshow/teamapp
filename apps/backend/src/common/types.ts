export interface Team {
  name: string;
  members?: User[];
}

export interface User {
  name: string;
}

export type Pair = [User, User?];
