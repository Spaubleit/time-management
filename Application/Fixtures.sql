

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

INSERT INTO public.users (id, name, email, password_hash, failed_login_attempts, locked_at, user_role, shift_id, department_id) VALUES ('63eb9af7-6042-425a-9754-2b618e0ca774', 'admin', 'spaubleit@protonmail.com', 'sha256|17|mAXBOgaAFdKwR70WdW+AbQ==|qd01HWuMzYzakFEbvZ5sjqMuL+mGTAuJRMCGqoFmzxw=', 0, NULL, 'superadmin', NULL, NULL);
INSERT INTO public.users (id, name, email, password_hash, failed_login_attempts, locked_at, user_role, shift_id, department_id) VALUES ('63f87688-522b-4621-990f-1a75d42308b7', 'worker', 'worker@gmail.com', 'sha256|17|IJvqe6fGWqMEeZngXsP6uw==|ilQM7btEnqkbOShya7eNctT2uSqpmsAgObPvxN3WM/s=', 0, NULL, 'worker', NULL, NULL);
INSERT INTO public.users (id, name, email, password_hash, failed_login_attempts, locked_at, user_role, shift_id, department_id) VALUES ('2ab97e54-07d7-46ec-971d-9acbc2fad55a', 'boss', 'boss@gmail.com', 'sha256|17|BzTlvoTtNcq13YEpntCFdw==|5ngywNGTHH/buTehwWeY4UXIdnGerF3STwfiMHx0aIg=', 0, NULL, 'boss', NULL, NULL);


ALTER TABLE public.users ENABLE TRIGGER ALL;


ALTER TABLE public.departments DISABLE TRIGGER ALL;

INSERT INTO public.departments (id, name, manager_id) VALUES ('3dafdb7c-2982-4144-b845-2e5ed0502f7a', 'Test department', '2ab97e54-07d7-46ec-971d-9acbc2fad55a');


ALTER TABLE public.departments ENABLE TRIGGER ALL;


ALTER TABLE public.registrations DISABLE TRIGGER ALL;



ALTER TABLE public.registrations ENABLE TRIGGER ALL;


ALTER TABLE public.replacements DISABLE TRIGGER ALL;



ALTER TABLE public.replacements ENABLE TRIGGER ALL;


ALTER TABLE public.vacations DISABLE TRIGGER ALL;



ALTER TABLE public.vacations ENABLE TRIGGER ALL;


