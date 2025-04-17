# Medicare Inpatient Claims SQL Analysis

A SQL-based data project analyzing U.S. Medicare inpatient hospital claims to identify high-cost provider outliers and investigate reimbursement inefficiencies. This analysis simulates a consulting-style deep dive using real CMS data.

## 📊 Project Objective

To uncover hospitals with Medicare reimbursement significantly above the national average, understand the underlying cost drivers, and recommend follow-up areas for efficiency improvement or audit.

## 🧠 Key Insights

- **9 hospitals** were identified with average Medicare payment per discharge more than **2x the national average**
- **Burke Medical Center** stood out with:
  - Only **88 total discharges**
  - An average **$116K Medicare payment per discharge**
  - A **low chronic disease burden (0.87)** — suggesting high cost **not driven by patient complexity**
  - A **cost per covered day of $43,446**, indicating extreme pricing intensity
- Discrepancy between **charges vs actual payments** highlights potential overbilling or DRG coding review opportunities

## 🧾 SQL Queries Included

All queries are modular and located in [`/queries`](./queries/):

- `01_high_cost_outliers.sql` – Identifies top hospitals by Medicare payment per discharge and investigates Burke Medical Center in detail

## 🛠️ Tools Used

- SQL (MySQL Workbench)
- CMS Medicare Inpatient Public Use File (PUF)
- Mac OS + VS Code

## 📁 Dataset

Original dataset available at:  
[CMS Medicare Inpatient Hospitals by Provider – Data Source](https://data.cms.gov/resources/medicare-inpatient-hospitals-by-provider-data-dictionary)

> A sample data file is included for testing (`sample_data.csv`). All data used is public and HIPAA-compliant.

## 📌 Author

Built by [Your Name] as part of a personal analytics + strategy portfolio.
