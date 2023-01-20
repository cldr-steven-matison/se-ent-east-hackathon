-- Used for streaming generated telemetry data directly into Kudu from Streaming SQL Console.
INSERT INTO `nirchi-kudu`.`default_database`.`default.tm_events_raw`
SELECT 
  tm_event_id,
  driver_id,
  trip_num,
  speed,
  lat_accel,
  long_accel,
  throttle_pos,
  brake_press,
  steer_ang,
  steer_ang_rate,
  ts_timestamp
FROM ssc_tm_events_raw;