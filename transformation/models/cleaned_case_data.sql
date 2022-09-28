select
    "timestamp",
    "event",
    "reference",
    "deadline",
    "DateReceived"
from case_data
where
    "event" = 'CASE_CREATED' or "event" = 'CASE_COMPLETED'