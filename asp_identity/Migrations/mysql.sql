CREATE TABLE IF NOT EXISTS `__EFMigrationsHistory`
(
    `MigrationId` varchar
(
    150
) NOT NULL,
    `ProductVersion` varchar
(
    32
) NOT NULL,
    PRIMARY KEY
(
    `MigrationId`
)
    );

START TRANSACTION;

CREATE TABLE `roles`
(
    `id`                int unsigned NOT NULL AUTO_INCREMENT,
    `name`              varchar(256) NULL,
    `normalized_name`   varchar(256) NULL,
    `concurrency_stamp` longtext NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `users`
(
    `id`                     int unsigned NOT NULL AUTO_INCREMENT,
    `first_name`             varchar(100) NULL,
    `last_name`              varchar(100) NULL,
    `is_active`              tinyint(1) NOT NULL,
    `created_on`             datetime(6) NOT NULL,
    `modified_on`            datetime(6) NULL,
    `inactive_date_time`     datetime(6) NULL,
    `user_name`              varchar(256) NULL,
    `normalized_user_name`   varchar(256) NULL,
    `email`                  varchar(256) NULL,
    `normalized_email`       varchar(256) NULL,
    `email_confirmed`        tinyint(1) NOT NULL,
    `password_hash`          longtext NULL,
    `security_stamp`         longtext NULL,
    `concurrency_stamp`      longtext NULL,
    `phone_number`           longtext NULL,
    `phone_number_confirmed` tinyint(1) NOT NULL,
    `two_factor_enabled`     tinyint(1) NOT NULL,
    `lockout_end`            datetime(6) NULL,
    `lockout_enabled`        tinyint(1) NOT NULL,
    `access_failed_count`    int NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `role_claims`
(
    `id`          int NOT NULL AUTO_INCREMENT,
    `role_id`     int unsigned NOT NULL,
    `claim_type`  longtext NULL,
    `claim_value` longtext NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_role_claims_roles_role_id` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
);

CREATE TABLE `user_claims`
(
    `id`          int NOT NULL AUTO_INCREMENT,
    `user_id`     int unsigned NOT NULL,
    `claim_type`  longtext NULL,
    `claim_value` longtext NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_user_claims_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
);

CREATE TABLE `user_logins`
(
    `login_provider`        varchar(255) NOT NULL,
    `provider_key`          varchar(255) NOT NULL,
    `provider_display_name` longtext NULL,
    `user_id`               int unsigned NOT NULL,
    PRIMARY KEY (`login_provider`, `provider_key`),
    CONSTRAINT `fk_user_logins_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
);

CREATE TABLE `user_roles`
(
    `user_id` int unsigned NOT NULL,
    `role_id` int unsigned NOT NULL,
    PRIMARY KEY (`user_id`, `role_id`),
    CONSTRAINT `fk_user_roles_roles_role_id` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
    CONSTRAINT `fk_user_roles_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
);

CREATE TABLE `user_tokens`
(
    `user_id`        int unsigned NOT NULL,
    `login_provider` varchar(255) NOT NULL,
    `name`           varchar(255) NOT NULL,
    `value`          longtext NULL,
    PRIMARY KEY (`user_id`, `login_provider`, `name`),
    CONSTRAINT `fk_user_tokens_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
);

CREATE INDEX `ix_role_claims_role_id` ON `role_claims` (`role_id`);

CREATE UNIQUE INDEX `ak_roles_normalized_name` ON `roles` (`normalized_name`);

CREATE INDEX `ix_user_claims_user_id` ON `user_claims` (`user_id`);

CREATE INDEX `ix_user_logins_user_id` ON `user_logins` (`user_id`);

CREATE INDEX `ix_user_roles_role_id` ON `user_roles` (`role_id`);

CREATE UNIQUE INDEX `ak_users_normalized_user_name` ON `users` (`normalized_user_name`);

CREATE INDEX `ix_users_normalized_email` ON `users` (`normalized_email`);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20230225162022_identity', '7.0.3');

COMMIT;

