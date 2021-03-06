/*
Run this script on:

        [Your Machine]\arachnode.net    -  This database will be modified

to synchronize it with:

        [Your Machine].arachnode.net

You are recommended to back up your database before running this script

Script created by SQL Compare version 8.2.0 from Red Gate Software Ltd at 8/11/2010 5:12:03 PM

*/
USE [arachnode.net]

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('tempdb..#tmpErrors')) DROP TABLE #tmpErrors
GO
CREATE TABLE #tmpErrors (Error int)
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
GO
PRINT N'Dropping constraints from [dbo].[CrawlRequests]'
GO
ALTER TABLE [dbo].[CrawlRequests] DROP CONSTRAINT [CK_CrawlRequests_2]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[CrawlRequests]'
GO
ALTER TABLE [dbo].[CrawlRequests] DROP CONSTRAINT [CK_CrawlRequests_3]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[CrawlRequests]'
GO
ALTER TABLE [dbo].[CrawlRequests] DROP CONSTRAINT [CK_CrawlRequests_1]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[CrawlRequests]'
GO
ALTER TABLE [dbo].[CrawlRequests] DROP CONSTRAINT [CK_CrawlRequests_4]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[CrawlRequests]'
GO
ALTER TABLE [dbo].[CrawlRequests] DROP CONSTRAINT [CK_CrawlRequests_5]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[CrawlRequests]'
GO
ALTER TABLE [dbo].[CrawlRequests] DROP CONSTRAINT [DF_CrawlRequests_RestrictCrawlTo]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[CrawlRequests]'
GO
ALTER TABLE [dbo].[CrawlRequests] DROP CONSTRAINT [DF_CrawlRequests_RestrictDiscoveriesTo]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[CrawlRequests]'
GO
ALTER TABLE [dbo].[CrawlRequests] ADD
[AbsoluteUri0] [varchar] (884) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_CrawlRequests_AbsoluteUri0] DEFAULT (NULL)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[CrawlRequests] ALTER COLUMN [RestrictCrawlTo] [smallint] NOT NULL
ALTER TABLE [dbo].[CrawlRequests] ALTER COLUMN [RestrictDiscoveriesTo] [smallint] NOT NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[arachnode_omsp_CrawlRequests_INSERT]'
GO
ALTER PROCEDURE [dbo].[arachnode_omsp_CrawlRequests_INSERT]
    @Created [datetime] ,
    @AbsoluteUri0 [varchar](884) ,
    @AbsoluteUri1 [varchar](884) ,
    @AbsoluteUri2 [varchar](884) ,
    @CurrentDepth [int] ,
    @MaximumDepth [int] ,
    @RestrictCrawlTo SMALLINT ,
    @RestrictDiscoveriesTo SMALLINT ,
    @Priority [float] ,
    @RenderType TINYINT ,
    @RenderTypeForChildren TINYINT ,
    @CrawlRequestID [bigint] OUTPUT
    WITH EXECUTE AS CALLER
