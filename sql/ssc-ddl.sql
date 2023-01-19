-- Streaming SQL Console (SSC) Virtual Table DDL Script

-- Create virtual table data source for raw telemetry data generation.
CREATE TABLE ssc_tm_events_raw (
 tm_event_id BIGINT,
 msg_type STRING,
 driver_id STRING,
 trip_num BIGINT, 
 speed INT,
 ts_timestamp BIGINT
) WITH (
'connector' = 'ts_gen',
'avro_schema_file_name' = 'telemetry.avro',
'ts_schema_location' = '/tmp',
'avro_schema_location' = '/tmp',
'ts_schema_file_name' = 'telemetry.json'
)