

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

INSERT INTO public.shifts (id, name, start, shift_interval, duration) VALUES ('bcbdc770-9dee-47a8-83b4-fd46539cc25d', 'oeu', '1858-11-17', 7, 5);


ALTER TABLE public.shifts ENABLE TRIGGER ALL;


ALTER TABLE public.users DISABLE TRIGGER ALL;

INSERT INTO public.users (id, name, email, password_hash, failed_login_attempts, locked_at, user_role, shift_id) VALUES ('efa583a2-fc6f-42b7-bc5e-e12e010f405f', 'admin', 'spaubleit@protonmail.com', 'sha256|17|7/1ZwBH7Zf2NzHVJjTJKIA==|bcQ+80T1Kwgo6xlTn4+l2ozrN9uj1iARih77JlCErto=', 0, NULL, 'superadmin', NULL);
INSERT INTO public.users (id, name, email, password_hash, failed_login_attempts, locked_at, user_role, shift_id) VALUES ('6aaddc7e-5e9c-4809-98e2-6410bec7474f', 'Вася', 'vasya@gmail.com', 'sha256|17|cd6QtGaTicyh96kKr3+Yxw==|clM5C4GUq3JZScibVXRcZVsGdbAHB7gMdHZpTVwinms=', 0, NULL, 'worker', NULL);


ALTER TABLE public.users ENABLE TRIGGER ALL;


