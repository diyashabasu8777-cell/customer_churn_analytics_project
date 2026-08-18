CREATE DATABASE IF NOT EXISTS telco_churn;
USE telco_churn;
select * from telco_customer_churn;
SELECT COUNT(*) AS total_rows FROM telco_customer_churn;

SELECT COUNT(*) AS total_customers,
       SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned_customers,
       SUM(CASE WHEN Churn='No' THEN 1 ELSE 0 END) AS retained_customers,
       ROUND(100.0*SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS churn_rate_pct
FROM telco_customer_churn;

SELECT Contract, COUNT(*) AS customers,
       SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned_customers,
       ROUND(100.0*SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS churn_rate_pct,
       ROUND(AVG(MonthlyCharges),2) AS avg_monthly_charges
FROM telco_customer_churn
GROUP BY Contract ORDER BY churn_rate_pct DESC;

SELECT InternetService, COUNT(*) AS customers,
       SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned_customers,
       ROUND(100.0*SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS churn_rate_pct
FROM telco_customer_churn
GROUP BY InternetService ORDER BY churn_rate_pct DESC;

SELECT PaymentMethod, COUNT(*) AS customers,
       SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned_customers,
       ROUND(100.0*SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS churn_rate_pct
FROM telco_customer_churn
GROUP BY PaymentMethod ORDER BY churn_rate_pct DESC;

SELECT tenure, COUNT(*) AS customers,
       SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned_customers,
       ROUND(100.0*SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS churn_rate_pct
FROM telco_customer_churn
GROUP BY tenure ORDER BY tenure;

SELECT SeniorCitizen, Partner, Dependents, COUNT(*) AS customers,
       SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned_customers,
       ROUND(100.0*SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS churn_rate_pct
FROM telco_customer_churn
GROUP BY SeniorCitizen, Partner, Dependents
ORDER BY churn_rate_pct DESC;

SELECT Churn, COUNT(*) AS customers,
       ROUND(AVG(MonthlyCharges),2) AS avg_monthly_charges,
       ROUND(MIN(MonthlyCharges),2) AS min_monthly_charges,
       ROUND(MAX(MonthlyCharges),2) AS max_monthly_charges,
       ROUND(AVG(tenure),2) AS avg_tenure
FROM telco_customer_churn
GROUP BY Churn;

SELECT CASE
         WHEN tenure<=6 THEN '0-6 months'
         WHEN tenure<=12 THEN '7-12 months'
         WHEN tenure<=24 THEN '13-24 months'
         WHEN tenure<=48 THEN '25-48 months'
         ELSE '49+ months'
       END AS tenure_band,
       COUNT(*) AS customers,
       SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned_customers,
       ROUND(100.0*SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS churn_rate_pct
FROM telco_customer_churn
GROUP BY tenure_band
ORDER BY FIELD(tenure_band,'0-6 months','7-12 months','13-24 months','25-48 months','49+ months');

SELECT TechSupport, COUNT(*) AS customers,
       ROUND(100.0*SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS churn_rate_pct
FROM telco_customer_churn
GROUP BY TechSupport ORDER BY churn_rate_pct DESC;

SELECT OnlineSecurity, COUNT(*) AS customers,
       ROUND(100.0*SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS churn_rate_pct
FROM telco_customer_churn
GROUP BY OnlineSecurity ORDER BY churn_rate_pct DESC;

SELECT Churn, ROUND(SUM(MonthlyCharges),2) AS monthly_revenue
FROM telco_customer_churn GROUP BY Churn;

SELECT customerID, Contract, tenure, MonthlyCharges, InternetService,
       PaymentMethod, Churn
FROM telco_customer_churn
WHERE Contract='Month-to-month' AND MonthlyCharges>=70 AND tenure<=12
ORDER BY MonthlyCharges DESC, tenure ASC;
