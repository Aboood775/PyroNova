# PyroNova dashboard data

Source: NASA Physical Sciences Informatics (PSI), https://psi.nasa.gov.
This is archived data, NOT live telemetry. Every file is a JSON array
unless noted. `null` means the value is missing in the source.
PSI asks users to cite investigations by DOI: use the `doi` field.

## Files
| File | Rows | Use |
|---|---|---|
| campaigns.json | 24 | Experiment catalog + detail panel |
| summary.json | object | Top cards |
| publications.json | 352 | Source explorer |
| bass_tests.json | 130 | BASS test table / charts |
| bass_by_material.json | 8 | Bar chart by material |
| saffire3_timeline.json | ~575 | SAFFIRE-III smoke timeline |
| psi159_experiments.json | 179 | Gaseous flames (ACME CFI-G) |

## Keys
- campaigns: id, name, title, category, platform, start_year, end_year,
  publications_count, doi, url, summary, objective, source
- publications: id, investigation_id (= campaigns.id), title, authors, doi
- summary: investigations, publications, ground_and_flight_tests,
  year_range, source
- bass_tests: id, test_no, date, material, material_group, o2_pct,
  pressure_atm, ignited, spread, extinguished, ignition_inconsistent,
  observations
- bass_by_material: material_group, tests, ignited, spread, extinguished
- saffire3_timeline: t_s, smoke_f2_obscuration, smoke_f2_scatter,
  smoke_flag, igniter_on
- psi159_experiments: investigation_id, experiment_id, test_date, fuel,
  oxygen_before_pct, oxygen_after_pct, pressure_kpa, fuel_flow_mg_s,
  adiabatic_temp_k, hot_ignition, burn_time_s, end_mode,
  peak_burner_temp_c, cool_flame, comments (and a few more)

## Things to know
1. category is assigned by the team (not in the source). Values: Gaseous
   flames, Liquid droplets, Large-scale, Smoke & aerosols, Ground tests,
   Solid materials, Other. "Smoke & aerosols" is not in the current
   design filters: add it, or show it under All.
2. start_year / end_year null = not stated. It does NOT mean the
   investigation is still running.
3. campaigns.summary is the start of the official objective text, not an
   AI-written summary. Label it "Objective", or generate it with the LLM.
4. 68 publications have doi = null: show them without a link.
5. BASS: ignited / spread / extinguished are 0/1 as in the source.
   ignition_inconsistent = true for 5 tests (ignited 0 but spread 1).
   Mark them or leave them out of the ignition-to-spread chart and show
   how many were left out. o2_pct is null in 7 tests. material_group
   "Sphere (material not stated)" was not assumed to be PMMA.
6. SAFFIRE-III timeline: t_s is seconds, 12 s buckets (mean for signals,
   max for flags). Units are not given in the source: label the axis
   "raw signal (unit not stated)".
7. PSI-159: 179 tests, only 7 with cool_flame = true. adiabatic_temp_k is
   probably calculated, not measured. test_date is derived from the test
   ID. There is no risk score in this data. Empty (null) burn_time_s,
   end_mode "none" and peak_burner_temp_c mean no ignition.
8. Numbers in the design that are not backed by data: "7 Active",
   "1420+ Research Hours", "98% Safety Index", "LIVE TELEMETRY".
   Suggested: 24 investigations, 352 publications, years 1999-2025,
   "ARCHIVED DATA".