import * as request from 'supertest';

import { app } from '../src/main';

const requestWithSupertest = request(app);

describe('GET users', () => {
  it('should respond with an array of users', async () => {
    const response = await requestWithSupertest.get('/api/users');

    expect(response.body).toEqual([{ name: 'Kinan' }, { name: 'Aris' }]);
    expect(response.statusCode).toBe(200);
  });
});

describe('POST users', () => {
  it('should add new user', async () => {
    const newUser = { name: 'Lydia' };
    const response = await requestWithSupertest
      .post('/api/users')
      .send(newUser);

    expect(response.body).toEqual(newUser);
    expect(response.statusCode).toBe(201);
  });
});
