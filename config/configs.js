// Set the connection string based from the config vars of the production server
// To run locally use 'mongodb://localhost/mern-crud' instead of process.env.DB

require('dotenv').config();

module.exports = {
  db: process.env.MONGO_URI
};



// module.exports = {
//   db: 
//   'mongodb+srv://fahadtest:4GcqNZtJMBVu9xv6@fahad-test-clu.gcd2o.mongodb.net/merndb?retryWrites=true&w=majority&appName=fahad-test-clu'
// };