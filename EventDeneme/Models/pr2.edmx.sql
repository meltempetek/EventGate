
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 12/12/2025 03:01:02
-- Generated from EDMX file: C:\Users\melte\OneDrive - Istanbul Kultur Universitesi\Masaüstü\Projects\eventgate\EventDeneme\Models\pr2.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [pr2];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK__cart_item__cart___47DBAE45]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[cart_items] DROP CONSTRAINT [FK__cart_item__cart___47DBAE45];
GO
IF OBJECT_ID(N'[dbo].[FK__carts__session_i__4316F928]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[carts] DROP CONSTRAINT [FK__carts__session_i__4316F928];
GO
IF OBJECT_ID(N'[dbo].[FK__carts__user_id__4222D4EF]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[carts] DROP CONSTRAINT [FK__carts__user_id__4222D4EF];
GO
IF OBJECT_ID(N'[dbo].[FK__concert_d__event__08B54D69]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[concert_details] DROP CONSTRAINT [FK__concert_d__event__08B54D69];
GO
IF OBJECT_ID(N'[dbo].[FK__event_mov__event__114A936A]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[event_movie_genres] DROP CONSTRAINT [FK__event_mov__event__114A936A];
GO
IF OBJECT_ID(N'[dbo].[FK__event_mov__movie__123EB7A3]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[event_movie_genres] DROP CONSTRAINT [FK__event_mov__movie__123EB7A3];
GO
IF OBJECT_ID(N'[dbo].[FK__event_mus__event__18EBB532]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[event_music_genres] DROP CONSTRAINT [FK__event_mus__event__18EBB532];
GO
IF OBJECT_ID(N'[dbo].[FK__event_mus__music__19DFD96B]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[event_music_genres] DROP CONSTRAINT [FK__event_mus__music__19DFD96B];
GO
IF OBJECT_ID(N'[dbo].[FK__event_the__event__151B244E]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[event_theatre_genres] DROP CONSTRAINT [FK__event_the__event__151B244E];
GO
IF OBJECT_ID(N'[dbo].[FK__event_the__theat__160F4887]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[event_theatre_genres] DROP CONSTRAINT [FK__event_the__theat__160F4887];
GO
IF OBJECT_ID(N'[dbo].[FK__events__category__6FE99F9F]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[events] DROP CONSTRAINT [FK__events__category__6FE99F9F];
GO
IF OBJECT_ID(N'[dbo].[FK__events__organize__70DDC3D8]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[events] DROP CONSTRAINT [FK__events__organize__70DDC3D8];
GO
IF OBJECT_ID(N'[dbo].[FK__moderatio__event__30C33EC3]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[moderation_events] DROP CONSTRAINT [FK__moderatio__event__30C33EC3];
GO
IF OBJECT_ID(N'[dbo].[FK__moderatio__revie__32AB8735]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[moderation_events] DROP CONSTRAINT [FK__moderatio__revie__32AB8735];
GO
IF OBJECT_ID(N'[dbo].[FK__moderatio__submi__31B762FC]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[moderation_events] DROP CONSTRAINT [FK__moderatio__submi__31B762FC];
GO
IF OBJECT_ID(N'[dbo].[FK__movie_det__event__02FC7413]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[movie_details] DROP CONSTRAINT [FK__movie_det__event__02FC7413];
GO
IF OBJECT_ID(N'[dbo].[FK__order_ite__order__4F7CD00D]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[order_items] DROP CONSTRAINT [FK__order_ite__order__4F7CD00D];
GO
IF OBJECT_ID(N'[dbo].[FK__orders__session___4CA06362]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[orders] DROP CONSTRAINT [FK__orders__session___4CA06362];
GO
IF OBJECT_ID(N'[dbo].[FK__orders__user_id__4BAC3F29]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[orders] DROP CONSTRAINT [FK__orders__user_id__4BAC3F29];
GO
IF OBJECT_ID(N'[dbo].[FK__organizer__organ__2645B050]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[organizer_users] DROP CONSTRAINT [FK__organizer__organ__2645B050];
GO
IF OBJECT_ID(N'[dbo].[FK__organizer__organ__2A164134]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[organizer_applications] DROP CONSTRAINT [FK__organizer__organ__2A164134];
GO
IF OBJECT_ID(N'[dbo].[FK__organizer__revie__2B0A656D]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[organizer_applications] DROP CONSTRAINT [FK__organizer__revie__2B0A656D];
GO
IF OBJECT_ID(N'[dbo].[FK__payments__order___571DF1D5]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[payments] DROP CONSTRAINT [FK__payments__order___571DF1D5];
GO
IF OBJECT_ID(N'[dbo].[FK__performan__event__74AE54BC]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[performances] DROP CONSTRAINT [FK__performan__event__74AE54BC];
GO
IF OBJECT_ID(N'[dbo].[FK__performan__perfo__7B5B524B]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[performance_seats] DROP CONSTRAINT [FK__performan__perfo__7B5B524B];
GO
IF OBJECT_ID(N'[dbo].[FK__performan__seat___7C4F7684]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[performance_seats] DROP CONSTRAINT [FK__performan__seat___7C4F7684];
GO
IF OBJECT_ID(N'[dbo].[FK__performan__venue__75A278F5]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[performances] DROP CONSTRAINT [FK__performan__venue__75A278F5];
GO
IF OBJECT_ID(N'[dbo].[FK__price_tie__perfo__787EE5A0]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[price_tiers] DROP CONSTRAINT [FK__price_tie__perfo__787EE5A0];
GO
IF OBJECT_ID(N'[dbo].[FK__refunds__payment__59FA5E80]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[refunds] DROP CONSTRAINT [FK__refunds__payment__59FA5E80];
GO
IF OBJECT_ID(N'[dbo].[FK__search_qu__sessi__1CBC4616]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[search_queries] DROP CONSTRAINT [FK__search_qu__sessi__1CBC4616];
GO
IF OBJECT_ID(N'[dbo].[FK__seat_hold__cart___00200768]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[seat_holds] DROP CONSTRAINT [FK__seat_hold__cart___00200768];
GO
IF OBJECT_ID(N'[dbo].[FK__seat_hold__perfo__7F2BE32F]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[seat_holds] DROP CONSTRAINT [FK__seat_hold__perfo__7F2BE32F];
GO
IF OBJECT_ID(N'[dbo].[FK__seatmaps__venue___628FA481]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[seatmaps] DROP CONSTRAINT [FK__seatmaps__venue___628FA481];
GO
IF OBJECT_ID(N'[dbo].[FK__seats__venue_id__66603565]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[seats] DROP CONSTRAINT [FK__seats__venue_id__66603565];
GO
IF OBJECT_ID(N'[dbo].[FK__sessions__user_i__3B75D760]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[sessions] DROP CONSTRAINT [FK__sessions__user_i__3B75D760];
GO
IF OBJECT_ID(N'[dbo].[FK__theatre_d__event__05D8E0BE]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[theatre_details] DROP CONSTRAINT [FK__theatre_d__event__05D8E0BE];
GO
IF OBJECT_ID(N'[dbo].[FK__tickets__order_i__5441852A]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[tickets] DROP CONSTRAINT [FK__tickets__order_i__5441852A];
GO
IF OBJECT_ID(N'[dbo].[FK__user_paym__user___3E52440B]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[user_payment_methods] DROP CONSTRAINT [FK__user_paym__user___3E52440B];
GO
IF OBJECT_ID(N'[dbo].[FK__venues__city_id__5FB337D6]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[venues] DROP CONSTRAINT [FK__venues__city_id__5FB337D6];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[admins]', 'U') IS NOT NULL
    DROP TABLE [dbo].[admins];
GO
IF OBJECT_ID(N'[dbo].[cart_items]', 'U') IS NOT NULL
    DROP TABLE [dbo].[cart_items];
GO
IF OBJECT_ID(N'[dbo].[carts]', 'U') IS NOT NULL
    DROP TABLE [dbo].[carts];
GO
IF OBJECT_ID(N'[dbo].[categories]', 'U') IS NOT NULL
    DROP TABLE [dbo].[categories];
GO
IF OBJECT_ID(N'[dbo].[cities]', 'U') IS NOT NULL
    DROP TABLE [dbo].[cities];
GO
IF OBJECT_ID(N'[dbo].[concert_details]', 'U') IS NOT NULL
    DROP TABLE [dbo].[concert_details];
GO
IF OBJECT_ID(N'[dbo].[event_movie_genres]', 'U') IS NOT NULL
    DROP TABLE [dbo].[event_movie_genres];
GO
IF OBJECT_ID(N'[dbo].[event_music_genres]', 'U') IS NOT NULL
    DROP TABLE [dbo].[event_music_genres];
GO
IF OBJECT_ID(N'[dbo].[event_theatre_genres]', 'U') IS NOT NULL
    DROP TABLE [dbo].[event_theatre_genres];
GO
IF OBJECT_ID(N'[dbo].[events]', 'U') IS NOT NULL
    DROP TABLE [dbo].[events];
GO
IF OBJECT_ID(N'[dbo].[moderation_events]', 'U') IS NOT NULL
    DROP TABLE [dbo].[moderation_events];
GO
IF OBJECT_ID(N'[dbo].[movie_details]', 'U') IS NOT NULL
    DROP TABLE [dbo].[movie_details];
GO
IF OBJECT_ID(N'[dbo].[movie_genres]', 'U') IS NOT NULL
    DROP TABLE [dbo].[movie_genres];
GO
IF OBJECT_ID(N'[dbo].[music_genres]', 'U') IS NOT NULL
    DROP TABLE [dbo].[music_genres];
GO
IF OBJECT_ID(N'[dbo].[order_items]', 'U') IS NOT NULL
    DROP TABLE [dbo].[order_items];
GO
IF OBJECT_ID(N'[dbo].[orders]', 'U') IS NOT NULL
    DROP TABLE [dbo].[orders];
GO
IF OBJECT_ID(N'[dbo].[organizer_applications]', 'U') IS NOT NULL
    DROP TABLE [dbo].[organizer_applications];
GO
IF OBJECT_ID(N'[dbo].[organizer_documents]', 'U') IS NOT NULL
    DROP TABLE [dbo].[organizer_documents];
GO
IF OBJECT_ID(N'[dbo].[organizer_users]', 'U') IS NOT NULL
    DROP TABLE [dbo].[organizer_users];
GO
IF OBJECT_ID(N'[dbo].[organizers]', 'U') IS NOT NULL
    DROP TABLE [dbo].[organizers];
GO
IF OBJECT_ID(N'[dbo].[payments]', 'U') IS NOT NULL
    DROP TABLE [dbo].[payments];
GO
IF OBJECT_ID(N'[dbo].[performance_seats]', 'U') IS NOT NULL
    DROP TABLE [dbo].[performance_seats];
GO
IF OBJECT_ID(N'[dbo].[performances]', 'U') IS NOT NULL
    DROP TABLE [dbo].[performances];
GO
IF OBJECT_ID(N'[dbo].[price_tiers]', 'U') IS NOT NULL
    DROP TABLE [dbo].[price_tiers];
GO
IF OBJECT_ID(N'[dbo].[refunds]', 'U') IS NOT NULL
    DROP TABLE [dbo].[refunds];
GO
IF OBJECT_ID(N'[dbo].[search_queries]', 'U') IS NOT NULL
    DROP TABLE [dbo].[search_queries];
GO
IF OBJECT_ID(N'[dbo].[seat_holds]', 'U') IS NOT NULL
    DROP TABLE [dbo].[seat_holds];
GO
IF OBJECT_ID(N'[dbo].[seatmaps]', 'U') IS NOT NULL
    DROP TABLE [dbo].[seatmaps];
GO
IF OBJECT_ID(N'[dbo].[seats]', 'U') IS NOT NULL
    DROP TABLE [dbo].[seats];
GO
IF OBJECT_ID(N'[dbo].[sessions]', 'U') IS NOT NULL
    DROP TABLE [dbo].[sessions];
GO
IF OBJECT_ID(N'[dbo].[sysdiagrams]', 'U') IS NOT NULL
    DROP TABLE [dbo].[sysdiagrams];
GO
IF OBJECT_ID(N'[dbo].[theatre_details]', 'U') IS NOT NULL
    DROP TABLE [dbo].[theatre_details];
GO
IF OBJECT_ID(N'[dbo].[theatre_genres]', 'U') IS NOT NULL
    DROP TABLE [dbo].[theatre_genres];
GO
IF OBJECT_ID(N'[dbo].[tickets]', 'U') IS NOT NULL
    DROP TABLE [dbo].[tickets];
GO
IF OBJECT_ID(N'[dbo].[user_payment_methods]', 'U') IS NOT NULL
    DROP TABLE [dbo].[user_payment_methods];
GO
IF OBJECT_ID(N'[dbo].[users]', 'U') IS NOT NULL
    DROP TABLE [dbo].[users];
GO
IF OBJECT_ID(N'[dbo].[venues]', 'U') IS NOT NULL
    DROP TABLE [dbo].[venues];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'admins'
CREATE TABLE [dbo].[admins] (
    [id] bigint IDENTITY(1,1) NOT NULL,
    [username] nvarchar(255)  NOT NULL,
    [password_hash] nvarchar(255)  NOT NULL,
    [role] nvarchar(50)  NOT NULL,
    [created_at] datetime  NULL
);
GO

-- Creating table 'cart_items'
CREATE TABLE [dbo].[cart_items] (
    [id] bigint IDENTITY(1,1) NOT NULL,
    [cart_id] bigint  NOT NULL,
    [performance_id] bigint  NOT NULL,
    [price_tier_id] bigint  NOT NULL,
    [seat_id] bigint  NULL,
    [quantity] int  NOT NULL,
    [unit_price] decimal(12,2)  NOT NULL,
    [status] nvarchar(50)  NOT NULL
);
GO

-- Creating table 'carts'
CREATE TABLE [dbo].[carts] (
    [id] bigint IDENTITY(1,1) NOT NULL,
    [user_id] bigint  NULL,
    [session_id] bigint  NULL,
    [status] nvarchar(50)  NOT NULL,
    [created_at] datetime  NULL,
    [updated_at] datetime  NULL
);
GO

-- Creating table 'categories'
CREATE TABLE [dbo].[categories] (
    [id] int IDENTITY(1,1) NOT NULL,
    [category_key] nvarchar(100)  NOT NULL,
    [display_name] nvarchar(255)  NOT NULL
);
GO

-- Creating table 'cities'
CREATE TABLE [dbo].[cities] (
    [id] bigint IDENTITY(1,1) NOT NULL,
    [name] nvarchar(255)  NOT NULL
);
GO

-- Creating table 'concert_details'
CREATE TABLE [dbo].[concert_details] (
    [event_id] bigint  NOT NULL,
    [duration_min] int  NULL,
    [headliner] nvarchar(255)  NULL,
    [opener] nvarchar(255)  NULL,
    [music_genre_main_id] bigint  NULL
);
GO

-- Creating table 'events'
CREATE TABLE [dbo].[events] (
    [id] bigint IDENTITY(1,1) NOT NULL,
    [category_id] int  NOT NULL,
    [organizer_id] bigint  NOT NULL,
    [title] nvarchar(255)  NOT NULL,
    [description] nvarchar(max)  NULL,
    [language] nvarchar(50)  NULL,
    [age_limit] nvarchar(50)  NULL,
    [poster_url] nvarchar(max)  NULL,
    [status] nvarchar(50)  NOT NULL,
    [created_at] datetime  NULL,
    [updated_at] datetime  NULL
);
GO

-- Creating table 'moderation_events'
CREATE TABLE [dbo].[moderation_events] (
    [id] bigint IDENTITY(1,1) NOT NULL,
    [event_id] bigint  NOT NULL,
    [submitted_by] bigint  NOT NULL,
    [status] nvarchar(50)  NOT NULL,
    [reviewed_by] bigint  NULL,
    [reviewed_at] datetime  NULL,
    [notes] nvarchar(max)  NULL
);
GO

-- Creating table 'movie_details'
CREATE TABLE [dbo].[movie_details] (
    [event_id] bigint  NOT NULL,
    [duration_min] int  NULL,
    [imdb_id] nvarchar(50)  NULL,
    [parental_rating] nvarchar(50)  NULL,
    [distributor] nvarchar(255)  NULL
);
GO

-- Creating table 'movie_genres'
CREATE TABLE [dbo].[movie_genres] (
    [id] bigint IDENTITY(1,1) NOT NULL,
    [name] nvarchar(255)  NOT NULL
);
GO

-- Creating table 'music_genres'
CREATE TABLE [dbo].[music_genres] (
    [id] bigint IDENTITY(1,1) NOT NULL,
    [name] nvarchar(255)  NOT NULL
);
GO

-- Creating table 'order_items'
CREATE TABLE [dbo].[order_items] (
    [id] bigint IDENTITY(1,1) NOT NULL,
    [order_id] bigint  NOT NULL,
    [performance_id] bigint  NOT NULL,
    [price_tier_id] bigint  NOT NULL,
    [seat_id] bigint  NULL,
    [unit_price] decimal(12,2)  NOT NULL
);
GO

-- Creating table 'orders'
CREATE TABLE [dbo].[orders] (
    [id] bigint IDENTITY(1,1) NOT NULL,
    [user_id] bigint  NULL,
    [session_id] bigint  NULL,
    [email] nvarchar(255)  NULL,
    [phone] nvarchar(50)  NULL,
    [total_amount] decimal(12,2)  NOT NULL,
    [currency] nvarchar(10)  NOT NULL,
    [status] nvarchar(50)  NOT NULL,
    [payment_intent_id] nvarchar(255)  NULL,
    [created_at] datetime  NULL
);
GO

-- Creating table 'organizer_applications'
CREATE TABLE [dbo].[organizer_applications] (
    [id] bigint IDENTITY(1,1) NOT NULL,
    [organizer_id] bigint  NULL,
    [org_name] nvarchar(255)  NOT NULL,
    [contact_email] nvarchar(255)  NULL,
    [submitted_at] datetime  NULL,
    [status] nvarchar(50)  NOT NULL,
    [reviewed_by_admin_id] bigint  NULL,
    [review_notes] nvarchar(max)  NULL,
    [decided_at] datetime  NULL
);
GO

-- Creating table 'organizer_documents'
CREATE TABLE [dbo].[organizer_documents] (
    [id] bigint IDENTITY(1,1) NOT NULL,
    [application_id] bigint  NOT NULL,
    [file_url] nvarchar(max)  NOT NULL,
    [doc_type] nvarchar(50)  NOT NULL,
    [uploaded_at] datetime  NULL
);
GO

-- Creating table 'organizer_users'
CREATE TABLE [dbo].[organizer_users] (
    [id] bigint IDENTITY(1,1) NOT NULL,
    [organizer_id] bigint  NOT NULL,
    [username] nvarchar(255)  NOT NULL,
    [email] nvarchar(255)  NULL,
    [password_hash] nvarchar(255)  NOT NULL,
    [role] nvarchar(50)  NOT NULL,
    [status] nvarchar(50)  NOT NULL
);
GO

-- Creating table 'organizers'
CREATE TABLE [dbo].[organizers] (
    [id] bigint IDENTITY(1,1) NOT NULL,
    [legal_name] nvarchar(255)  NOT NULL,
    [brand_name] nvarchar(255)  NULL,
    [tax_id] nvarchar(100)  NULL,
    [contact_email] nvarchar(255)  NULL,
    [contact_phone] nvarchar(100)  NULL,
    [status] nvarchar(50)  NOT NULL,
    [created_at] datetime  NULL
);
GO

-- Creating table 'payments'
CREATE TABLE [dbo].[payments] (
    [id] bigint IDENTITY(1,1) NOT NULL,
    [order_id] bigint  NOT NULL,
    [provider] nvarchar(255)  NOT NULL,
    [provider_payment_id] nvarchar(255)  NULL,
    [amount] decimal(12,2)  NOT NULL,
    [currency] nvarchar(10)  NOT NULL,
    [status] nvarchar(50)  NOT NULL,
    [captured_at] datetime  NULL,
    [failure_reason] nvarchar(max)  NULL
);
GO

-- Creating table 'performance_seats'
CREATE TABLE [dbo].[performance_seats] (
    [id] bigint IDENTITY(1,1) NOT NULL,
    [performance_id] bigint  NOT NULL,
    [seat_id] bigint  NOT NULL,
    [price_tier_id] bigint  NULL,
    [status] nvarchar(50)  NOT NULL
);
GO

-- Creating table 'performances'
CREATE TABLE [dbo].[performances] (
    [id] bigint IDENTITY(1,1) NOT NULL,
    [event_id] bigint  NOT NULL,
    [venue_id] bigint  NOT NULL,
    [start_datetime] datetime  NOT NULL,
    [end_datetime] datetime  NULL,
    [sales_start] datetime  NULL,
    [sales_end] datetime  NULL,
    [status] nvarchar(50)  NOT NULL
);
GO

-- Creating table 'price_tiers'
CREATE TABLE [dbo].[price_tiers] (
    [id] bigint IDENTITY(1,1) NOT NULL,
    [performance_id] bigint  NOT NULL,
    [name] nvarchar(255)  NOT NULL,
    [allocation_type] nvarchar(50)  NOT NULL,
    [capacity] int  NULL,
    [price] decimal(12,2)  NOT NULL,
    [currency] nvarchar(10)  NOT NULL,
    [seatmap_section] nvarchar(255)  NULL
);
GO

-- Creating table 'refunds'
CREATE TABLE [dbo].[refunds] (
    [id] bigint IDENTITY(1,1) NOT NULL,
    [payment_id] bigint  NOT NULL,
    [amount] decimal(12,2)  NOT NULL,
    [status] nvarchar(50)  NOT NULL,
    [provider_refund_id] nvarchar(255)  NULL,
    [processed_at] datetime  NULL
);
GO

-- Creating table 'search_queries'
CREATE TABLE [dbo].[search_queries] (
    [id] bigint IDENTITY(1,1) NOT NULL,
    [session_id] bigint  NOT NULL,
    [user_id] bigint  NULL,
    [city_id] bigint  NULL,
    [category_id] int  NULL,
    [venue_id] bigint  NULL,
    [date_from] datetime  NULL,
    [date_to] datetime  NULL,
    [text_query] nvarchar(max)  NULL,
    [created_at] datetime  NULL
);
GO

-- Creating table 'seat_holds'
CREATE TABLE [dbo].[seat_holds] (
    [id] bigint IDENTITY(1,1) NOT NULL,
    [performance_seat_id] bigint  NOT NULL,
    [cart_id] bigint  NOT NULL,
    [expires_at] datetime  NOT NULL
);
GO

-- Creating table 'seatmaps'
CREATE TABLE [dbo].[seatmaps] (
    [id] bigint IDENTITY(1,1) NOT NULL,
    [venue_id] bigint  NOT NULL,
    [name] nvarchar(255)  NULL,
    [layout_json] nvarchar(max)  NULL,
    [created_at] datetime  NULL
);
GO

-- Creating table 'seats'
CREATE TABLE [dbo].[seats] (
    [id] bigint IDENTITY(1,1) NOT NULL,
    [venue_id] bigint  NOT NULL,
    [seatmap_section] nvarchar(255)  NULL,
    [row_label] nvarchar(50)  NULL,
    [seat_number] nvarchar(50)  NULL,
    [is_wheelchair] bit  NULL
);
GO

-- Creating table 'sessions'
CREATE TABLE [dbo].[sessions] (
    [id] bigint IDENTITY(1,1) NOT NULL,
    [session_token] nvarchar(255)  NOT NULL,
    [user_id] bigint  NULL,
    [started_at] datetime  NULL,
    [expires_at] datetime  NULL
);
GO

-- Creating table 'sysdiagrams'
CREATE TABLE [dbo].[sysdiagrams] (
    [name] nvarchar(128)  NOT NULL,
    [principal_id] int  NOT NULL,
    [diagram_id] int IDENTITY(1,1) NOT NULL,
    [version] int  NULL,
    [definition] varbinary(max)  NULL
);
GO

-- Creating table 'theatre_details'
CREATE TABLE [dbo].[theatre_details] (
    [event_id] bigint  NOT NULL,
    [duration_min] int  NULL,
    [playwright] nvarchar(255)  NULL,
    [director] nvarchar(255)  NULL,
    [intermission_count] int  NULL
);
GO

-- Creating table 'theatre_genres'
CREATE TABLE [dbo].[theatre_genres] (
    [id] bigint IDENTITY(1,1) NOT NULL,
    [name] nvarchar(255)  NOT NULL
);
GO

-- Creating table 'tickets'
CREATE TABLE [dbo].[tickets] (
    [id] bigint IDENTITY(1,1) NOT NULL,
    [order_item_id] bigint  NOT NULL,
    [ticket_code] nvarchar(255)  NOT NULL,
    [qr_code_url] nvarchar(max)  NULL,
    [holder_name] nvarchar(255)  NULL,
    [status] nvarchar(50)  NOT NULL,
    [delivered_to_email] nvarchar(255)  NULL,
    [issued_at] datetime  NULL
);
GO

-- Creating table 'user_payment_methods'
CREATE TABLE [dbo].[user_payment_methods] (
    [id] bigint IDENTITY(1,1) NOT NULL,
    [user_id] bigint  NOT NULL,
    [provider] nvarchar(255)  NOT NULL,
    [token] nvarchar(255)  NOT NULL,
    [brand] nvarchar(50)  NULL,
    [last4] nvarchar(4)  NULL,
    [exp_month] int  NULL,
    [exp_year] int  NULL,
    [created_at] datetime  NULL
);
GO

-- Creating table 'users'
CREATE TABLE [dbo].[users] (
    [id] bigint IDENTITY(1,1) NOT NULL,
    [name] nvarchar(255)  NULL,
    [surname] nvarchar(255)  NULL,
    [email] nvarchar(255)  NOT NULL,
    [phone] nvarchar(50)  NULL,
    [password_hash] nvarchar(255)  NOT NULL,
    [created_at] datetime  NULL,
    [updated_at] datetime  NULL
);
GO

-- Creating table 'venues'
CREATE TABLE [dbo].[venues] (
    [id] bigint IDENTITY(1,1) NOT NULL,
    [city_id] bigint  NOT NULL,
    [name] nvarchar(255)  NOT NULL,
    [address] nvarchar(max)  NULL,
    [latitude] decimal(10,6)  NULL,
    [longitude] decimal(10,6)  NULL,
    [has_seating] bit  NOT NULL
);
GO

-- Creating table 'event_movie_genres'
CREATE TABLE [dbo].[event_movie_genres] (
    [events_id] bigint  NOT NULL,
    [movie_genres_id] bigint  NOT NULL
);
GO

-- Creating table 'event_music_genres'
CREATE TABLE [dbo].[event_music_genres] (
    [events_id] bigint  NOT NULL,
    [music_genres_id] bigint  NOT NULL
);
GO

-- Creating table 'event_theatre_genres'
CREATE TABLE [dbo].[event_theatre_genres] (
    [events_id] bigint  NOT NULL,
    [theatre_genres_id] bigint  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [id] in table 'admins'
ALTER TABLE [dbo].[admins]
ADD CONSTRAINT [PK_admins]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'cart_items'
ALTER TABLE [dbo].[cart_items]
ADD CONSTRAINT [PK_cart_items]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'carts'
ALTER TABLE [dbo].[carts]
ADD CONSTRAINT [PK_carts]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'categories'
ALTER TABLE [dbo].[categories]
ADD CONSTRAINT [PK_categories]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'cities'
ALTER TABLE [dbo].[cities]
ADD CONSTRAINT [PK_cities]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [event_id] in table 'concert_details'
ALTER TABLE [dbo].[concert_details]
ADD CONSTRAINT [PK_concert_details]
    PRIMARY KEY CLUSTERED ([event_id] ASC);
GO

-- Creating primary key on [id] in table 'events'
ALTER TABLE [dbo].[events]
ADD CONSTRAINT [PK_events]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'moderation_events'
ALTER TABLE [dbo].[moderation_events]
ADD CONSTRAINT [PK_moderation_events]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [event_id] in table 'movie_details'
ALTER TABLE [dbo].[movie_details]
ADD CONSTRAINT [PK_movie_details]
    PRIMARY KEY CLUSTERED ([event_id] ASC);
GO

-- Creating primary key on [id] in table 'movie_genres'
ALTER TABLE [dbo].[movie_genres]
ADD CONSTRAINT [PK_movie_genres]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'music_genres'
ALTER TABLE [dbo].[music_genres]
ADD CONSTRAINT [PK_music_genres]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'order_items'
ALTER TABLE [dbo].[order_items]
ADD CONSTRAINT [PK_order_items]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'orders'
ALTER TABLE [dbo].[orders]
ADD CONSTRAINT [PK_orders]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'organizer_applications'
ALTER TABLE [dbo].[organizer_applications]
ADD CONSTRAINT [PK_organizer_applications]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'organizer_documents'
ALTER TABLE [dbo].[organizer_documents]
ADD CONSTRAINT [PK_organizer_documents]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'organizer_users'
ALTER TABLE [dbo].[organizer_users]
ADD CONSTRAINT [PK_organizer_users]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'organizers'
ALTER TABLE [dbo].[organizers]
ADD CONSTRAINT [PK_organizers]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'payments'
ALTER TABLE [dbo].[payments]
ADD CONSTRAINT [PK_payments]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'performance_seats'
ALTER TABLE [dbo].[performance_seats]
ADD CONSTRAINT [PK_performance_seats]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'performances'
ALTER TABLE [dbo].[performances]
ADD CONSTRAINT [PK_performances]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'price_tiers'
ALTER TABLE [dbo].[price_tiers]
ADD CONSTRAINT [PK_price_tiers]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'refunds'
ALTER TABLE [dbo].[refunds]
ADD CONSTRAINT [PK_refunds]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'search_queries'
ALTER TABLE [dbo].[search_queries]
ADD CONSTRAINT [PK_search_queries]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'seat_holds'
ALTER TABLE [dbo].[seat_holds]
ADD CONSTRAINT [PK_seat_holds]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'seatmaps'
ALTER TABLE [dbo].[seatmaps]
ADD CONSTRAINT [PK_seatmaps]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'seats'
ALTER TABLE [dbo].[seats]
ADD CONSTRAINT [PK_seats]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'sessions'
ALTER TABLE [dbo].[sessions]
ADD CONSTRAINT [PK_sessions]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [diagram_id] in table 'sysdiagrams'
ALTER TABLE [dbo].[sysdiagrams]
ADD CONSTRAINT [PK_sysdiagrams]
    PRIMARY KEY CLUSTERED ([diagram_id] ASC);
GO

-- Creating primary key on [event_id] in table 'theatre_details'
ALTER TABLE [dbo].[theatre_details]
ADD CONSTRAINT [PK_theatre_details]
    PRIMARY KEY CLUSTERED ([event_id] ASC);
GO

-- Creating primary key on [id] in table 'theatre_genres'
ALTER TABLE [dbo].[theatre_genres]
ADD CONSTRAINT [PK_theatre_genres]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'tickets'
ALTER TABLE [dbo].[tickets]
ADD CONSTRAINT [PK_tickets]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'user_payment_methods'
ALTER TABLE [dbo].[user_payment_methods]
ADD CONSTRAINT [PK_user_payment_methods]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'users'
ALTER TABLE [dbo].[users]
ADD CONSTRAINT [PK_users]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'venues'
ALTER TABLE [dbo].[venues]
ADD CONSTRAINT [PK_venues]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [events_id], [movie_genres_id] in table 'event_movie_genres'
ALTER TABLE [dbo].[event_movie_genres]
ADD CONSTRAINT [PK_event_movie_genres]
    PRIMARY KEY CLUSTERED ([events_id], [movie_genres_id] ASC);
GO

-- Creating primary key on [events_id], [music_genres_id] in table 'event_music_genres'
ALTER TABLE [dbo].[event_music_genres]
ADD CONSTRAINT [PK_event_music_genres]
    PRIMARY KEY CLUSTERED ([events_id], [music_genres_id] ASC);
GO

-- Creating primary key on [events_id], [theatre_genres_id] in table 'event_theatre_genres'
ALTER TABLE [dbo].[event_theatre_genres]
ADD CONSTRAINT [PK_event_theatre_genres]
    PRIMARY KEY CLUSTERED ([events_id], [theatre_genres_id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [reviewed_by] in table 'moderation_events'
ALTER TABLE [dbo].[moderation_events]
ADD CONSTRAINT [FK__moderatio__revie__32AB8735]
    FOREIGN KEY ([reviewed_by])
    REFERENCES [dbo].[admins]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__moderatio__revie__32AB8735'
CREATE INDEX [IX_FK__moderatio__revie__32AB8735]
ON [dbo].[moderation_events]
    ([reviewed_by]);
GO

-- Creating foreign key on [reviewed_by_admin_id] in table 'organizer_applications'
ALTER TABLE [dbo].[organizer_applications]
ADD CONSTRAINT [FK__organizer__revie__2B0A656D]
    FOREIGN KEY ([reviewed_by_admin_id])
    REFERENCES [dbo].[admins]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__organizer__revie__2B0A656D'
CREATE INDEX [IX_FK__organizer__revie__2B0A656D]
ON [dbo].[organizer_applications]
    ([reviewed_by_admin_id]);
GO

-- Creating foreign key on [cart_id] in table 'cart_items'
ALTER TABLE [dbo].[cart_items]
ADD CONSTRAINT [FK__cart_item__cart___47DBAE45]
    FOREIGN KEY ([cart_id])
    REFERENCES [dbo].[carts]
        ([id])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__cart_item__cart___47DBAE45'
CREATE INDEX [IX_FK__cart_item__cart___47DBAE45]
ON [dbo].[cart_items]
    ([cart_id]);
GO

-- Creating foreign key on [session_id] in table 'carts'
ALTER TABLE [dbo].[carts]
ADD CONSTRAINT [FK__carts__session_i__4316F928]
    FOREIGN KEY ([session_id])
    REFERENCES [dbo].[sessions]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__carts__session_i__4316F928'
CREATE INDEX [IX_FK__carts__session_i__4316F928]
ON [dbo].[carts]
    ([session_id]);
GO

-- Creating foreign key on [user_id] in table 'carts'
ALTER TABLE [dbo].[carts]
ADD CONSTRAINT [FK__carts__user_id__4222D4EF]
    FOREIGN KEY ([user_id])
    REFERENCES [dbo].[users]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__carts__user_id__4222D4EF'
CREATE INDEX [IX_FK__carts__user_id__4222D4EF]
ON [dbo].[carts]
    ([user_id]);
GO

-- Creating foreign key on [cart_id] in table 'seat_holds'
ALTER TABLE [dbo].[seat_holds]
ADD CONSTRAINT [FK__seat_hold__cart___00200768]
    FOREIGN KEY ([cart_id])
    REFERENCES [dbo].[carts]
        ([id])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__seat_hold__cart___00200768'
CREATE INDEX [IX_FK__seat_hold__cart___00200768]
ON [dbo].[seat_holds]
    ([cart_id]);
GO

-- Creating foreign key on [category_id] in table 'events'
ALTER TABLE [dbo].[events]
ADD CONSTRAINT [FK__events__category__6FE99F9F]
    FOREIGN KEY ([category_id])
    REFERENCES [dbo].[categories]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__events__category__6FE99F9F'
CREATE INDEX [IX_FK__events__category__6FE99F9F]
ON [dbo].[events]
    ([category_id]);
GO

-- Creating foreign key on [city_id] in table 'venues'
ALTER TABLE [dbo].[venues]
ADD CONSTRAINT [FK__venues__city_id__5FB337D6]
    FOREIGN KEY ([city_id])
    REFERENCES [dbo].[cities]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__venues__city_id__5FB337D6'
CREATE INDEX [IX_FK__venues__city_id__5FB337D6]
ON [dbo].[venues]
    ([city_id]);
GO

-- Creating foreign key on [event_id] in table 'concert_details'
ALTER TABLE [dbo].[concert_details]
ADD CONSTRAINT [FK__concert_d__event__08B54D69]
    FOREIGN KEY ([event_id])
    REFERENCES [dbo].[events]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [organizer_id] in table 'events'
ALTER TABLE [dbo].[events]
ADD CONSTRAINT [FK__events__organize__70DDC3D8]
    FOREIGN KEY ([organizer_id])
    REFERENCES [dbo].[organizers]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__events__organize__70DDC3D8'
CREATE INDEX [IX_FK__events__organize__70DDC3D8]
ON [dbo].[events]
    ([organizer_id]);
GO

-- Creating foreign key on [event_id] in table 'moderation_events'
ALTER TABLE [dbo].[moderation_events]
ADD CONSTRAINT [FK__moderatio__event__30C33EC3]
    FOREIGN KEY ([event_id])
    REFERENCES [dbo].[events]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__moderatio__event__30C33EC3'
CREATE INDEX [IX_FK__moderatio__event__30C33EC3]
ON [dbo].[moderation_events]
    ([event_id]);
GO

-- Creating foreign key on [event_id] in table 'movie_details'
ALTER TABLE [dbo].[movie_details]
ADD CONSTRAINT [FK__movie_det__event__02FC7413]
    FOREIGN KEY ([event_id])
    REFERENCES [dbo].[events]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [event_id] in table 'performances'
ALTER TABLE [dbo].[performances]
ADD CONSTRAINT [FK__performan__event__74AE54BC]
    FOREIGN KEY ([event_id])
    REFERENCES [dbo].[events]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__performan__event__74AE54BC'
CREATE INDEX [IX_FK__performan__event__74AE54BC]
ON [dbo].[performances]
    ([event_id]);
GO

-- Creating foreign key on [event_id] in table 'theatre_details'
ALTER TABLE [dbo].[theatre_details]
ADD CONSTRAINT [FK__theatre_d__event__05D8E0BE]
    FOREIGN KEY ([event_id])
    REFERENCES [dbo].[events]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [submitted_by] in table 'moderation_events'
ALTER TABLE [dbo].[moderation_events]
ADD CONSTRAINT [FK__moderatio__submi__31B762FC]
    FOREIGN KEY ([submitted_by])
    REFERENCES [dbo].[organizer_users]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__moderatio__submi__31B762FC'
CREATE INDEX [IX_FK__moderatio__submi__31B762FC]
ON [dbo].[moderation_events]
    ([submitted_by]);
GO

-- Creating foreign key on [order_id] in table 'order_items'
ALTER TABLE [dbo].[order_items]
ADD CONSTRAINT [FK__order_ite__order__4F7CD00D]
    FOREIGN KEY ([order_id])
    REFERENCES [dbo].[orders]
        ([id])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__order_ite__order__4F7CD00D'
CREATE INDEX [IX_FK__order_ite__order__4F7CD00D]
ON [dbo].[order_items]
    ([order_id]);
GO

-- Creating foreign key on [order_item_id] in table 'tickets'
ALTER TABLE [dbo].[tickets]
ADD CONSTRAINT [FK__tickets__order_i__5441852A]
    FOREIGN KEY ([order_item_id])
    REFERENCES [dbo].[order_items]
        ([id])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__tickets__order_i__5441852A'
CREATE INDEX [IX_FK__tickets__order_i__5441852A]
ON [dbo].[tickets]
    ([order_item_id]);
GO

-- Creating foreign key on [session_id] in table 'orders'
ALTER TABLE [dbo].[orders]
ADD CONSTRAINT [FK__orders__session___4CA06362]
    FOREIGN KEY ([session_id])
    REFERENCES [dbo].[sessions]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__orders__session___4CA06362'
CREATE INDEX [IX_FK__orders__session___4CA06362]
ON [dbo].[orders]
    ([session_id]);
GO

-- Creating foreign key on [user_id] in table 'orders'
ALTER TABLE [dbo].[orders]
ADD CONSTRAINT [FK__orders__user_id__4BAC3F29]
    FOREIGN KEY ([user_id])
    REFERENCES [dbo].[users]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__orders__user_id__4BAC3F29'
CREATE INDEX [IX_FK__orders__user_id__4BAC3F29]
ON [dbo].[orders]
    ([user_id]);
GO

-- Creating foreign key on [order_id] in table 'payments'
ALTER TABLE [dbo].[payments]
ADD CONSTRAINT [FK__payments__order___571DF1D5]
    FOREIGN KEY ([order_id])
    REFERENCES [dbo].[orders]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__payments__order___571DF1D5'
CREATE INDEX [IX_FK__payments__order___571DF1D5]
ON [dbo].[payments]
    ([order_id]);
GO

-- Creating foreign key on [organizer_id] in table 'organizer_applications'
ALTER TABLE [dbo].[organizer_applications]
ADD CONSTRAINT [FK__organizer__organ__2A164134]
    FOREIGN KEY ([organizer_id])
    REFERENCES [dbo].[organizers]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__organizer__organ__2A164134'
CREATE INDEX [IX_FK__organizer__organ__2A164134]
ON [dbo].[organizer_applications]
    ([organizer_id]);
GO

-- Creating foreign key on [organizer_id] in table 'organizer_users'
ALTER TABLE [dbo].[organizer_users]
ADD CONSTRAINT [FK__organizer__organ__2645B050]
    FOREIGN KEY ([organizer_id])
    REFERENCES [dbo].[organizers]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__organizer__organ__2645B050'
CREATE INDEX [IX_FK__organizer__organ__2645B050]
ON [dbo].[organizer_users]
    ([organizer_id]);
GO

-- Creating foreign key on [payment_id] in table 'refunds'
ALTER TABLE [dbo].[refunds]
ADD CONSTRAINT [FK__refunds__payment__59FA5E80]
    FOREIGN KEY ([payment_id])
    REFERENCES [dbo].[payments]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__refunds__payment__59FA5E80'
CREATE INDEX [IX_FK__refunds__payment__59FA5E80]
ON [dbo].[refunds]
    ([payment_id]);
GO

-- Creating foreign key on [performance_id] in table 'performance_seats'
ALTER TABLE [dbo].[performance_seats]
ADD CONSTRAINT [FK__performan__perfo__7B5B524B]
    FOREIGN KEY ([performance_id])
    REFERENCES [dbo].[performances]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__performan__perfo__7B5B524B'
CREATE INDEX [IX_FK__performan__perfo__7B5B524B]
ON [dbo].[performance_seats]
    ([performance_id]);
GO

-- Creating foreign key on [seat_id] in table 'performance_seats'
ALTER TABLE [dbo].[performance_seats]
ADD CONSTRAINT [FK__performan__seat___7C4F7684]
    FOREIGN KEY ([seat_id])
    REFERENCES [dbo].[seats]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__performan__seat___7C4F7684'
CREATE INDEX [IX_FK__performan__seat___7C4F7684]
ON [dbo].[performance_seats]
    ([seat_id]);
GO

-- Creating foreign key on [performance_seat_id] in table 'seat_holds'
ALTER TABLE [dbo].[seat_holds]
ADD CONSTRAINT [FK__seat_hold__perfo__7F2BE32F]
    FOREIGN KEY ([performance_seat_id])
    REFERENCES [dbo].[performance_seats]
        ([id])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__seat_hold__perfo__7F2BE32F'
CREATE INDEX [IX_FK__seat_hold__perfo__7F2BE32F]
ON [dbo].[seat_holds]
    ([performance_seat_id]);
GO

-- Creating foreign key on [venue_id] in table 'performances'
ALTER TABLE [dbo].[performances]
ADD CONSTRAINT [FK__performan__venue__75A278F5]
    FOREIGN KEY ([venue_id])
    REFERENCES [dbo].[venues]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__performan__venue__75A278F5'
CREATE INDEX [IX_FK__performan__venue__75A278F5]
ON [dbo].[performances]
    ([venue_id]);
GO

-- Creating foreign key on [performance_id] in table 'price_tiers'
ALTER TABLE [dbo].[price_tiers]
ADD CONSTRAINT [FK__price_tie__perfo__787EE5A0]
    FOREIGN KEY ([performance_id])
    REFERENCES [dbo].[performances]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__price_tie__perfo__787EE5A0'
CREATE INDEX [IX_FK__price_tie__perfo__787EE5A0]
ON [dbo].[price_tiers]
    ([performance_id]);
GO

-- Creating foreign key on [session_id] in table 'search_queries'
ALTER TABLE [dbo].[search_queries]
ADD CONSTRAINT [FK__search_qu__sessi__1CBC4616]
    FOREIGN KEY ([session_id])
    REFERENCES [dbo].[sessions]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__search_qu__sessi__1CBC4616'
CREATE INDEX [IX_FK__search_qu__sessi__1CBC4616]
ON [dbo].[search_queries]
    ([session_id]);
GO

-- Creating foreign key on [venue_id] in table 'seatmaps'
ALTER TABLE [dbo].[seatmaps]
ADD CONSTRAINT [FK__seatmaps__venue___628FA481]
    FOREIGN KEY ([venue_id])
    REFERENCES [dbo].[venues]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__seatmaps__venue___628FA481'
CREATE INDEX [IX_FK__seatmaps__venue___628FA481]
ON [dbo].[seatmaps]
    ([venue_id]);
GO

-- Creating foreign key on [venue_id] in table 'seats'
ALTER TABLE [dbo].[seats]
ADD CONSTRAINT [FK__seats__venue_id__66603565]
    FOREIGN KEY ([venue_id])
    REFERENCES [dbo].[venues]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__seats__venue_id__66603565'
CREATE INDEX [IX_FK__seats__venue_id__66603565]
ON [dbo].[seats]
    ([venue_id]);
GO

-- Creating foreign key on [user_id] in table 'sessions'
ALTER TABLE [dbo].[sessions]
ADD CONSTRAINT [FK__sessions__user_i__3B75D760]
    FOREIGN KEY ([user_id])
    REFERENCES [dbo].[users]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__sessions__user_i__3B75D760'
CREATE INDEX [IX_FK__sessions__user_i__3B75D760]
ON [dbo].[sessions]
    ([user_id]);
GO

-- Creating foreign key on [user_id] in table 'user_payment_methods'
ALTER TABLE [dbo].[user_payment_methods]
ADD CONSTRAINT [FK__user_paym__user___3E52440B]
    FOREIGN KEY ([user_id])
    REFERENCES [dbo].[users]
        ([id])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__user_paym__user___3E52440B'
CREATE INDEX [IX_FK__user_paym__user___3E52440B]
ON [dbo].[user_payment_methods]
    ([user_id]);
GO

-- Creating foreign key on [events_id] in table 'event_movie_genres'
ALTER TABLE [dbo].[event_movie_genres]
ADD CONSTRAINT [FK_event_movie_genres_events]
    FOREIGN KEY ([events_id])
    REFERENCES [dbo].[events]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [movie_genres_id] in table 'event_movie_genres'
ALTER TABLE [dbo].[event_movie_genres]
ADD CONSTRAINT [FK_event_movie_genres_movie_genres]
    FOREIGN KEY ([movie_genres_id])
    REFERENCES [dbo].[movie_genres]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_event_movie_genres_movie_genres'
CREATE INDEX [IX_FK_event_movie_genres_movie_genres]
ON [dbo].[event_movie_genres]
    ([movie_genres_id]);
GO

-- Creating foreign key on [events_id] in table 'event_music_genres'
ALTER TABLE [dbo].[event_music_genres]
ADD CONSTRAINT [FK_event_music_genres_events]
    FOREIGN KEY ([events_id])
    REFERENCES [dbo].[events]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [music_genres_id] in table 'event_music_genres'
ALTER TABLE [dbo].[event_music_genres]
ADD CONSTRAINT [FK_event_music_genres_music_genres]
    FOREIGN KEY ([music_genres_id])
    REFERENCES [dbo].[music_genres]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_event_music_genres_music_genres'
CREATE INDEX [IX_FK_event_music_genres_music_genres]
ON [dbo].[event_music_genres]
    ([music_genres_id]);
GO

-- Creating foreign key on [events_id] in table 'event_theatre_genres'
ALTER TABLE [dbo].[event_theatre_genres]
ADD CONSTRAINT [FK_event_theatre_genres_events]
    FOREIGN KEY ([events_id])
    REFERENCES [dbo].[events]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [theatre_genres_id] in table 'event_theatre_genres'
ALTER TABLE [dbo].[event_theatre_genres]
ADD CONSTRAINT [FK_event_theatre_genres_theatre_genres]
    FOREIGN KEY ([theatre_genres_id])
    REFERENCES [dbo].[theatre_genres]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_event_theatre_genres_theatre_genres'
CREATE INDEX [IX_FK_event_theatre_genres_theatre_genres]
ON [dbo].[event_theatre_genres]
    ([theatre_genres_id]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------