-- Drop existing payslips table if exists
DROP TABLE IF EXISTS payslips;

-- Create payslips table
CREATE TABLE IF NOT EXISTS payslips (
  payslip_id VARCHAR(20) PRIMARY KEY,
  employee_id TEXT NOT NULL,
  employee_name TEXT NOT NULL,
  employee_email TEXT NOT NULL,
  month_year TEXT NOT NULL,
  designation TEXT NOT NULL,
  office_location TEXT NOT NULL,
  employment_type TEXT NOT NULL,
  date_of_joining DATE NOT NULL,
  working_days INTEGER NOT NULL,
  bank_name TEXT NOT NULL,
  pan_no TEXT NOT NULL,
  bank_account_no TEXT NOT NULL,
  pf_no TEXT NOT NULL,
  uan_no TEXT NOT NULL,
  esic_no TEXT NOT NULL,
  basic_salary DECIMAL(10,2) NOT NULL,
  hra DECIMAL(10,2) NOT NULL,
  other_allowance DECIMAL(10,2) NOT NULL,
  professional_tax DECIMAL(10,2) NOT NULL,
  tds DECIMAL(10,2) NOT NULL,
  provident_fund DECIMAL(10,2) NOT NULL,
  lwp DECIMAL(10,2) NOT NULL,
  other_deduction DECIMAL(10,2),
  net_salary DECIMAL(10,2) NOT NULL,
  status TEXT NOT NULL DEFAULT 'Generated',
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  CONSTRAINT unique_employee_month_year UNIQUE (employee_id, month_year)
);

-- Create or replace function to update 'updated_at' timestamp
CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at := NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Drop trigger if already exists
DROP TRIGGER IF EXISTS update_payslips_timestamp ON payslips;

-- Create trigger to automatically update 'updated_at' before update
CREATE TRIGGER update_payslips_timestamp
BEFORE UPDATE ON payslips
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();
