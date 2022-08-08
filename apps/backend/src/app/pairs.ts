import { Express } from 'express';

import { Pair } from '../common/types';

const pairs: Pair[] = [
  [{ name: 'Kinan' }, { name: 'Aris' }],
  [{ name: 'Lydia' }, { name: 'Aris' }],
];

export function addPairRoutes(app: Express) {
  app.get('/api/pairs', (_, resp) => resp.send(pairs));

  app.post('/api/pairs', (req, resp) => {
    const newPair = req.body;
    pairs.push(newPair);
    resp.status(201).send(newPair);
  });
}
