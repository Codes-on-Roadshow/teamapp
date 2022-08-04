import * as request from 'supertest';

import { app } from '../src/main';

const requestWithSupertest = request(app);

describe('GET teams', () => {
  it('should respond with an array of teams', async () => {
    const response = await requestWithSupertest.get('/api/teams');

    expect(response.body).toEqual([{ name: 'Team 1' }, { name: 'Team 2' }]);
    expect(response.statusCode).toBe(200);
  });
});

describe('POST teams', () => {
  it('should add new team', async () => {
    const newTeam = { name: 'new team' };
    const response = await requestWithSupertest
      .post('/api/teams')
      .send(newTeam);

    expect(response.body).toEqual(newTeam);
    expect(response.statusCode).toBe(201);
  });
});
