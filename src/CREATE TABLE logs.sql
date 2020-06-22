grafana=# CREATE TABLE public.logs(
log_id serial,
datetime timestamp,
slave_name varchar(20),
master_name varchar(20),
district_name varchar(20),
water_amount integer,
CONSTRAINT log_pkey PRIMARY KEY (log_id)
);