

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



ALTER TABLE public.shifts ENABLE TRIGGER ALL;


ALTER TABLE public.users DISABLE TRIGGER ALL;

INSERT INTO public.users (id, name, email, password_hash, failed_login_attempts, locked_at, user_role, shift_id, department_id) VALUES ('2a11cd30-ae26-4450-a0d2-a0bbe5e2126e', 'admin', 'spaubleit@protonmail.com', 'sha256|17|o1nouCD2hK19tXID/zhUww==|ylXs7bHAAHjTrvP1ctbXH5ydHqBBlaiw40M8Y5rYMX0=', 0, NULL, 'superadmin', NULL, NULL);
INSERT INTO public.users (id, name, email, password_hash, failed_login_attempts, locked_at, user_role, shift_id, department_id) VALUES ('7d2c628e-24ee-48f5-9b8f-1bb8ca1797b7', 'Worker', 'worker@gmail.com', 'sha256|17|i4/mjV6SC6+dCgTgbElioA==|N2lj+fdluN8TAABeeGIHZGElZXDkkVcnufbrOMyetgM=', 0, NULL, 'worker', NULL, NULL);


ALTER TABLE public.users ENABLE TRIGGER ALL;


ALTER TABLE public.departments DISABLE TRIGGER ALL;



ALTER TABLE public.departments ENABLE TRIGGER ALL;


ALTER TABLE public.registrations DISABLE TRIGGER ALL;



ALTER TABLE public.registrations ENABLE TRIGGER ALL;


ALTER TABLE public.replacements DISABLE TRIGGER ALL;

INSERT INTO public.replacements (id, replacable_id, substitute_id, date, state) VALUES ('ea859be4-4ad9-4516-b974-00b4855b1bbe', '2a11cd30-ae26-4450-a0d2-a0bbe5e2126e', '7d2c628e-24ee-48f5-9b8f-1bb8ca1797b7', '2021-10-18', 'replacement_request');


ALTER TABLE public.replacements ENABLE TRIGGER ALL;


ALTER TABLE public.vacations DISABLE TRIGGER ALL;



ALTER TABLE public.vacations ENABLE TRIGGER ALL;


