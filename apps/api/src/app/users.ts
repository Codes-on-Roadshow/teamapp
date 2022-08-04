import { Express } from 'express';

import { User } from '../common/types';

const users: User[] = [{ name: 'Kinan' }, { name: 'Aris' }];

export function addUserRoutes(app: Express) {
  app.get('/api/users', (_, resp) => resp.send(users));

  app.post('/api/users', (req, resp) => {
    const newUser = req.body;
    users.push(newUser);
    resp.status(201).send(newUser);
  });
}
