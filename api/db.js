const sqlite3 = require('sqlite3').verbose();

const db = new sqlite3.Database('DataBase.db', (err) => {
    if (err) {
        console.error('Error opening database:', err.message);
    } else {
        console.log('Connected to the database DataBase.db.');
    }
});



// Login reference 
db.run(`CREATE TABLE IF NOT EXISTS Login(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT,
    password TEXT,
    type TEXT,
    active TEXT DEFAULT "pending"
)`)

//Traveller reference 
db.run(`CREATE TABLE IF NOT EXISTS Traveller(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  login_id INTEGER,
  name TEXT,
  place TEXT,
  post TEXT,
  phone INTEGER,
  email TEXT,
  image_file TEXT,
  document_file TEXT,
  FOREIGN KEY (login_id) REFERENCES Login(id)
)`);


//Local Guide reference 
db.run(`CREATE TABLE IF NOT EXISTS Local_Guide(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  login_id INTEGER,
  name TEXT,
  place TEXT,
  phone INTEGER,
  email TEXT,
  image_file TEXT,
  document TEXT,
  FOREIGN KEY (login_id) REFERENCES Login(id)
)`)

// Request reference 
db.run(`CREATE TABLE IF NOT EXISTS Request(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  local_guide_id INTEGER,
  traveller_id INTEGER,
  pickuplocation TEXT,
  contact TEXT,
  request TEXT DEFAULT "active",
  date DATE,
  FOREIGN KEY (local_guide_id) REFERENCES Local_Guide(id),
  FOREIGN KEY (traveller_id) REFERENCES Traveller(id)
)`);

// Payment reference
db.run(`CREATE TABLE IF NOT EXISTS Payment(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  amount INTEGER,
  date TEXT,
  status TEXT  DEFAULT "pending",
  traveller_id INTEGER,
  local_guide_id INTEGER,
  trip_id INTEGER,
  FOREIGN KEY (traveller_id) REFERENCES Traveller(id),
  FOREIGN KEY (local_guide_id) REFERENCES Local_Guide(id),
  FOREIGN KEY (trip_id) REFERENCES Request(id)
)`);

// App rating reference 
db.run(`CREATE TABLE IF NOT EXISTS App_Rating(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  login_id INTEGER,
  rating REAL,
  date DATE,
  FOREIGN KEY (login_id) REFERENCES Login(id)
)`);

// Local guide rating reference 
db.run(`CREATE TABLE IF NOT EXISTS Local_Guide_Rating(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  traveller_id INTEGER,
  local_guide_id INTEGER,
  rating REAL,
  date TEXT,
  FOREIGN KEY (traveller_id) REFERENCES Traveller(id),
  FOREIGN KEY (local_guide_id) REFERENCES Local_Guide(id)
)`);

//Local guide vehicle reference 
db.run(`CREATE TABLE IF NOT EXISTS Vehicle_Details(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  vehicle_type TEXT,
  vehicle_model TEXT,
  vehicle_image_one TEXT,
  vehicle_image_two TEXT,
  local_guide_id INTEGER,
  FOREIGN KEY (local_guide_id) REFERENCES Local_Guide(id)
)`);

//Language reference 
db.run(`CREATE TABLE IF NOT EXISTS Language(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  local_guide_id INTEGER,
  language TEXT,
  FOREIGN KEY (local_guide_id) REFERENCES Local_Guide(id)
)`);

//Report localguide refernce 
db.run(`CREATE TABLE IF NOT EXISTS Report_local_guide(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  local_guide_id INTEGER,
  traveller_id INTEGER,
  report TEXT,
  date TEXT,
  FOREIGN KEY (local_guide_id) REFERENCES Local_Guide(id),
  FOREIGN KEY (traveller_id) REFERENCES Traveller(id)
)`);

db.run(`CREATE TABLE IF NOT EXISTS Message(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  sender_id INTEGER,
  reciver_id INTEGER,
  date TEXT,
  message TEXT
)`)

module.exports = db;