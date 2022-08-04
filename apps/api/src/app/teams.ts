import { Express } from 'express';

interface Teams {
  id: number;
  name: string;
}

const teams: Teams[] = [
  { id: 1, name: 'Team 1' },
  { id: 2, name: 'Team 2' },
];

export function addTeamRoutes(app: Express) {
  app.get('/api/teams', (_, resp) => resp.send(teams));

  app.post('/api/teams', (req, resp) => {    
    const newTeam = req.body;
    teams.push(newTeam);
    resp.status(201).send(newTeam);
  });
}
