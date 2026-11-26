-- PyroNova real-data schema (MySQL 8 / MariaDB 10.5+). Run this, then import seed/*.csv (see README.md).
SET NAMES utf8mb4;
CREATE TABLE investigations (
  id VARCHAR(16) PRIMARY KEY,            -- PSI accession, e.g. PSI-26
  acronym VARCHAR(64) NULL, title TEXT, sub_area VARCHAR(255) NULL, platform VARCHAR(255) NULL,
  hardware TEXT NULL, center VARCHAR(255) NULL, start_date DATE NULL, end_date DATE NULL,
  doi VARCHAR(64) NULL, related TEXT NULL, total_gb DECIMAL(10,2) NULL, files_listed INT NULL,
  tabular_files INT NULL, publications_count INT NULL, objective MEDIUMTEXT NULL, approach MEDIUMTEXT NULL,
  hypothesis MEDIUMTEXT NULL, earth_benefits MEDIUMTEXT NULL, url VARCHAR(512) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
CREATE TABLE publications (
  id INT PRIMARY KEY, investigation_id VARCHAR(16) NOT NULL, title TEXT, authors TEXT NULL, doi VARCHAR(128) NULL,
  KEY idx_pub_inv (investigation_id), CONSTRAINT fk_pub_inv FOREIGN KEY (investigation_id) REFERENCES investigations(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
CREATE TABLE bass_tests (                 -- BASS (PSI-26), 130 flight tests
  id INT PRIMARY KEY, investigation_id VARCHAR(16) NOT NULL, date DATE NULL, test_no INT NULL,
  material VARCHAR(255) NULL, igniter VARCHAR(255) NULL, flow_restrictor DOUBLE NULL,
  o2_pct DOUBLE NULL, pressure_atm DOUBLE NULL, co2_mmhg VARCHAR(32) NULL, observations TEXT NULL,
  ignited TINYINT(1) NOT NULL DEFAULT 0, spread TINYINT(1) NOT NULL DEFAULT 0, extinguished TINYINT(1) NOT NULL DEFAULT 0, -- keyword-derived, approximate
  KEY idx_bass_inv (investigation_id), CONSTRAINT fk_bass_inv FOREIGN KEY (investigation_id) REFERENCES investigations(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
CREATE TABLE bass2_tests (                -- BASS-II (PSI-25), 129 tests
  id INT PRIMARY KEY, investigation_id VARCHAR(16) NOT NULL, investigator VARCHAR(128) NULL, date DATE NULL,
  test_no VARCHAR(32) NULL, sample_no VARCHAR(32) NULL, material VARCHAR(255) NULL, flow_restrictor VARCHAR(32) NULL,
  o2_initial_pct DOUBLE NULL, o2_final_pct DOUBLE NULL, co2_initial_pct DOUBLE NULL, co2_final_pct DOUBLE NULL,
  co_initial_ppm DOUBLE NULL, co_final_ppm DOUBLE NULL,
  KEY idx_bass2_inv (investigation_id), CONSTRAINT fk_bass2_inv FOREIGN KEY (investigation_id) REFERENCES investigations(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
CREATE TABLE saffire3_telemetry (         -- Saffire-III (PSI-100), 1 sample/s
  id INT PRIMARY KEY, investigation_id VARCHAR(16) NOT NULL,
  radiometer1 DOUBLE, radiometer2 DOUBLE, radiometer3 DOUBLE, radiometer4 DOUBLE, airflow1 DOUBLE, airflow2 DOUBLE,
  fan_rpm_raw DOUBLE, temperature_c DOUBLE, pressure_signal DOUBLE,
  smoke_f1_obscuration DOUBLE, smoke_f2_obscuration DOUBLE, smoke_f1_scatter DOUBLE, smoke_f2_scatter DOUBLE,
  igniter1_current DOUBLE, igniter2_current DOUBLE, igniter3_current DOUBLE, igniter4_current DOUBLE, igniter5_current DOUBLE,
  igniter6_current DOUBLE, igniter7_current DOUBLE, igniter8_current DOUBLE, igniter9_current DOUBLE,
  t_s DOUBLE NOT NULL, igniter_on TINYINT(1) NOT NULL DEFAULT 0, smoke_flag TINYINT(1) NOT NULL DEFAULT 0, is_baseline TINYINT(1) NOT NULL DEFAULT 0,
  KEY idx_tel_t (t_s), KEY idx_tel_inv (investigation_id), CONSTRAINT fk_tel_inv FOREIGN KEY (investigation_id) REFERENCES investigations(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
CREATE TABLE rag_documents (              -- one text chunk per investigation/publication list/dataset summary, for the AI
  id VARCHAR(64) PRIMARY KEY, source_type VARCHAR(32) NOT NULL, investigation_id VARCHAR(16) NULL,
  title TEXT, text MEDIUMTEXT NOT NULL, source_url VARCHAR(512) NULL, doi VARCHAR(64) NULL,
  KEY idx_rag_inv (investigation_id), KEY idx_rag_type (source_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