AS 
    SET NOCOUNT ON

    IF NOT EXISTS ( SELECT  AbsoluteUri2
                    FROM    dbo.CrawlRequests
                    WHERE   AbsoluteUri2 = @AbsoluteUri2 )
        /*AND NOT EXISTS ( SELECT AbsoluteUri
                         FROM   dbo.Discoveries
                         WHERE  AbsoluteUri = @AbsoluteUri2 ) */
        BEGIN
            INSERT  dbo.CrawlRequests
                    ( Created ,
					  AbsoluteUri0 ,
                      AbsoluteUri1 ,
                      AbsoluteUri2 ,
                      CurrentDepth ,
                      MaximumDepth ,
                      RestrictCrawlTo ,
                      RestrictDiscoveriesTo ,
                      Priority ,
                      RenderType ,
                      RenderTypeForChildren
                    )
            VALUES  ( @Created ,
					  @AbsoluteUri0 ,
                      @AbsoluteUri1 ,
                      @AbsoluteUri2 ,
                      @CurrentDepth ,
                      @MaximumDepth,
                      @RestrictCrawlTo ,
                      @RestrictDiscoveriesTo ,
                      @Priority ,
                      @RenderType ,
                      @RenderTypeForChildren
                    )
        END
    ELSE 
        BEGIN
            UPDATE  dbo.CrawlRequests
            SET     Created = @Created ,
                    CurrentDepth = @CurrentDepth ,
                    MaximumDepth = @MaximumDepth ,
                    RestrictCrawlTo = @RestrictCrawlTo ,
                    RestrictDiscoveriesTo = @RestrictDiscoveriesTo ,	
                    Priority = @Priority ,
					RenderType = @RenderType ,
                    RenderTypeForChildren = @RenderTypeForChildren
            WHERE   AbsoluteUri1 = @AbsoluteUri1
                    AND AbsoluteUri2 = @AbsoluteUri2
        END

    SET @CrawlRequestID = ( SELECT  ID
                            FROM    CrawlRequests
                            WHERE   AbsoluteUri1 = @AbsoluteUri1
                                    AND AbsoluteUri2 = @AbsoluteUri2
                          )






GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[arachnode_omsp_CrawlRequests_SELECT]'
GO
ALTER PROCEDURE [dbo].[arachnode_omsp_CrawlRequests_SELECT]
    @MaximumNumberOfCrawlRequestsToCreatePerBatch [int] ,
    @CreateCrawlRequestsFromDatabaseCrawlRequests [bit] = 1 ,
    @CreateCrawlRequestsFromDatabaseFiles [bit] = 0 ,
    @AssignCrawlRequestPrioritiesForFiles [bit] = 1 ,
    @CreateCrawlRequestsFromDatabaseHyperLinks [bit] = 0 ,
    @AssignCrawlRequestPrioritiesForHyperLinks [bit] = 1 ,
    @CreateCrawlRequestsFromDatabaseImages [bit] = 0 ,
    @AssignCrawlRequestPrioritiesForImages [bit] = 1 ,
    @CreateCrawlRequestsFromDatabaseWebPages [bit] = 0 ,
    @AssignCrawlRequestPrioritiesForWebPages [bit] = 1
    WITH EXECUTE AS CALLER
