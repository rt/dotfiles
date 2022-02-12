import { run } from './utils';
import UserData from '../src/data/appengine/user';
import User from '../src/models/user';

async function createAdmin() {
    const user = new User({ username: 'admin' });
    user.generatePasswordHash('admin');
    user.roles = ['admin'];
    const createdUser = await UserData.createUser(
        user.username,
        user.passwordHash,
        user.passwordSalt,
        user.roles
    );
}

run(createAdmin);
