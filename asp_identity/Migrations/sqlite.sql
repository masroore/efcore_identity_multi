CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory"
(
    "MigrationId"
    TEXT
    NOT
    NULL
    CONSTRAINT
    "PK___EFMigrationsHistory"
    PRIMARY
    KEY,
    "ProductVersion"
    TEXT
    NOT
    NULL
);

BEGIN
TRANSACTION;

CREATE TABLE "roles"
(
    "id"                INTEGER NOT NULL
        CONSTRAINT "pk_roles" PRIMARY KEY AUTOINCREMENT,
    "name"              TEXT NULL,
    "normalized_name"   TEXT NULL,
    "concurrency_stamp" TEXT NULL
);

CREATE TABLE "users"
(
    "id"                     INTEGER NOT NULL
        CONSTRAINT "pk_users" PRIMARY KEY AUTOINCREMENT,
    "first_name"             varchar(100) NULL,
    "last_name"              varchar(100) NULL,
    "is_active"              INTEGER NOT NULL,
    "created_on"             TEXT    NOT NULL,
    "modified_on"            TEXT NULL,
    "inactive_date_time"     TEXT NULL,
    "user_name"              TEXT NULL,
    "normalized_user_name"   TEXT NULL,
    "email"                  TEXT NULL,
    "normalized_email"       TEXT NULL,
    "email_confirmed"        INTEGER NOT NULL,
    "password_hash"          TEXT NULL,
    "security_stamp"         TEXT NULL,
    "concurrency_stamp"      TEXT NULL,
    "phone_number"           TEXT NULL,
    "phone_number_confirmed" INTEGER NOT NULL,
    "two_factor_enabled"     INTEGER NOT NULL,
    "lockout_end"            TEXT NULL,
    "lockout_enabled"        INTEGER NOT NULL,
    "access_failed_count"    INTEGER NOT NULL
);

CREATE TABLE "role_claims"
(
    "id"          INTEGER NOT NULL
        CONSTRAINT "pk_role_claims" PRIMARY KEY AUTOINCREMENT,
    "role_id"     INTEGER NOT NULL,
    "claim_type"  TEXT NULL,
    "claim_value" TEXT NULL,
    CONSTRAINT "fk_role_claims_roles_role_id" FOREIGN KEY ("role_id") REFERENCES "roles" ("id") ON DELETE CASCADE
);

CREATE TABLE "user_claims"
(
    "id"          INTEGER NOT NULL
        CONSTRAINT "pk_user_claims" PRIMARY KEY AUTOINCREMENT,
    "user_id"     INTEGER NOT NULL,
    "claim_type"  TEXT NULL,
    "claim_value" TEXT NULL,
    CONSTRAINT "fk_user_claims_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE
);

CREATE TABLE "user_logins"
(
    "login_provider"        TEXT    NOT NULL,
    "provider_key"          TEXT    NOT NULL,
    "provider_display_name" TEXT NULL,
    "user_id"               INTEGER NOT NULL,
    CONSTRAINT "pk_user_logins" PRIMARY KEY ("login_provider", "provider_key"),
    CONSTRAINT "fk_user_logins_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE
);

CREATE TABLE "user_roles"
(
    "user_id" INTEGER NOT NULL,
    "role_id" INTEGER NOT NULL,
    CONSTRAINT "pk_user_roles" PRIMARY KEY ("user_id", "role_id"),
    CONSTRAINT "fk_user_roles_roles_role_id" FOREIGN KEY ("role_id") REFERENCES "roles" ("id") ON DELETE CASCADE,
    CONSTRAINT "fk_user_roles_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE
);

CREATE TABLE "user_tokens"
(
    "user_id"        INTEGER NOT NULL,
    "login_provider" TEXT    NOT NULL,
    "name"           TEXT    NOT NULL,
    "value"          TEXT NULL,
    CONSTRAINT "pk_user_tokens" PRIMARY KEY ("user_id", "login_provider", "name"),
    CONSTRAINT "fk_user_tokens_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE
);

CREATE INDEX "ix_role_claims_role_id" ON "role_claims" ("role_id");

CREATE UNIQUE INDEX "ak_roles_normalized_name" ON "roles" ("normalized_name");

CREATE INDEX "ix_user_claims_user_id" ON "user_claims" ("user_id");

CREATE INDEX "ix_user_logins_user_id" ON "user_logins" ("user_id");

CREATE INDEX "ix_user_roles_role_id" ON "user_roles" ("role_id");

CREATE UNIQUE INDEX "ak_users_normalized_user_name" ON "users" ("normalized_user_name");

CREATE INDEX "ix_users_normalized_email" ON "users" ("normalized_email");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20230225164634_identity', '7.0.3');

COMMIT;

