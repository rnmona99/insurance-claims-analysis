CREATE TABLE members (
  member_id SERIAL PRIMARY KEY,
  national_id TEXT UNIQUE,
  full_name TEXT NOT NULL,
  gender TEXT CHECK (gender IN ('F','M')),
  date_of_birth DATE,
  region TEXT,
  plan_name TEXT,
  policy_start_date DATE
);
CREATE TABLE providers (
  provider_id SERIAL PRIMARY KEY,
  provider_name TEXT NOT NULL,
  provider_type TEXT CHECK (provider_type IN ('Hospital','Clinic','Pharmacy')),
  city TEXT,
  region TEXT
);
CREATE TABLE procedures (
  procedure_code TEXT PRIMARY KEY,
  procedure_desc TEXT NOT NULL,
  specialty TEXT,
  requires_preauth BOOLEAN DEFAULT false
);
CREATE TABLE claims (
  claim_id SERIAL PRIMARY KEY,
  member_id INT REFERENCES members(member_id),
  provider_id INT REFERENCES providers(provider_id),
  claim_date DATE,
  claim_type TEXT CHECK (claim_type IN ('Inpatient','Outpatient','Pharmacy')),
  status TEXT CHECK (status IN ('Submitted','Approved','Denied','Pending')),
  total_claimed_amount NUMERIC(12,2),
  total_approved_amount NUMERIC(12,2),
  denial_reason TEXT
);
CREATE TABLE claim_lines (
  claim_line_id SERIAL PRIMARY KEY,
  claim_id INT REFERENCES claims(claim_id),
  procedure_code TEXT REFERENCES procedures(procedure_code),
  quantity INT,
  unit_price NUMERIC(12,2),
  line_approved_amount NUMERIC(12,2),
  line_status TEXT
);
CREATE TABLE preauth_requests (
  preauth_id SERIAL PRIMARY KEY,
  member_id INT REFERENCES members(member_id),
  provider_id INT REFERENCES providers(provider_id),
  procedure_code TEXT REFERENCES procedures(procedure_code),
  requested_date DATE,
  decision TEXT,
  decision_date DATE
);
\dt;
