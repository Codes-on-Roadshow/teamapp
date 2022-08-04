import * as request from 'supertest';

import { app } from '../src/main';

const requestWithSupertest = request(app);

describe('GET pairs', () => {
  it('should respond with an array of pairs', async () => {
    const response = await requestWithSupertest.get('/api/pairs');

    expect(response.body).toEqual([
      [{ name: 'Kinan' }, { name: 'Aris' }],
      [{ name: 'Lydia' }, { name: 'Aris' }],
    ]);
    expect(response.statusCode).toBe(200);
  });
});

describe('POST pairs', () => {
  it('should add new pair', async () => {
    const newPair = [{ name: 'Kinan' }, { name: 'Lydia' }];
    const response = await requestWithSupertest
      .post('/api/pairs')
      .send(newPair);

    expect(response.body).toEqual(newPair);
    expect(response.statusCode).toBe(201);
  });
  
  it('should add new solo pair', async () => {
    const newPair = [{ name: 'Kinan' }];
    const response = await requestWithSupertest
      .post('/api/pairs')
      .send(newPair);

    expect(response.body).toEqual(newPair);
    expect(response.statusCode).toBe(201);
  });
});
