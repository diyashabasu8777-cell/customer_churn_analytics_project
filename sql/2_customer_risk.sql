-- Customer-level risk views for BI/campaign analysis.
USE telco_churn;

CREATE OR REPLACE VIEW customer_risk_base AS
SELECT
    *,
    CASE
        WHEN tenure <= 6 THEN '0-6'
        WHEN tenure <= 12 THEN '7-12'
        WHEN tenure <= 24 THEN '13-24'
        WHEN tenure <= 48 THEN '25-48'
        ELSE '49+'
    END AS tenure_band,

    CASE
        WHEN Churn = 'Yes' THEN 1
        ELSE 0
    END AS churn_flag

FROM telco_customer_churn;
SELECT Contract, tenure_band, COUNT(*) customers, AVG(churn_flag) churn_rate, AVG(MonthlyCharges) avg_monthly_charge
FROM customer_risk_base GROUP BY Contract, tenure_band ORDER BY churn_rate DESC;

SELECT customerID, Contract, tenure, MonthlyCharges, TotalCharges, Churn
FROM customer_risk_base
WHERE Churn='Yes' OR (Contract='Month-to-month' AND tenure<=12)
ORDER BY MonthlyCharges DESC;
