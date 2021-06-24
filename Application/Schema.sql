-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TYPE roles AS ENUM ('superadmin', 'boss', 'worker', 'visitor');
CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    name TEXT DEFAULT '' NOT NULL,
    email TEXT NOT NULL,
    password_hash TEXT NOT NULL,
    failed_login_attempts INT DEFAULT 0 NOT NULL,
    locked_at TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    user_role roles DEFAULT 'visitor' NOT NULL,
    shift_id UUID
);
CREATE TABLE shifts (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    name TEXT DEFAULT '' NOT NULL,
    "start" DATE NOT NULL,
    shift_interval INT DEFAULT 7 NOT NULL,
    duration INT DEFAULT 5 NOT NULL
);
CREATE INDEX users_shift_id_index ON users (shift_id);
CREATE TYPE weekdays AS ENUM ('week_monday', 'week_tuesday', 'week_wednesday', 'week_thurstday', 'week_friday', 'week_saturday', 'week_sunday');
CREATE TABLE registrations (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    user_id UUID NOT NULL,
    shift_id UUID NOT NULL,
    "start" DATE NOT NULL,
    stop DATE DEFAULT NULL
);
CREATE INDEX registrations_user_id_index ON registrations (user_id);
CREATE INDEX registrations_shift_id_index ON registrations (shift_id);
ALTER TABLE registrations ADD CONSTRAINT registrations_ref_shift_id FOREIGN KEY (shift_id) REFERENCES shifts (id) ON DELETE NO ACTION;
ALTER TABLE registrations ADD CONSTRAINT registrations_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
ALTER TABLE users ADD CONSTRAINT users_ref_shift_id FOREIGN KEY (shift_id) REFERENCES shifts (id) ON DELETE NO ACTION;
