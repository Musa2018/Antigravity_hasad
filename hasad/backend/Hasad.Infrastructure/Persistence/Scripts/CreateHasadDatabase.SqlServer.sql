/*
    Hasad database bootstrap script for Microsoft SQL Server.

    Creates the `hasad` database and all objects required by the Hasad backend
    (ASP.NET Core Identity tables + RefreshTokens), mirroring the EF Core
    InitialCreate migration (20260706200907_InitialCreate).

    Types are translated from the PostgreSQL migration to their SQL Server
    equivalents (text -> nvarchar, boolean -> bit, uuid -> uniqueidentifier,
    timestamp with time zone -> datetimeoffset). Key/indexed string columns use
    nvarchar(450) because SQL Server cannot key or index nvarchar(max).

    The script is idempotent: it can be run multiple times safely.
*/

/* 1. Create the database if it does not already exist. */
IF DB_ID(N'hasad') IS NULL
BEGIN
    CREATE DATABASE [hasad];
END;
GO

USE [hasad];
GO

SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO

/* 2. EF Core migrations history (so tooling recognises the applied schema). */
IF OBJECT_ID(N'[dbo].[__EFMigrationsHistory]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[__EFMigrationsHistory] (
        [MigrationId]    nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32)  NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

/* 3. Identity: Roles */
IF OBJECT_ID(N'[dbo].[AspNetRoles]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[AspNetRoles] (
        [Id]               nvarchar(450)  NOT NULL,
        [Name]             nvarchar(256)  NULL,
        [NormalizedName]   nvarchar(256)  NULL,
        [ConcurrencyStamp] nvarchar(max)  NULL,
        CONSTRAINT [PK_AspNetRoles] PRIMARY KEY ([Id])
    );
END;
GO

/* 4. Identity: Users */
IF OBJECT_ID(N'[dbo].[AspNetUsers]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[AspNetUsers] (
        [Id]                   nvarchar(450)  NOT NULL,
        [FullName]             nvarchar(max)  NOT NULL,
        [UserName]             nvarchar(256)  NULL,
        [NormalizedUserName]   nvarchar(256)  NULL,
        [Email]                nvarchar(256)  NULL,
        [NormalizedEmail]      nvarchar(256)  NULL,
        [EmailConfirmed]       bit            NOT NULL,
        [PasswordHash]         nvarchar(max)  NULL,
        [SecurityStamp]        nvarchar(max)  NULL,
        [ConcurrencyStamp]     nvarchar(max)  NULL,
        [PhoneNumber]          nvarchar(max)  NULL,
        [PhoneNumberConfirmed] bit            NOT NULL,
        [TwoFactorEnabled]     bit            NOT NULL,
        [LockoutEnd]           datetimeoffset NULL,
        [LockoutEnabled]       bit            NOT NULL,
        [AccessFailedCount]    int            NOT NULL,
        CONSTRAINT [PK_AspNetUsers] PRIMARY KEY ([Id])
    );
END;
GO

/* 5. RefreshTokens */
IF OBJECT_ID(N'[dbo].[RefreshTokens]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[RefreshTokens] (
        [Id]                  uniqueidentifier NOT NULL,
        [TokenHash]           nvarchar(64)     NOT NULL,
        [UserId]              nvarchar(450)    NOT NULL,
        [FamilyId]            uniqueidentifier NOT NULL,
        [ExpiresAtUtc]        datetimeoffset   NOT NULL,
        [CreatedAtUtc]        datetimeoffset   NOT NULL,
        [RevokedAtUtc]        datetimeoffset   NULL,
        [ReplacedByTokenHash] nvarchar(max)    NULL,
        CONSTRAINT [PK_RefreshTokens] PRIMARY KEY ([Id])
    );
END;
GO

/* 6. Identity: Role claims */
IF OBJECT_ID(N'[dbo].[AspNetRoleClaims]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[AspNetRoleClaims] (
        [Id]         int           NOT NULL IDENTITY(1,1),
        [RoleId]     nvarchar(450) NOT NULL,
        [ClaimType]  nvarchar(max) NULL,
        [ClaimValue] nvarchar(max) NULL,
        CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY ([RoleId])
            REFERENCES [dbo].[AspNetRoles] ([Id]) ON DELETE CASCADE
    );
END;
GO

