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
    shift_id UUID,
    department_id UUID
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
    "start" TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    stop TIMESTAMP WITH TIME ZONE,
    "day" DATE NOT NULL
);
CREATE INDEX registrations_user_id_index ON registrations (user_id);
CREATE INDEX registrations_shift_id_index ON registrations (shift_id);
CREATE TABLE departments (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    manager_id UUID NOT NULL
);
CREATE TABLE vacations (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    user_id UUID NOT NULL,
    "start" DATE NOT NULL,
    stop DATE NOT NULL
);
CREATE INDEX vacations_user_id_index ON vacations (user_id);
CREATE INDEX users_department_id_index ON users (department_id);
CREATE TYPE replacement_states AS ENUM ('replacement_request', 'replacement_approved');
CREATE TABLE replacements (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    replacable_id UUID NOT NULL,
    substitute_id UUID NOT NULL,
    date DATE DEFAULT NOW() NOT NULL,
    state replacement_states NOT NULL
);
ALTER TABLE departments ADD CONSTRAINT departments_ref_manager_id FOREIGN KEY (manager_id) REFERENCES users (id) ON DELETE NO ACTION;
ALTER TABLE registrations ADD CONSTRAINT registrations_ref_shift_id FOREIGN KEY (shift_id) REFERENCES shifts (id) ON DELETE NO ACTION;
ALTER TABLE registrations ADD CONSTRAINT registrations_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
ALTER TABLE replacements ADD CONSTRAINT replacements_ref_replacable_id FOREIGN KEY (replacable_id) REFERENCES users (id) ON DELETE NO ACTION;
ALTER TABLE replacements ADD CONSTRAINT replacements_ref_substitute_id FOREIGN KEY (substitute_id) REFERENCES users (id) ON DELETE NO ACTION;
ALTER TABLE users ADD CONSTRAINT users_ref_department_id FOREIGN KEY (department_id) REFERENCES departments (id) ON DELETE NO ACTION;
ALTER TABLE users ADD CONSTRAINT users_ref_shift_id FOREIGN KEY (shift_id) REFERENCES shifts (id) ON DELETE NO ACTION;
ALTER TABLE vacations ADD CONSTRAINT vacations_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
