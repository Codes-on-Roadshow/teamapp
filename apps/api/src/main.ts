import * as express from 'express';

import { addPairRoutes } from './app/pairs';
import { addTeamRoutes } from './app/teams';
import { addUserRoutes } from './app/users';

export const app = express();

app.use(express.json());
app.get('/api', (_, res) => {
  res.send({ message: 'Welcome to TeamApp!' });
});

addTeamRoutes(app);
addUserRoutes(app);
addPairRoutes(app);
