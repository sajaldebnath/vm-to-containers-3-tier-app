db = db.getSiblingDB("employees_DB");

db.employees.createIndex(
  { emp_id: 1 },
  { unique: true }
);

db.employees.createIndex(
  { first_name: 1, last_name: 1 },
  { unique: true }
);
