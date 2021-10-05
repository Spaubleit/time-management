

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

INSERT INTO public.users (id, name, email, password_hash, failed_login_attempts, locked_at, user_role, shift_id) VALUES ('4c17d7a8-0036-440b-8335-75880bef7192', 'tester', 'test@gmail.com', 'sha256|17|Cf5kW49VebnxbNj/LFVOdA==|zs2ncWFnwwfSW1x6aUP7K0K6O9qePMWL7fQFv9QTTxo=', 0, NULL, 'visitor', NULL);
INSERT INTO public.users (id, name, email, password_hash, failed_login_attempts, locked_at, user_role, shift_id) VALUES ('279201f5-0f2d-439c-aec2-2cb1810752db', 'admin', 'spaubleit@protonmail.com', 'sha256|17|QbcWGvwfSsD7Vt5q9JIE5g==|gG29pAXOwDdVYAxiAAafpgqZSaEgZSCwiyxiqN1nqyM=', 0, NULL, 'superadmin', NULL);
INSERT INTO public.users (id, name, email, password_hash, failed_login_attempts, locked_at, user_role, shift_id) VALUES ('20cd8048-aec6-4fc8-a75a-b8a7c5a0b2c7', 'boss', 'boss@gmail.com', 'sha256|17|M/rz98fDXSw6A7Rn7B1PCA==|6hHPsswhys2QIsj4jwHFzI4lKFO/I1M6c4TRwbZUxtM=', 0, NULL, 'boss', NULL);
INSERT INTO public.users (id, name, email, password_hash, failed_login_attempts, locked_at, user_role, shift_id) VALUES ('fbf964fd-8f50-4b3a-9fb5-3e880f348f69', 'worker', 'worker@gmail.com', 'sha256|17|USEJ8s2N87A4cdtNLo3YWw==|RTK5NfdULnmeuqqQJR7X2+ak6QrclgcrZ2DEQCFnGs0=', 0, NULL, 'worker', '50476fe9-6378-44f0-8af4-313e2f557e7e');


ALTER TABLE public.users ENABLE TRIGGER ALL;


ALTER TABLE public.registrations DISABLE TRIGGER ALL;

INSERT INTO public.registrations (id, user_id, shift_id, start, stop) VALUES ('e12fc3e7-753f-45b2-bd7b-4842e55af1b5', 'fbf964fd-8f50-4b3a-9fb5-3e880f348f69', '50476fe9-6378-44f0-8af4-313e2f557e7e', '2021-10-05 00:00:00+03', NULL);


ALTER TABLE public.registrations ENABLE TRIGGER ALL;


