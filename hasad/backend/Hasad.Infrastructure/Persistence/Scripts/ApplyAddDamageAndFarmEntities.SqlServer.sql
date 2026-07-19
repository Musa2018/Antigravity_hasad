/*
    Hasad database migration script for Microsoft SQL Server.

    Applies the EF Core migration AddDamageAndFarmEntities
    (20260712185848_AddDamageAndFarmEntities) to the `hasad` database,
    creating the 5 business tables (Farmers, Farms, DamageReports,
    DamageItems, DamageReportAttachments) that were added to the model
    after InitialCreate.

    Types are translated from the PostgreSQL migration to their SQL Server
    equivalents (uuid -> uniqueidentifier, numeric(18,2) -> decimal(18,2),
    double precision -> float, timestamp with time zone -> datetime2,
    text -> nvarchar(max), bytea rowversion -> rowversion, bigint -> bigint).

    The script is idempotent: it can be run multiple times safely.
*/

USE [hasad];
GO

SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO

/* 1. Farmers */
IF OBJECT_ID(N'[dbo].[Farmers]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Farmers] (
        [Id]           uniqueidentifier NOT NULL,
        [ClientId]     uniqueidentifier NOT NULL,
        [Name]         nvarchar(200)    NOT NULL,
        [NationalId]   nvarchar(20)     NOT NULL,
        [PhoneNumber]  nvarchar(20)     NOT NULL,
        [Address]      nvarchar(500)    NOT NULL,
        [RowVersion]   rowversion       NOT NULL,
        CONSTRAINT [PK_Farmers] PRIMARY KEY ([Id])
    );
END;
GO

/* 2. Farms */
IF OBJECT_ID(N'[dbo].[Farms]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Farms] (
        [Id]              uniqueidentifier NOT NULL,
        [ClientId]        uniqueidentifier NOT NULL,
        [FarmerId]        uniqueidentifier NOT NULL,
        [Name]            nvarchar(200)    NOT NULL,
        [GovernorateId]   nvarchar(50)     NOT NULL,
        [LocalityId]      nvarchar(50)     NOT NULL,
        [LandArea]        decimal(18,2)    NOT NULL,
        [LandAreaUnit]    nvarchar(20)     NOT NULL,
        [Latitude]        float            NULL,
        [Longitude]       float            NULL,
        [OwnershipTypeId] nvarchar(50)     NOT NULL,
        [CreatedAt]       datetime2        NOT NULL,
        [UpdatedAt]       datetime2        NULL,
        [RowVersion]      rowversion       NOT NULL,
        CONSTRAINT [PK_Farms] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Farms_Farmers_FarmerId] FOREIGN KEY ([FarmerId])
            REFERENCES [dbo].[Farmers] ([Id]) ON DELETE CASCADE
    );
END;
GO

/* 3. DamageReports */
IF OBJECT_ID(N'[dbo].[DamageReports]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[DamageReports] (
        [Id]                uniqueidentifier NOT NULL,
        [ClientId]          uniqueidentifier NOT NULL,
        [FarmId]            uniqueidentifier NOT NULL,
        [FarmerId]          uniqueidentifier NOT NULL,
        [DamageDate]        datetime2        NOT NULL,
        [DocumentationDate] datetime2        NOT NULL,
        [GovernorateId]     nvarchar(50)     NOT NULL,
        [LocalityId]        nvarchar(50)     NOT NULL,
        [Latitude]          float            NULL,
        [Longitude]         float            NULL,
        [StatusId]          nvarchar(50)     NOT NULL,
        [Notes]             nvarchar(max)    NOT NULL,
        [CreatedAt]         datetime2        NOT NULL,
        [UpdatedAt]         datetime2        NULL,
        [RowVersion]        rowversion       NOT NULL,
        CONSTRAINT [PK_DamageReports] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_DamageReports_Farmers_FarmerId] FOREIGN KEY ([FarmerId])
            REFERENCES [dbo].[Farmers] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_DamageReports_Farms_FarmId] FOREIGN KEY ([FarmId])
            REFERENCES [dbo].[Farms] ([Id]) ON DELETE NO ACTION
    );
END;
GO

/* 4. DamageItems */
IF OBJECT_ID(N'[dbo].[DamageItems]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[DamageItems] (
        [Id]                   uniqueidentifier NOT NULL,
        [ClientId]             uniqueidentifier NOT NULL,
        [DamageReportId]       uniqueidentifier NOT NULL,
        [AgriculturalSectorId] nvarchar(50)     NOT NULL,
        [SubSectorId]          nvarchar(50)     NOT NULL,
        [CropId]               nvarchar(50)     NOT NULL,
        [DamageTypeId]         nvarchar(50)     NOT NULL,
        [AffectedArea]         decimal(18,2)    NOT NULL,
        [DamagePercentage]     decimal(18,2)    NOT NULL,
        [Quantity]             decimal(18,2)    NOT NULL,
        [EstimatedLoss]        decimal(18,2)    NOT NULL,
        [CreatedAt]            datetime2        NOT NULL,
        [UpdatedAt]            datetime2        NULL,
        [RowVersion]           rowversion       NOT NULL,
        CONSTRAINT [PK_DamageItems] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_DamageItems_DamageReports_DamageReportId] FOREIGN KEY ([DamageReportId])
            REFERENCES [dbo].[DamageReports] ([Id]) ON DELETE CASCADE
    );
