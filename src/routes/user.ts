import {Router} from 'express';
import { prisma } from '../libs/prisma';
const router:Router = Router();

router.get('/', async (req, res) => {
	const users = await prisma.user.findMany();
	res.json(users);
});

export default router;