AS 
    SET ROWCOUNT @MaximumNumberOfCrawlRequestsToCreatePerBatch

    SELECT TOP ( @MaximumNumberOfCrawlRequestsToCreatePerBatch )
            *
    FROM    ( SELECT TOP ( @MaximumNumberOfCrawlRequestsToCreatePerBatch )
                        Created ,
                        cr.AbsoluteUri0,
                        cr.AbsoluteUri1 ,
                        cr.AbsoluteUri2 ,
                        CurrentDepth ,
                        MaximumDepth ,
                        RestrictCrawlTo ,
                        RestrictDiscoveriesTo ,
                        Priority ,
                        RenderType,
                        RenderTypeForChildren,
                        0 AS DiscoveryTypeID
              FROM      CrawlRequests (NOLOCK) AS cr
                        LEFT OUTER JOIN DisallowedAbsoluteUris (NOLOCK) AS dau ON cr.AbsoluteUri2 = dau.AbsoluteUri
              WHERE     @CreateCrawlRequestsFromDatabaseCrawlRequests = 1
						--AND @@ROWCOUNT < @MaximumNumberOfCrawlRequestsToCreatePerBatch
                        AND ( dau.ID IS NULL )
              ORDER BY  Priority DESC ,
                        Created ASC
              UNION
              /**/ --HyperLinks
              SELECT TOP ( @MaximumNumberOfCrawlRequestsToCreatePerBatch )
                        MAX(hld.LastDiscovered) ,
                        hl.AbsoluteUri ,
                        hl.AbsoluteUri ,
                        hl.AbsoluteUri ,
                        1 ,
                        1 ,
                        8 ,
                        8 ,
                        CASE WHEN @AssignCrawlRequestPrioritiesForHyperLinks = 1
                             THEN ISNULL(( MAX(p.Value) + 1 ) / ( DATEDIFF(DD,
                                                              MAX(hld.LastDiscovered),
                                                              GETDATE() + 1) ),
                                         0)
                             ELSE 0
                        END ,
						0 ,
                        0 ,
                        5 AS DiscoveryTypeID
              FROM      HyperLinks (NOLOCK) AS hl
                        INNER JOIN HyperLinks_Discoveries (NOLOCK) AS hld ON hl.ID = hld.HyperLinkID
                        LEFT OUTER JOIN DisallowedAbsoluteUris (NOLOCK) AS dau ON hl.AbsoluteUri = dau.AbsoluteUri
                        LEFT OUTER JOIN Files (NOLOCK) AS f ON hl.AbsoluteUri = f.AbsoluteUri
                        LEFT OUTER JOIN WebPages (NOLOCK) AS wp ON hl.AbsoluteUri = wp.AbsoluteUri
                        LEFT OUTER JOIN HyperLinks_Hosts_Discoveries (NOLOCK)
                        AS hlhd ON hl.ID = hlhd.HyperLinkID
                        LEFT OUTER JOIN Hosts_Discoveries (NOLOCK) AS hd ON hlhd.Host_DiscoveryID = hd.ID
                        LEFT OUTER JOIN Hosts (NOLOCK) AS h ON hd.HostID = h.ID
                        LEFT OUTER JOIN cfg.Priorities (NOLOCK) AS p ON h.Host = p.Host
              WHERE     @CreateCrawlRequestsFromDatabaseHyperLinks = 1
                        AND ( dau.ID IS NULL )
                        AND f.AbsoluteUri IS NULL
                        AND wp.AbsoluteUri IS NULL
                        --AND @@ROWCOUNT < @MaximumNumberOfCrawlRequestsToCreatePerBatch
              GROUP BY  hl.AbsoluteUri
              HAVING    MAX(hld.LastDiscovered) < ( SELECT  MAX(LastDiscovered)
                                                    FROM    HyperLinks_Discoveries
                                                  )
              ORDER BY  CASE WHEN @AssignCrawlRequestPrioritiesForWebPages = 1
                             THEN ISNULL(( MAX(p.Value) + 1 ) / ( DATEDIFF(DD,
                                                              MAX(hld.LastDiscovered),
                                                              GETDATE() + 1) ),
                                         0)
                        END DESC ,
                        CASE WHEN @AssignCrawlRequestPrioritiesForWebPages = 0
                             THEN MAX(hld.LastDiscovered)
                        END ASC
              UNION
		      /**/ --WebPages
              SELECT TOP ( @MaximumNumberOfCrawlRequestsToCreatePerBatch )
                        wp.LastDiscovered ,
                        wp.AbsoluteUri ,
                        wp.AbsoluteUri ,
                        wp.AbsoluteUri ,
                        1 ,
                        1 ,
                        8 ,
                        8 ,
                        CASE WHEN @AssignCrawlRequestPrioritiesForWebPages = 1
                             THEN ISNULL(( p.Value + 1 ) / ( DATEDIFF(DD,
                                                              wp.LastDiscovered,
                                                              GETDATE() + 1) ),
                                         0)
                             ELSE 0
                        END ,
                        0 ,
                        0 ,
                        7 AS DiscoveryTypeID
              FROM      WebPages (NOLOCK) AS wp
                        LEFT OUTER JOIN DisallowedAbsoluteUris (NOLOCK) AS dau ON wp.AbsoluteUri = dau.AbsoluteUri
                        LEFT OUTER JOIN WebPages_Hosts_Discoveries (NOLOCK) AS wphd ON wp.ID = wphd.WebPageID
                        LEFT OUTER JOIN Hosts_Discoveries (NOLOCK) AS hd ON wphd.Host_DiscoveryID = hd.ID
                        LEFT OUTER JOIN Hosts (NOLOCK) AS h ON hd.HostID = h.ID
                        LEFT OUTER JOIN cfg.Priorities (NOLOCK) AS p ON h.Host = p.Host
              WHERE     @CreateCrawlRequestsFromDatabaseWebPages = 1
                        AND hd.DiscoveryTypeID = 7
                        AND ( dau.ID IS NULL )
						--AND @@ROWCOUNT < @MaximumNumberOfCrawlRequestsToCreatePerBatch
              ORDER BY  CASE WHEN @AssignCrawlRequestPrioritiesForWebPages = 1
                             THEN ISNULL(( p.Value + 1 ) / ( DATEDIFF(DD,
                                                              wp.LastDiscovered,
                                                              GETDATE() + 1) ),
                                         0)
                        END DESC ,
                        CASE WHEN @AssignCrawlRequestPrioritiesForWebPages = 0
                             THEN wp.LastDiscovered
                        END ASC ,
                        CrawlDepth DESC
              UNION
              /**/ --Files
              SELECT TOP ( @MaximumNumberOfCrawlRequestsToCreatePerBatch )
                        MAX(fd.LastDiscovered) ,
                        f.AbsoluteUri ,
                        f.AbsoluteUri ,
                        f.AbsoluteUri ,
                        1 ,
                        1 ,
                        8 ,
                        8 ,
                        CASE WHEN @AssignCrawlRequestPrioritiesForFiles = 1
                             THEN ISNULL(( MAX(p.Value) + 1 ) / ( DATEDIFF(DD,
                                                              MAX(fd.LastDiscovered),
                                                              GETDATE() + 1) ),
                                         0)
                             ELSE 0
                        END ,
                        0 ,
                        0 ,
                        4 AS DiscoveryTypeID
              FROM      Files (NOLOCK) AS f
                        INNER JOIN Files_Discoveries (NOLOCK) AS fd ON f.ID = fd.FileID
                        LEFT OUTER JOIN DisallowedAbsoluteUris (NOLOCK) AS dau ON f.AbsoluteUri = dau.AbsoluteUri
                        LEFT OUTER JOIN Files_Hosts_Discoveries (NOLOCK) AS fhd ON f.ID = fhd.FileID
                        LEFT OUTER JOIN Hosts_Discoveries (NOLOCK) AS hd ON fhd.Host_DiscoveryID = hd.ID
                        LEFT OUTER JOIN Hosts (NOLOCK) AS h ON hd.HostID = h.ID
                        LEFT OUTER JOIN cfg.Priorities (NOLOCK) AS p ON h.Host = p.Host
              WHERE     @CreateCrawlRequestsFromDatabaseFiles = 1
                        AND ( dau.ID IS NULL )
						--AND @@ROWCOUNT < @MaximumNumberOfCrawlRequestsToCreatePerBatch
              GROUP BY  f.AbsoluteUri
              HAVING    MAX(fd.LastDiscovered) < ( SELECT   MAX(LastDiscovered)
                                                   FROM     Files_Discoveries
                                                 )
              ORDER BY  CASE WHEN @AssignCrawlRequestPrioritiesForFiles = 1
                             THEN ISNULL(( MAX(p.Value) + 1 ) / ( DATEDIFF(DD,
                                                              MAX(fd.LastDiscovered),
                                                              GETDATE() + 1) ),
                                         0)
                        END DESC ,
                        CASE WHEN @AssignCrawlRequestPrioritiesForFiles = 0
                             THEN MAX(fd.LastDiscovered)
                        END ASC
              --ORDER BY  MIN(fd.LastDiscovered)
              UNION
			  /**/ --Images
              SELECT TOP ( @MaximumNumberOfCrawlRequestsToCreatePerBatch )
                        MAX(id.LastDiscovered) ,
                        i.AbsoluteUri ,
                        i.AbsoluteUri ,
                        i.AbsoluteUri ,
                        1 ,
                        1 ,
                        8 ,
                        8 ,
                        CASE WHEN @AssignCrawlRequestPrioritiesForImages = 1
                             THEN ISNULL(( MAX(p.Value) + 1 ) / ( DATEDIFF(DD,
                                                              MAX(id.LastDiscovered),
                                                              GETDATE() + 1) ),
                                         0)
                             ELSE 0
                        END ,
                        0 ,
                        0 ,
                        6 AS DiscoveryTypeID
              FROM      Images (NOLOCK) AS i
                        INNER JOIN Images_Discoveries (NOLOCK) AS id ON i.ID = id.ImageID
                        LEFT OUTER JOIN DisallowedAbsoluteUris (NOLOCK) AS dau ON i.AbsoluteUri = dau.AbsoluteUri
                        LEFT OUTER JOIN Images_Hosts_Discoveries (NOLOCK) AS ihd ON i.ID = ihd.ImageID
                        LEFT OUTER JOIN Hosts_Discoveries (NOLOCK) AS hd ON ihd.Host_DiscoveryID = hd.ID
                        LEFT OUTER JOIN Hosts (NOLOCK) AS h ON hd.HostID = h.ID
                        LEFT OUTER JOIN cfg.Priorities (NOLOCK) AS p ON h.Host = p.Host
              WHERE     @CreateCrawlRequestsFromDatabaseImages = 1
                        AND ( dau.ID IS NULL )
						--AND @@ROWCOUNT < @MaximumNumberOfCrawlRequestsToCreatePerBatch
              GROUP BY  i.AbsoluteUri
              HAVING    MAX(id.LastDiscovered) < ( SELECT   MAX(LastDiscovered)
                                                   FROM     Images_Discoveries
                                                 )
              ORDER BY  CASE WHEN @AssignCrawlRequestPrioritiesForImages = 1
                             THEN ISNULL(( MAX(p.Value) + 1 ) / ( DATEDIFF(DD,
                                                              MAX(id.LastDiscovered),
                                                              GETDATE() + 1) ),
                                         0)
                        END DESC ,
                        CASE WHEN @AssignCrawlRequestPrioritiesForFiles = 0
                             THEN MAX(id.LastDiscovered)
                        END ASC
            ) AS CrawlRequests
    ORDER BY Priority DESC ,
            Created ASC

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding constraints to [dbo].[CrawlRequests]'
GO
ALTER TABLE [dbo].[CrawlRequests] ADD CONSTRAINT [CK_CrawlRequests_1] CHECK (([AbsoluteUri2] like '%//%' AND ([AbsoluteUri2] like '%/' OR NOT (len([AbsoluteUri2])-len(replace([AbsoluteUri2],'/','')))<(3))))
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[CrawlRequests] ADD CONSTRAINT [CK_CrawlRequests_2] CHECK (([CurrentDepth]>(0)))
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[CrawlRequests] ADD CONSTRAINT [CK_CrawlRequests_3] CHECK (([MaximumDepth]>=(1)))
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[CrawlRequests] ADD CONSTRAINT [DF_CrawlRequests_RestrictCrawlTo] DEFAULT ((0)) FOR [RestrictCrawlTo]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[CrawlRequests] ADD CONSTRAINT [DF_CrawlRequests_RestrictDiscoveriesTo] DEFAULT ((0)) FOR [RestrictDiscoveriesTo]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
-- Update 1 row in [cfg].[Version]
UPDATE [cfg].[Version] SET [Value]='2.5.0.12' WHERE [ID]=1
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
IF EXISTS (SELECT * FROM #tmpErrors) ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT>0 BEGIN
PRINT 'The database update succeeded'
COMMIT TRANSACTION
END
ELSE PRINT 'The database update failed'
GO
DROP TABLE #tmpErrors
GO
