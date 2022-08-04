import * as express from 'express';

import { addTeamRoutes } from './app/teams';

const app = express();
app.use(express.json());

app.get('/api', (req, res) => {
  res.send({ message: 'Welcome to api!' });
});

addTeamRoutes(app);

const port = process.env.port || 3333;
const server = app.listen(port, () => {
  console.log(`Listening at http://localhost:${port}/api`);
});
server.on('error', console.error);

export { app };
