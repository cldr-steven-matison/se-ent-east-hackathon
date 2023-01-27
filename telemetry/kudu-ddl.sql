-- DDL script for creating tables in Kudu needed for telemetry and 
-- insured driver data.

drop table if exists default.tm_events_raw;
-- Real-time telemetry events.
CREATE TABLE default.tm_events_raw (
  tm_event_id	BIGINT COMMENT 'Unique telemetry event ID',  
  driver_id	INT COMMENT 'Unique ID for an insured driver',
  trip_num BIGINT COMMENT 'Vehicle trip number',
  speed	INT COMMENT 'Speed (MPH)',  
  lat_accel FLOAT COMMENT 'Lateral acceleration (m/s^2)',
  long_accel FLOAT COMMENT 'Longitudinal acceleration (m/s^2)',
  throttle_pos FLOAT COMMENT 'Throttle position (%)',
  brake_press FLOAT COMMENT 'Brake pressure (bar)',
  steer_ang FLOAT COMMENT 'Steering angle (deg)',
  steer_ang_rate FLOAT COMMENT 'Steering angle rate (deg/s)',
  tm_event_dt STRING COMMENT 'Event datetime in format: MM-dd-yyyy hh:mm:ss a',
  ts_timestamp BIGINT COMMENT 'Randomized timestamp across timespan',
  primary key(tm_event_id)
)
PARTITION BY HASH PARTITIONS 16
STORED AS KUDU;

drop table if exists default.insured_drivers;
-- Insured drivers to be monitored for telemetry.
CREATE TABLE default.insured_drivers
(
  driver_id INT COMMENT 'Unique identifier for an insured driver',
  policy_number STRING COMMENT 'The 10-digit insurance policy number',
  first_name STRING COMMENT 'The first name of the insured driver',
  last_name STRING COMMENT 'The last name of the insured driver',
  vin STRING COMMENT 'The unique Vehicle Identification Number (VIN) for the insured vehicle',
  gender STRING COMMENT 'The gender of the driver',
  vehicle_make STRING COMMENT 'The make of the vehicle',
  vehicle_model STRING COMMENT 'The model of the vehicle',
  vehicle_year INT COMMENT 'The year of the vehicle',
  primary key (driver_id)
)
partition by hash partitions 16
stored as kudu;