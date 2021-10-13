

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE public.shifts DISABLE TRIGGER ALL;

INSERT INTO public.shifts (id, name, start, shift_interval, duration) VALUES ('50476fe9-6378-44f0-8af4-313e2f557e7e', 'my super shift', '2021-09-27', 7, 5);


ALTER TABLE public.shifts ENABLE TRIGGER ALL;


ALTER TABLE public.users DISABLE TRIGGER ALL;



ALTER TABLE public.users ENABLE TRIGGER ALL;


ALTER TABLE public.departments DISABLE TRIGGER ALL;



ALTER TABLE public.departments ENABLE TRIGGER ALL;


ALTER TABLE public.registrations DISABLE TRIGGER ALL;

INSERT INTO public.registrations (id, user_id, shift_id, start, stop) VALUES ('e12fc3e7-753f-45b2-bd7b-4842e55af1b5', 'fbf964fd-8f50-4b3a-9fb5-3e880f348f69', '50476fe9-6378-44f0-8af4-313e2f557e7e', '2021-10-05 00:00:00+03', NULL);
INSERT INTO public.registrations (id, user_id, shift_id, start, stop) VALUES ('0919e5bf-019e-4986-9480-e3cbdeffaad0', 'fbf964fd-8f50-4b3a-9fb5-3e880f348f69', '50476fe9-6378-44f0-8af4-313e2f557e7e', '2021-10-05 18:36:14.157139+03', NULL);


ALTER TABLE public.registrations ENABLE TRIGGER ALL;


ALTER TABLE public.vacations DISABLE TRIGGER ALL;



ALTER TABLE public.vacations ENABLE TRIGGER ALL;


