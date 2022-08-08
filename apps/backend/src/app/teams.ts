import { Express } from 'express';

import { Team } from '../common/types';

const teams: Team[] = [{ name: 'Team 1' }, { name: 'Team 2' }];

export function addTeamRoutes(app: Express) {
  app.get('/api/teams', (_, resp) => resp.send(teams));

  app.post('/api/teams', (req, resp) => {
    const newTeam = req.body;
    teams.push(newTeam);
    resp.status(201).send(newTeam);
  });
}
