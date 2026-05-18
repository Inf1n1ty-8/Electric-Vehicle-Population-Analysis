# SQL Query Outputs

This file summarizes the main results from the SQL Server analysis.

The cleaned electric vehicle dataset was imported into SQL Server as the table:

`dbo.ev_population`

The queries were written and tested in SQL Server Management Studio.

---

## 1. Dataset Overview

The first query checks the size of the dataset and counts the number of unique manufacturers, models, counties, cities, and EV types.

This gives a quick check that the imported table looks complete before doing deeper analysis.

---

## 2. Top EV Manufacturers

The manufacturer-level query shows which EV brands appear most often in the Washington State registered EV population.

Tesla appears as the leading manufacturer in the dataset, followed by other major EV and hybrid vehicle brands.

---

## 3. Top EV Models

The model-level query gives more detail than manufacturer-level analysis.

This helps identify which specific vehicle models are most common, not just which brands are most common.

---

## 4. BEV vs PHEV Split

The EV type query compares:

- Battery Electric Vehicles
- Plug-in Hybrid Electric Vehicles

This helps show whether fully electric vehicles or plug-in hybrids are more common in the registered EV population.

---

## 5. Model Year Trend

The model year query shows how EV counts vary by vehicle model year.

Model year is not the same as registration year, so I do not treat this as a direct yearly sales trend.  
Still, it gives a useful view of how newer EV models appear in the current registered vehicle population.

---

## 6. County and City Patterns

The location queries show that EV registrations are concentrated in certain counties and cities.

This suggests that EV population is not evenly distributed across Washington State.

---

## 7. Electric Range by Manufacturer

The range query excludes records where electric range is zero.

This is important because zero values may mean that range data is missing or not reported, not that the vehicle has zero range.

Only manufacturers with at least 100 vehicles are included to avoid unstable averages from very small groups.

---

## 8. CAFV Eligibility

The CAFV eligibility query summarizes how many vehicles fall into each clean-fuel eligibility category.

This gives an additional policy-related view of the EV population.

---

## 9. EV Type Split in Top Counties

This query combines county and EV type.

It helps compare whether top EV counties have more Battery Electric Vehicles or Plug-in Hybrid Electric Vehicles.

---

## Main Takeaways

- The EV population is concentrated among a small number of major manufacturers.
- Battery Electric Vehicles appear more frequently than Plug-in Hybrid Electric Vehicles.
- EV registrations are concentrated in specific counties and cities.
- Recent model years have much higher EV counts than older model years.
- SQL Server is useful for quickly answering business-style questions from the cleaned dataset.