/* 7. Identity: User claims */
IF OBJECT_ID(N'[dbo].[AspNetUserClaims]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[AspNetUserClaims] (
        [Id]         int           NOT NULL IDENTITY(1,1),
        [UserId]     nvarchar(450) NOT NULL,
        [ClaimType]  nvarchar(max) NULL,
        [ClaimValue] nvarchar(max) NULL,
        CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY ([UserId])
            REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE
    );
END;
GO

/* 8. Identity: User logins */
IF OBJECT_ID(N'[dbo].[AspNetUserLogins]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[AspNetUserLogins] (
        [LoginProvider]       nvarchar(450) NOT NULL,
        [ProviderKey]         nvarchar(450) NOT NULL,
        [ProviderDisplayName] nvarchar(max) NULL,
        [UserId]              nvarchar(450) NOT NULL,
        CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY ([LoginProvider], [ProviderKey]),
        CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY ([UserId])
            REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE
    );
END;
GO

/* 9. Identity: User roles */
IF OBJECT_ID(N'[dbo].[AspNetUserRoles]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[AspNetUserRoles] (
        [UserId] nvarchar(450) NOT NULL,
        [RoleId] nvarchar(450) NOT NULL,
        CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY ([UserId], [RoleId]),
        CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY ([RoleId])
            REFERENCES [dbo].[AspNetRoles] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY ([UserId])
            REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE
    );
END;
GO

/* 10. Identity: User tokens */
IF OBJECT_ID(N'[dbo].[AspNetUserTokens]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[AspNetUserTokens] (
        [UserId]        nvarchar(450) NOT NULL,
        [LoginProvider] nvarchar(450) NOT NULL,
        [Name]          nvarchar(450) NOT NULL,
        [Value]         nvarchar(max) NULL,
        CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY ([UserId], [LoginProvider], [Name]),
        CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY ([UserId])
            REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE
    );
END;
GO

/* 11. Indexes */
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_AspNetRoleClaims_RoleId' AND object_id = OBJECT_ID(N'[dbo].[AspNetRoleClaims]'))
    CREATE INDEX [IX_AspNetRoleClaims_RoleId] ON [dbo].[AspNetRoleClaims] ([RoleId]);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'RoleNameIndex' AND object_id = OBJECT_ID(N'[dbo].[AspNetRoles]'))
    CREATE UNIQUE INDEX [RoleNameIndex] ON [dbo].[AspNetRoles] ([NormalizedName]) WHERE [NormalizedName] IS NOT NULL;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_AspNetUserClaims_UserId' AND object_id = OBJECT_ID(N'[dbo].[AspNetUserClaims]'))
    CREATE INDEX [IX_AspNetUserClaims_UserId] ON [dbo].[AspNetUserClaims] ([UserId]);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_AspNetUserLogins_UserId' AND object_id = OBJECT_ID(N'[dbo].[AspNetUserLogins]'))
    CREATE INDEX [IX_AspNetUserLogins_UserId] ON [dbo].[AspNetUserLogins] ([UserId]);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_AspNetUserRoles_RoleId' AND object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]'))
    CREATE INDEX [IX_AspNetUserRoles_RoleId] ON [dbo].[AspNetUserRoles] ([RoleId]);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'EmailIndex' AND object_id = OBJECT_ID(N'[dbo].[AspNetUsers]'))
    CREATE INDEX [EmailIndex] ON [dbo].[AspNetUsers] ([NormalizedEmail]);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'UserNameIndex' AND object_id = OBJECT_ID(N'[dbo].[AspNetUsers]'))
    CREATE UNIQUE INDEX [UserNameIndex] ON [dbo].[AspNetUsers] ([NormalizedUserName]) WHERE [NormalizedUserName] IS NOT NULL;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_RefreshTokens_TokenHash' AND object_id = OBJECT_ID(N'[dbo].[RefreshTokens]'))
    CREATE UNIQUE INDEX [IX_RefreshTokens_TokenHash] ON [dbo].[RefreshTokens] ([TokenHash]);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_RefreshTokens_UserId_FamilyId' AND object_id = OBJECT_ID(N'[dbo].[RefreshTokens]'))
    CREATE INDEX [IX_RefreshTokens_UserId_FamilyId] ON [dbo].[RefreshTokens] ([UserId], [FamilyId]);
GO

/* 12. Record the migration as applied. */
IF NOT EXISTS (SELECT 1 FROM [dbo].[__EFMigrationsHistory] WHERE [MigrationId] = N'20260706200907_InitialCreate')
    INSERT INTO [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260706200907_InitialCreate', N'8.0.0');
GO
