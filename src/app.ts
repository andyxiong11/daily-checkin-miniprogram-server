import 'dotenv/config'; 
import express from 'express'; 
import cors from 'cors'; 
import routes from './routes';
const app = express(); 
const PORT = process.env.PORT || 3000;  // 在项目根目录的.env加上 PORT=3000
app.use(cors()); 
app.use(express.json());
app.use('/api', routes);
app.get('/', (_req, res) => {   
	res.send('OK'); 
});  
app.listen(PORT, () => {   
	console.log(`Server running on http://localhost:${PORT}`); 
});