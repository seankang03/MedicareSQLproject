USE MedicareInpatientHospital;

-- Medicare Inpatient Analysis: High-Cost Provider Outliers & Deep Dive on Burke Medical Center
-- Author: Sean Kang
-- Date: 2025-04-17

-- Note: Replace `mih1` with your actual table name if different
-- ---------------------------------------------------------------

-- 1. Calculate national average Medicare payment per discharge
SELECT 
  ROUND(SUM(Tot_Mdcr_Pymt_Amt) / SUM(Tot_Dschrgs), 2) AS national_avg_payment
FROM mih1;


-- 2. Identify top 10 hospitals with highest avg Medicare payment per discharge (min 50 discharges)
SELECT 
  Rndrng_Prvdr_Org_Name AS hospital_name,
  SUM(Tot_Dschrgs) AS total_discharges,
  ROUND(SUM(Tot_Mdcr_Pymt_Amt), 2) AS total_medicare_payment,
  ROUND(SUM(Tot_Mdcr_Pymt_Amt) / SUM(Tot_Dschrgs), 2) AS avg_payment_per_discharge
FROM mih1
GROUP BY Rndrng_Prvdr_Org_Name
HAVING SUM(Tot_Dschrgs) > 50
ORDER BY avg_payment_per_discharge DESC
LIMIT 10;


-- 3. Analyze chronic condition burden of selected high-cost hospitals
SELECT 
  Rndrng_Prvdr_Org_Name,
  ROUND(AVG(
    Bene_CC_PH_Diabetes_V2_Pct + 
    Bene_CC_PH_CKD_V2_Pct + 
    Bene_CC_PH_COPD_V2_Pct
  ), 3) AS avg_chronic_burden
FROM mih1
WHERE Rndrng_Prvdr_Org_Name IN (
  'Harris Health System', 
  'Burke Medical Center', 
  'Provident Hospital Of Chicago'
)
GROUP BY Rndrng_Prvdr_Org_Name;


-- 4. Deep dive: Check patient volume at Burke Medical Center
SELECT 
  SUM(Tot_Dschrgs) AS total_discharges,
  SUM(Tot_Benes) AS total_unique_patients
FROM mih1
WHERE Rndrng_Prvdr_Org_Name = 'Burke Medical Center';


-- 5. Deep dive: Covered days and avg Medicare cost per day for Burke
SELECT 
  SUM(Tot_Cvrd_Days) AS total_covered_days,
  ROUND(SUM(Tot_Mdcr_Pymt_Amt) / SUM(Tot_Cvrd_Days), 2) AS avg_cost_per_day
FROM mih1
WHERE Rndrng_Prvdr_Org_Name = 'Burke Medical Center';


-- 6. Deep dive: Compare Burke's charges vs actual Medicare payment
SELECT 
  ROUND(SUM(Tot_Submtd_Cvrd_Chrg) / SUM(Tot_Dschrgs), 2) AS avg_charge_per_discharge,
  ROUND(SUM(Tot_Mdcr_Pymt_Amt) / SUM(Tot_Dschrgs), 2) AS avg_payment_per_discharge
FROM mih1
WHERE Rndrng_Prvdr_Org_Name = 'Burke Medical Center';