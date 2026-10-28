# Maji Ndogo Water Services Database Analysis

SQL analysis of water access, infrastructure bottlenecks and water quality across the communities of Maji Ndogo, using a relational MySQL database of water sources, field visits, pollution tests and employee records.

## Overview

The database covers **39,650 water sources** serving **27.6 million people**, recorded across **60,146 field visits** between January 2021 and July 2023 in **25 towns**. The queries in this repository answer four operational questions:

1. How many people depend on each type of water source?
2. Which wells are contaminated?
3. Where do people wait longest for water?
4. How is field-survey work distributed across employees?

## Key findings

### 1. Shared taps carry the most people, and broken taps are a repair opportunity

| Source type | Sources | People served |
|---|---:|---:|
| Shared tap | 5,767 | 11,945,272 |
| Well | 17,383 | 4,841,724 |
| Tap in home | 7,265 | 4,678,880 |
| Tap in home (broken) | 5,856 | 3,799,720 |
| River | 3,379 | 2,362,544 |

- Shared taps serve about **11.9 million people** (43% of the total), more than any other source type.
- About **3.8 million people** depend on indoor taps that are broken (`tap_in_home_broken`). Repairing existing plumbing is likely to cost less than building new infrastructure, although this analysis does not include cost data.

### 2. Most wells are contaminated

- **71.35% of tested wells (12,403 of 17,383)** are recorded as contaminated: 5,310 biological and 7,093 chemical.
- These wells serve about **3.5 million people (3,455,322)**. The 4.8 million figure is the population of *all* wells, contaminated or not.
- 64 wells are recorded as `Clean` but show bacterial contamination in their description or biological reading. Counting them would raise the contamination rate slightly (about 71.7%), so the results column should be audited.

### 3. Shared taps have very long queues

- Shared taps average **136.9 minutes** per visit, against 17.0 minutes at rivers. Wells and home taps record no queue time.
- The longest recorded wait is **539 minutes (about 9 hours)**, found in rural locations. Zuri has the highest town average (118.5 minutes) and a maximum of 537 minutes. Bello is next at 95.8 minutes.

### 4. Rural communities carry most of the load

- **63.9%** of the population (17.6 million people) is served by rural sources, against 10.0 million in urban areas.
- The largest rural populations are in **Akatsi (4.6 million)**, **Kilimani (4.1 million)** and **Sokoto (4.0 million)**.
- Of the 5,767 shared taps, 4,330 (75%) are in rural locations.

### 5. Field-staff workload is uneven

- 56 employees are recorded. The most active surveyors, **Bello Azibo (3,708 visits)** and **Pili Zola (3,676 visits)**, each covered all 25 towns.
- Some employees recorded very few visits (for example, 15 visits for Kunto Asha), which points to gaps in how fieldwork is tracked and assigned.

## Repository contents

| File | Description |
|---|---|
| `md_water_services.sql` | Full MySQL dump of the `md_water_services` database (schema and data). |
| `Total_Population_Served_by_Water_Source_Type.sql` | Total people served per source type. |
| `Identify_Contaminated_Wells.sql` | Wells with biological contamination or pollutant levels above 0.5 ppm. Returns the same 12,403 wells as the recorded results. |
| `Average_Queue_Time_by_Town.sql` | Average queue time per town, longest first. |
| `Employee_Workload_Analysis.sql` | Number of visits per employee, most active first. |
| `LICENSE.txt` | MIT License. |

## Database structure

| Table | Purpose |
|---|---|
| `water_source` | One row per source: type and number of people served. |
| `location` | Address, province, town and urban or rural type for each location. |
| `visits` | Field visits, with queue time, location, source and assigned employee. |
| `well_pollution` | Test results for wells: pollutant ppm, biological reading and result. |
| `water_quality` | Subjective quality score for each visit. |
| `employee` | Field staff and their positions. |
| `global_water_access` | Regional water access statistics. |
| `data_dictionary` | Column descriptions for the tables above. |

The queries use joins and aggregations across `water_source`, `visits`, `location`, `well_pollution` and `employee`.

## Getting started

Requires MySQL 8.0 or later.

```bash
# Load the database (this drops and recreates md_water_services)
mysql -u <user> -p < md_water_services.sql

# Run an analysis query
mysql -u <user> -p md_water_services < Average_Queue_Time_by_Town.sql
```

You can also open the `.sql` files in MySQL Workbench and run them against the `md_water_services` database.

## Recommendations

1. **Treat or replace contaminated wells.** Prioritise filtration, treatment or safe boreholes for the roughly 3.5 million people served by contaminated wells, starting with biological contamination.
2. **Repair broken indoor taps.** This restores service to about 3.8 million people and reduces pressure on shared taps.
3. **Reduce queues at shared taps.** Add tap heads or sources in the towns with the longest waits, starting with Zuri and Bello, and in rural areas where waits of up to 9 hours were recorded.
4. **Focus rural investment.** Rural provinces, led by Akatsi, Kilimani and Sokoto, hold most of the affected population.
5. **Review fieldwork tracking.** Check employee visit assignments and audit the 64 wells whose recorded result does not match their readings.

## License

Released under the [MIT License](LICENSE.txt).

## Author

Mark Gichuhi Gichohi
