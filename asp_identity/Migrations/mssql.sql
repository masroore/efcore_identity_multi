IF
OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
CREATE TABLE [__EFMigrationsHistory]
(
    [
    MigrationId] nvarchar
(
    150
) NOT NULL,
    [ProductVersion] nvarchar
(
    32
) NOT NULL,
    CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY
(
[
    MigrationId]
)
    );
END;
GO

BEGIN
TRANSACTION;
GO

CREATE TABLE [roles]
(
    [
    id]
    bigint
    NOT
    NULL
    IDENTITY, [
    name]
    nvarchar
(
    256
) NULL,
    [normalized_name] nvarchar
(
    256
) NULL,
    [concurrency_stamp] nvarchar
(
    max
) NULL,
    CONSTRAINT [pk_roles] PRIMARY KEY
(
[
    id]
)
    );
GO

CREATE TABLE [users]
(
    [
    id]
    bigint
    NOT
    NULL
    IDENTITY, [
    first_name]
    varchar
(
    100
) NULL,
    [last_name] varchar
(
    100
) NULL,
    [is_active] bit NOT NULL,
    [created_on] datetime2 NOT NULL,
    [modified_on] datetime2 NULL,
    [inactive_date_time] datetime2 NULL,
    [user_name] nvarchar
(
    256
) NULL,
    [normalized_user_name] nvarchar
(
    256
) NULL,
    [email] nvarchar
(
    256
) NULL,
    [normalized_email] nvarchar
(
    256
) NULL,
    [email_confirmed] bit NOT NULL,
    [password_hash] nvarchar
(
    max
) NULL,
    [security_stamp] nvarchar
(
    max
) NULL,
    [concurrency_stamp] nvarchar
(
    max
) NULL,
    [phone_number] nvarchar
(
    max
) NULL,
    [phone_number_confirmed] bit NOT NULL,
    [two_factor_enabled] bit NOT NULL,
    [lockout_end] datetimeoffset NULL,
    [lockout_enabled] bit NOT NULL,
    [access_failed_count] int NOT NULL,
    CONSTRAINT [pk_users] PRIMARY KEY
(
[
    id]
)
    );
GO

CREATE TABLE [role_claims]
(
    [
    id]
    int
    NOT
    NULL
    IDENTITY, [
    role_id]
    bigint
    NOT
    NULL, [
    claim_type]
    nvarchar
(
    max
) NULL,
    [claim_value] nvarchar
(
    max
) NULL,
    CONSTRAINT [pk_role_claims] PRIMARY KEY
(
[
    id]
),
    CONSTRAINT [fk_role_claims_roles_role_id] FOREIGN KEY
(
[
    role_id]
) REFERENCES [roles]
(
[
    id]
) ON DELETE CASCADE
    );
GO

CREATE TABLE [user_claims]
(
    [
    id]
    int
    NOT
    NULL
    IDENTITY, [
    user_id]
    bigint
    NOT
    NULL, [
    claim_type]
    nvarchar
(
    max
) NULL,
    [claim_value] nvarchar
(
    max
) NULL,
    CONSTRAINT [pk_user_claims] PRIMARY KEY
(
[
    id]
),
    CONSTRAINT [fk_user_claims_users_user_id] FOREIGN KEY
(
[
    user_id]
) REFERENCES [users]
(
[
    id]
) ON DELETE CASCADE
    );
GO

CREATE TABLE [user_logins]
(
    [
    login_provider] nvarchar
(
    450
) NOT NULL,
    [provider_key] nvarchar
(
    450
) NOT NULL,
    [provider_display_name] nvarchar
(
    max
) NULL,
    [user_id] bigint NOT NULL,
    CONSTRAINT [pk_user_logins] PRIMARY KEY
(
    [
    login_provider],
[
    provider_key]
),
    CONSTRAINT [fk_user_logins_users_user_id] FOREIGN KEY
(
[
    user_id]
) REFERENCES [users]
(
[
    id]
) ON DELETE CASCADE
    );
GO

CREATE TABLE [user_roles]
(
    [
    user_id]
    bigint
    NOT
    NULL, [
    role_id]
    bigint
    NOT
    NULL,
    CONSTRAINT [
    pk_user_roles]
    PRIMARY
    KEY (
    [
    user_id],
[
    role_id]
),
    CONSTRAINT [fk_user_roles_roles_role_id] FOREIGN KEY
(
[
    role_id]
) REFERENCES [roles]
(
[
    id]
) ON DELETE CASCADE,
    CONSTRAINT [fk_user_roles_users_user_id] FOREIGN KEY
(
[
    user_id]
) REFERENCES [users]
(
[
    id]
)
  ON DELETE CASCADE
    );
GO

CREATE TABLE [user_tokens]
(
    [
    user_id]
    bigint
    NOT
    NULL, [
    login_provider]
    nvarchar
(
    450
) NOT NULL,
    [name] nvarchar
(
    450
) NOT NULL,
    [value] nvarchar
(
    max
) NULL,
    CONSTRAINT [pk_user_tokens] PRIMARY KEY
(
    [
    user_id], [
    login_provider],
[
    name]
),
    CONSTRAINT [fk_user_tokens_users_user_id] FOREIGN KEY
(
[
    user_id]
) REFERENCES [users]
(
[
    id]
) ON DELETE CASCADE
    );
GO

CREATE INDEX [ix_role_claims_role_id] ON [role_claims] ([role_id]);
GO

CREATE UNIQUE INDEX [ak_roles_normalized_name] ON [roles] ([normalized_name]) WHERE [normalized_name] IS NOT NULL;
GO

CREATE INDEX [ix_user_claims_user_id] ON [user_claims] ([user_id]);
GO

CREATE INDEX [ix_user_logins_user_id] ON [user_logins] ([user_id]);
GO

CREATE INDEX [ix_user_roles_role_id] ON [user_roles] ([role_id]);
GO

CREATE UNIQUE INDEX [ak_users_normalized_user_name] ON [users] ([normalized_user_name]) WHERE [normalized_user_name] IS NOT NULL;
GO

CREATE INDEX [ix_users_normalized_email] ON [users] ([normalized_email]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20230225164235_identity', N'7.0.3');
GO

COMMIT;
GO

