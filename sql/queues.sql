INSERT INTO queues (
    name,
    strategy,
    joinempty,
    leavewhenempty,
    ringinuse,
    autofill,
    musiconhold,
    monitor_format,
    monitor_type
)
VALUES
('sales'  ,'rrmemory','unavailable,invalid,unknown','unavailable,invalid,unknown','no','yes','default','wav','MixMonitor'),
('support','rrmemory','unavailable,invalid,unknown','unavailable,invalid,unknown','no','yes','default','wav','MixMonitor');

-- SELECT name, strategy, joinempty, leavewhenempty, ringinuse, autofill, musiconhold, monitor_format, monitor_type, timeout FROM queues