END;
GO

/* 5. DamageReportAttachments */
IF OBJECT_ID(N'[dbo].[DamageReportAttachments]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[DamageReportAttachments] (
        [Id]               uniqueidentifier NOT NULL,
        [ClientId]         uniqueidentifier NOT NULL,
        [DamageReportId]   uniqueidentifier NOT NULL,
        [FileName]         nvarchar(250)    NOT NULL,
        [OriginalFileName] nvarchar(250)    NOT NULL,
        [FileType]         nvarchar(100)    NOT NULL,
        [FileSize]         bigint           NOT NULL,
        [LocalPath]        nvarchar(500)    NOT NULL,
        [RemotePath]       nvarchar(500)    NOT NULL,
        [ThumbnailPath]    nvarchar(max)    NULL,
        [Latitude]         float            NULL,
        [Longitude]        float            NULL,
        [CapturedAt]       datetime2        NULL,
        [UploadStatus]     nvarchar(50)     NOT NULL,
        [CreatedAt]        datetime2        NOT NULL,
        [UpdatedAt]        datetime2        NULL,
        [RowVersion]       rowversion       NOT NULL,
        CONSTRAINT [PK_DamageReportAttachments] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_DamageReportAttachments_DamageReports_DamageReportId] FOREIGN KEY ([DamageReportId])
            REFERENCES [dbo].[DamageReports] ([Id]) ON DELETE CASCADE
    );
END;
GO

/* 6. Indexes */
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_Farmers_ClientId' AND object_id = OBJECT_ID(N'[dbo].[Farmers]'))
    CREATE UNIQUE INDEX [IX_Farmers_ClientId] ON [dbo].[Farmers] ([ClientId]);
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_Farmers_NationalId' AND object_id = OBJECT_ID(N'[dbo].[Farmers]'))
    CREATE UNIQUE INDEX [IX_Farmers_NationalId] ON [dbo].[Farmers] ([NationalId]);
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_Farms_ClientId' AND object_id = OBJECT_ID(N'[dbo].[Farms]'))
    CREATE UNIQUE INDEX [IX_Farms_ClientId] ON [dbo].[Farms] ([ClientId]);
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_Farms_FarmerId' AND object_id = OBJECT_ID(N'[dbo].[Farms]'))
    CREATE INDEX [IX_Farms_FarmerId] ON [dbo].[Farms] ([FarmerId]);
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_DamageReports_ClientId' AND object_id = OBJECT_ID(N'[dbo].[DamageReports]'))
    CREATE UNIQUE INDEX [IX_DamageReports_ClientId] ON [dbo].[DamageReports] ([ClientId]);
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_DamageReports_FarmerId' AND object_id = OBJECT_ID(N'[dbo].[DamageReports]'))
    CREATE INDEX [IX_DamageReports_FarmerId] ON [dbo].[DamageReports] ([FarmerId]);
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_DamageReports_FarmId' AND object_id = OBJECT_ID(N'[dbo].[DamageReports]'))
    CREATE INDEX [IX_DamageReports_FarmId] ON [dbo].[DamageReports] ([FarmId]);
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_DamageItems_ClientId' AND object_id = OBJECT_ID(N'[dbo].[DamageItems]'))
    CREATE UNIQUE INDEX [IX_DamageItems_ClientId] ON [dbo].[DamageItems] ([ClientId]);
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_DamageItems_DamageReportId' AND object_id = OBJECT_ID(N'[dbo].[DamageItems]'))
    CREATE INDEX [IX_DamageItems_DamageReportId] ON [dbo].[DamageItems] ([DamageReportId]);
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_DamageReportAttachments_ClientId' AND object_id = OBJECT_ID(N'[dbo].[DamageReportAttachments]'))
    CREATE UNIQUE INDEX [IX_DamageReportAttachments_ClientId] ON [dbo].[DamageReportAttachments] ([ClientId]);
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_DamageReportAttachments_DamageReportId' AND object_id = OBJECT_ID(N'[dbo].[DamageReportAttachments]'))
    CREATE INDEX [IX_DamageReportAttachments_DamageReportId] ON [dbo].[DamageReportAttachments] ([DamageReportId]);
GO

/* 7. Record the migration as applied. */
IF NOT EXISTS (SELECT 1 FROM [dbo].[__EFMigrationsHistory] WHERE [MigrationId] = N'20260712185848_AddDamageAndFarmEntities')
    INSERT INTO [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260712185848_AddDamageAndFarmEntities', N'8.0.0');
GO
