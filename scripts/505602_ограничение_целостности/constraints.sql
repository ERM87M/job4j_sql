CREATE TABLE roles (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL CHECK (char_length (name) > 0)
);

CREATE TABLE rules (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL CHECK (char_length (name) > 0)
);

CREATE TABLE roles_rules (
    role_id BIGINT REFERENCES roles(id),
    rule_id BIGINT REFERENCES rules(id),
    PRIMARY KEY(role_id, rule_id)
);

CREATE TABLE users (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    login TEXT NOT NULL UNIQUE,
    email TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL CHECK (char_length (password_hash) > 0),
    active BOOLEAN NOT NULL DEFAULT true,
    role_id BIGINT NOT NULL REFERENCES roles(id)
);

CREATE TABLE states (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL CHECK (char_length (name) > 0)
);

CREATE TABLE categories (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL CHECK (char_length (name) > 0)
);

CREATE TABLE items (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title TEXT NOT NULL CHECK (char_length (title) > 0),
    description TEXT NOT NULL CHECK (char_length (description) > 0),
    author_id BIGINT NOT NULL REFERENCES users(id),
    state_id BIGINT NOT NULL REFERENCES states(id),
    category_id BIGINT NOT NULL REFERENCES categories(id)
);

CREATE TABLE comments (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    comment TEXT NOT NULL CHECK (char_length (comment) > 0),
    author_id BIGINT NOT NULL REFERENCES users(id),
    item_id BIGINT NOT NULL REFERENCES items(id)
);

CREATE TABLE attachs (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    description TEXT NOT NULL CHECK (char_length (description) > 0),
    file_size BIGINT NOT NULL CHECK (file_size > 0),
    item_id BIGINT NOT NULL REFERENCES items(id)
);