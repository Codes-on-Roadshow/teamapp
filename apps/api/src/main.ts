import * as express from 'express';

import { addPairRoutes } from './app/pairs';
import { addTeamRoutes } from './app/teams';
import { addUserRoutes } from './app/users';

const app = express();
app.use(express.json());

app.get('/api', (_, res) => {
  res.send({ message: 'Welcome to TeamApp!' });
});

addTeamRoutes(app);
addUserRoutes(app);
addPairRoutes(app);

const port = process.env.port || 3333;

if (process.env.NODE_ENV !== 'test') {
  const server = app.listen(port, () => {
    console.log(`Listening at http://localhost:${port}/api`);
  });
  server.on('error', console.error);
}

export { app };
