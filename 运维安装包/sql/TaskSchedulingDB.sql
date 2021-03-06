USE [master]
GO
/****** Object:  Database [TaskSchedulingDB]    Script Date: 2017-05-25 16:53:08 ******/
CREATE DATABASE [TaskSchedulingDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TaskSchedulingDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\TaskSchedulingDB.mdf' , SIZE = 11264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TaskSchedulingDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\TaskSchedulingDB_log.ldf' , SIZE = 15040KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [TaskSchedulingDB] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TaskSchedulingDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TaskSchedulingDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TaskSchedulingDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TaskSchedulingDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TaskSchedulingDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TaskSchedulingDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [TaskSchedulingDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TaskSchedulingDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TaskSchedulingDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TaskSchedulingDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TaskSchedulingDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TaskSchedulingDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TaskSchedulingDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TaskSchedulingDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TaskSchedulingDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TaskSchedulingDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TaskSchedulingDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TaskSchedulingDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TaskSchedulingDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TaskSchedulingDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TaskSchedulingDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TaskSchedulingDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TaskSchedulingDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TaskSchedulingDB] SET RECOVERY FULL 
GO
ALTER DATABASE [TaskSchedulingDB] SET  MULTI_USER 
GO
ALTER DATABASE [TaskSchedulingDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TaskSchedulingDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TaskSchedulingDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TaskSchedulingDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [TaskSchedulingDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'TaskSchedulingDB', N'ON'
GO
USE [TaskSchedulingDB]
GO
/****** Object:  Table [dbo].[tb_commandlib]    Script Date: 2017-05-25 16:53:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_commandlib](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[commandfilename] [nvarchar](100) NOT NULL,
	[commandversion] [nvarchar](50) NOT NULL,
	[commandsrcfilepath] [nvarchar](500) NOT NULL,
	[commandsavefilepath] [nvarchar](200) NOT NULL,
	[createby] [int] NOT NULL,
	[createtime] [datetime] NOT NULL,
	[isdel] [int] NOT NULL,
 CONSTRAINT [PK_tb_commandlib] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_commandlibdetail]    Script Date: 2017-05-25 16:53:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_commandlibdetail](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[commandlibid] [int] NOT NULL CONSTRAINT [DF_tb_commandlibdetail_commandlibid]  DEFAULT ((0)),
	[commandname] [nvarchar](50) NOT NULL CONSTRAINT [DF_tb_commandlibdetail_commandname]  DEFAULT (''),
	[commanddescription] [nvarchar](200) NOT NULL CONSTRAINT [DF_tb_commandlibdetail_commanddescription]  DEFAULT (''),
	[commandnamespace] [nvarchar](500) NOT NULL CONSTRAINT [DF_tb_commandlibdetail_commandnamespace]  DEFAULT (''),
	[commandmainclassname] [nvarchar](500) NOT NULL CONSTRAINT [DF_tb_commandlibdetail_commandmainclassname]  DEFAULT (''),
	[commandparams] [nvarchar](max) NOT NULL CONSTRAINT [DF_tb_commandlibdetail_commandparams]  DEFAULT (''),
	[createby] [int] NOT NULL CONSTRAINT [DF_tb_commandlibdetail_createby]  DEFAULT ((0)),
	[createtime] [datetime] NOT NULL CONSTRAINT [DF_tb_commandlibdetail_createtime]  DEFAULT ('2099-12-30'),
	[isdel] [int] NOT NULL CONSTRAINT [DF_tb_commandlibdetail_isdel]  DEFAULT ((0)),
	[maxexeceptionretrycount] [int] NOT NULL CONSTRAINT [DF_tb_commandlibdetail_execeptionretrycount]  DEFAULT ((0)),
 CONSTRAINT [PK_tb_commandlibdetail] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_commandlog]    Script Date: 2017-05-25 16:53:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_commandlog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[msg] [nvarchar](max) NOT NULL,
	[logcreatetime] [datetime] NOT NULL,
	[nodeid] [int] NOT NULL,
	[commanddetailid] [int] NOT NULL CONSTRAINT [DF_tb_commandlog_commanddetailid]  DEFAULT ((0)),
	[commandparams] [nvarchar](max) NOT NULL CONSTRAINT [DF_tb_commandlog_commandparams]  DEFAULT (''),
	[commandstate] [int] NOT NULL CONSTRAINT [DF_tb_commandlog_commandstate]  DEFAULT ((0)),
	[commandstarttime] [datetime] NOT NULL CONSTRAINT [DF_tb_commandlog_commandstarttime]  DEFAULT ('2099-12-30'),
	[commandendtime] [datetime] NOT NULL CONSTRAINT [DF_tb_commandlog_commandendtime]  DEFAULT ('2099-12-30'),
	[totalruntime] [decimal](18, 2) NOT NULL CONSTRAINT [DF_tb_commandlog_totalruntime]  DEFAULT ((0)),
	[commandqueueid] [int] NOT NULL CONSTRAINT [DF_tb_commandlog_commandqueueid]  DEFAULT ((0)),
	[commandresult] [nvarchar](max) NOT NULL CONSTRAINT [DF_tb_commandlog_commandresult]  DEFAULT (''),
 CONSTRAINT [PK_tb_commandlog] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_commandqueue]    Script Date: 2017-05-25 16:53:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_commandqueue](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[commandmainclassname] [nvarchar](500) NOT NULL,
	[commanddetailid] [int] NOT NULL CONSTRAINT [DF_tb_commandqueue_commanddetailid]  DEFAULT ((0)),
	[commandstate] [int] NOT NULL CONSTRAINT [DF_tb_commandqueue_commandstate]  DEFAULT ((0)),
	[taskid] [int] NOT NULL,
	[taskversionid] [int] NOT NULL CONSTRAINT [DF_tb_commandqueue_taskversionid]  DEFAULT ((0)),
	[nodeid] [int] NOT NULL,
	[commandparams] [nvarchar](max) NOT NULL CONSTRAINT [DF_tb_commandqueue_commandparams]  DEFAULT (''),
	[createby] [int] NOT NULL CONSTRAINT [DF_tb_commandqueue_createby]  DEFAULT ((0)),
	[createtime] [datetime] NOT NULL CONSTRAINT [DF_tb_commandqueue_createtime]  DEFAULT (getdate()),
	[isdel] [int] NOT NULL CONSTRAINT [DF_tb_commandqueue_isdel]  DEFAULT ((0)),
	[failedcount] [int] NOT NULL CONSTRAINT [DF_tb_commandqueue_failedcount]  DEFAULT ((0)),
 CONSTRAINT [PK_tb_command] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_error]    Script Date: 2017-05-25 16:53:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_error](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[msg] [varchar](2000) NOT NULL,
	[errortype] [tinyint] NOT NULL,
	[errorcreatetime] [datetime] NOT NULL,
	[taskid] [int] NOT NULL,
	[nodeid] [int] NOT NULL,
 CONSTRAINT [PK_tb_error] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_log]    Script Date: 2017-05-25 16:53:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_log](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[msg] [nvarchar](max) NOT NULL CONSTRAINT [DF_tb_log_msg]  DEFAULT (''),
	[logtype] [int] NOT NULL CONSTRAINT [DF_tb_log_logtype]  DEFAULT ((0)),
	[logcreatetime] [datetime] NOT NULL,
	[taskid] [int] NOT NULL,
	[nodeid] [int] NOT NULL,
 CONSTRAINT [PK_tb_log] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_node]    Script Date: 2017-05-25 16:53:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_node](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nodename] [varchar](50) NOT NULL,
	[nodediscription] [nvarchar](max) NOT NULL CONSTRAINT [DF_tb_node_nodediscription]  DEFAULT (''),
	[nodelastmodifytime] [datetime] NOT NULL CONSTRAINT [DF_tb_node_nodecreatetime]  DEFAULT (getdate()),
	[nodeip] [varchar](20) NOT NULL,
	[nodelastupdatetime] [datetime] NOT NULL CONSTRAINT [DF_tb_node_nodelastupdatetime]  DEFAULT (getdate()),
	[ifcheckstate] [bit] NOT NULL CONSTRAINT [DF_tb_node_ifcheckstate]  DEFAULT ((0)),
	[nodecommanddllversion] [nvarchar](50) NOT NULL CONSTRAINT [DF_tb_node_nodecommanddllversion]  DEFAULT (''),
	[alarmtype] [int] NOT NULL CONSTRAINT [DF_tb_node_alarmtype]  DEFAULT ((0)),
	[alarmuserid] [nvarchar](max) NOT NULL CONSTRAINT [DF_tb_node_alarmuserid]  DEFAULT (''),
	[isenablealarm] [int] NOT NULL CONSTRAINT [DF_tb_node_isenablealarm]  DEFAULT ((0)),
	[refreshcommandqueuestatus] [int] NOT NULL CONSTRAINT [DF_tb_node_refreshcommandqueuestatus]  DEFAULT ((0)),
	[lastrefreshcommandqueuetime] [datetime] NOT NULL CONSTRAINT [DF_tb_node_lastrefreshcommandqueuetime]  DEFAULT (getdate()),
	[maxrefreshcommandqueuecount] [int] NOT NULL CONSTRAINT [DF_tb_node_maxrefreshcommandqueuecount]  DEFAULT ((100)),
	[nodestatus] [int] NOT NULL CONSTRAINT [DF_tb_node_nodestatus]  DEFAULT ((0)),
	[createby] [int] NOT NULL CONSTRAINT [DF_tb_node_createby]  DEFAULT ((0)),
	[isdel] [int] NOT NULL CONSTRAINT [DF_tb_node_isdel]  DEFAULT ((0)),
	[createtime] [datetime] NOT NULL CONSTRAINT [DF_tb_node_createtime]  DEFAULT (getdate()),
	[lastmaxid] [int] NOT NULL CONSTRAINT [DF_tb_node_lastmaxid]  DEFAULT ((-1)),
	[machinename] [nvarchar](500) NOT NULL CONSTRAINT [DF_tb_node_machinename]  DEFAULT (''),
	[performancecollectjson] [nvarchar](max) NOT NULL CONSTRAINT [DF_tb_node_performancecollectjson]  DEFAULT (''),
	[ifmonitor] [int] NOT NULL CONSTRAINT [DF_tb_node_ifmonitor]  DEFAULT ((1)),
 CONSTRAINT [PK_tb_node] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_nodeperformance]    Script Date: 2017-05-25 16:53:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_nodeperformance](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nodeid] [int] NOT NULL CONSTRAINT [DF_tb_nodeperformance_nodeid]  DEFAULT ((0)),
	[cpu] [float] NOT NULL CONSTRAINT [DF_tb_nodeperformance_cpu]  DEFAULT ((0)),
	[memory] [float] NOT NULL CONSTRAINT [DF_tb_nodeperformance_memory]  DEFAULT ((0)),
	[installdirsize] [float] NOT NULL CONSTRAINT [DF_tb_nodeperformance_installdirsize]  DEFAULT ((0)),
	[lastupdatetime] [datetime] NOT NULL CONSTRAINT [DF_tb_nodeperformance_lastupdatetime]  DEFAULT (getdate()),
	[networkupload] [float] NOT NULL CONSTRAINT [DF_tb_nodeperformance_networkupload]  DEFAULT ((0)),
	[networkdownload] [float] NOT NULL CONSTRAINT [DF_tb_nodeperformance_networkdownload]  DEFAULT ((0)),
	[ioread] [float] NOT NULL CONSTRAINT [DF_tb_nodeperformance_ioread]  DEFAULT ((0)),
	[iowrite] [float] NOT NULL CONSTRAINT [DF_tb_nodeperformance_iowrite]  DEFAULT ((0)),
	[iisrequest] [float] NOT NULL CONSTRAINT [DF_tb_nodeperformance_iisrequest]  DEFAULT ((0)),
 CONSTRAINT [PK_tb_nodeperformance] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_performance]    Script Date: 2017-05-25 16:53:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_performance](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nodeid] [int] NOT NULL CONSTRAINT [DF_tb_performance_nodeid]  DEFAULT ((0)),
	[taskid] [int] NOT NULL CONSTRAINT [DF_tb_performance_taskid]  DEFAULT ((0)),
	[cpu] [float] NOT NULL CONSTRAINT [DF_tb_performance_cpu]  DEFAULT ((0)),
	[memory] [float] NOT NULL CONSTRAINT [DF_tb_performance_memory]  DEFAULT ((0)),
	[installdirsize] [float] NOT NULL CONSTRAINT [DF_tb_performance_installdirsize]  DEFAULT ((0)),
	[lastupdatetime] [datetime] NOT NULL CONSTRAINT [DF_tb_performance_lastupdatetime]  DEFAULT (getdate()),
 CONSTRAINT [PK_tb_performance] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_refreshcommadqueuelog]    Script Date: 2017-05-25 16:53:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_refreshcommadqueuelog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[msg] [nvarchar](max) NOT NULL,
	[logtype] [tinyint] NOT NULL,
	[logcreatetime] [datetime] NOT NULL,
	[taskid] [int] NOT NULL,
	[nodeid] [int] NOT NULL,
 CONSTRAINT [PK_tb_refreshcommadqueuelog] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_task]    Script Date: 2017-05-25 16:53:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_task](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[taskname] [varchar](50) NOT NULL CONSTRAINT [DF_tb_task_taskname]  DEFAULT (''),
	[taskdescription] [varchar](50) NOT NULL CONSTRAINT [DF_tb_task_taskdescription]  DEFAULT (''),
	[tasknamespace] [varchar](200) NOT NULL CONSTRAINT [DF_tb_task_tasknamespace]  DEFAULT (''),
	[taskclassname] [varchar](100) NOT NULL CONSTRAINT [DF_tb_task_taskclassname]  DEFAULT (''),
	[groupid] [int] NOT NULL CONSTRAINT [DF_tb_task_categoryid]  DEFAULT ((0)),
	[isdel] [int] NOT NULL CONSTRAINT [DF_tb_task_isdel]  DEFAULT ((0)),
	[createby] [int] NOT NULL CONSTRAINT [DF_tb_task_createby]  DEFAULT ((0)),
	[createtime] [datetime] NOT NULL CONSTRAINT [DF_tb_task_createtime]  DEFAULT (getdate()),
	[taskschedulestatus] [int] NOT NULL CONSTRAINT [DF_tb_task_taskschedulestatus]  DEFAULT ((0)),
	[taskremark] [nvarchar](200) NOT NULL CONSTRAINT [DF_tb_task_taskremark]  DEFAULT (''),
	[ispauseschedule] [int] NOT NULL CONSTRAINT [DF_tb_task_ispauseschedule]  DEFAULT ((0)),
	[alarmtype] [int] NOT NULL CONSTRAINT [DF_tb_task_alarmtype]  DEFAULT ((0)),
	[alarmuserid] [nvarchar](max) NOT NULL CONSTRAINT [DF_tb_task_alarmuserid]  DEFAULT (''),
	[isenablealarm] [int] NOT NULL CONSTRAINT [DF_tb_task_isenablealarm]  DEFAULT ((0)),
	[tasktype] [int] NOT NULL CONSTRAINT [DF_tb_task_tasktype]  DEFAULT ((0)),
	[nextruntime] [datetime] NOT NULL CONSTRAINT [DF_tb_task_nextruntime]  DEFAULT ('2099-12-30'),
 CONSTRAINT [PK_TB_TASK] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_taskgroup]    Script Date: 2017-05-25 16:53:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_taskgroup](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[groupname] [nvarchar](50) NOT NULL,
	[createby] [int] NOT NULL,
	[createtime] [datetime] NOT NULL,
	[isdel] [int] NOT NULL,
 CONSTRAINT [PK_tb_category] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_tasklog]    Script Date: 2017-05-25 16:53:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_tasklog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[logmsg] [nvarchar](max) NOT NULL CONSTRAINT [DF_tb_tasklog_logmsg]  DEFAULT (''),
	[logcreatetime] [datetime] NOT NULL,
	[nodeid] [int] NOT NULL,
	[taskid] [int] NOT NULL CONSTRAINT [DF_tb_tasklog_taskid]  DEFAULT ((0)),
	[taskversionid] [int] NOT NULL CONSTRAINT [DF_tb_tasklog_taskversionid]  DEFAULT ((0)),
	[taskparams] [nvarchar](max) NOT NULL CONSTRAINT [DF_tb_tasklog_taskparams]  DEFAULT (''),
	[taskstatus] [int] NOT NULL CONSTRAINT [DF_tb_tasklog_taskstatus]  DEFAULT ((0)),
	[taskstarttime] [datetime] NOT NULL CONSTRAINT [DF_tb_tasklog_taskstarttime]  DEFAULT ('2099-12-30'),
	[taskendtime] [datetime] NOT NULL CONSTRAINT [DF_tb_tasklog_taskendtime]  DEFAULT ('2099-12-30'),
	[totalruntime] [decimal](18, 2) NOT NULL,
	[taskrunresult] [nvarchar](max) NOT NULL CONSTRAINT [DF_tb_tasklog_taskrunresult]  DEFAULT (''),
	[nextruntime] [datetime] NOT NULL CONSTRAINT [DF_tb_tasklog_nextruntime]  DEFAULT ('2099-12-30'),
 CONSTRAINT [PK_tb_tasklog] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_taskversion]    Script Date: 2017-05-25 16:53:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_taskversion](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[taskid] [int] NOT NULL,
	[version] [int] NOT NULL,
	[versioncreatetime] [datetime] NOT NULL,
	[zipfile] [image] NOT NULL,
	[zipfilename] [varchar](100) NOT NULL,
	[taskparams] [nvarchar](max) NOT NULL CONSTRAINT [DF_tb_version_taskparams]  DEFAULT (''),
	[isdel] [int] NOT NULL CONSTRAINT [DF_tb_version_isdel]  DEFAULT ((0)),
	[createby] [int] NOT NULL CONSTRAINT [DF_tb_version_createby]  DEFAULT ((0)),
	[createtime] [datetime] NOT NULL CONSTRAINT [DF_tb_version_createtime]  DEFAULT (getdate()),
	[taskcreatetime] [datetime] NOT NULL CONSTRAINT [DF_tb_taskversion_taskcreatetime]  DEFAULT ('2099-12-30'),
	[taskupdatetime] [datetime] NOT NULL CONSTRAINT [DF_tb_taskversion_taskupdatetime]  DEFAULT ('2099-12-30'),
	[tasklaststarttime] [datetime] NOT NULL CONSTRAINT [DF_tb_taskversion_tasklaststarttime]  DEFAULT ('2099-12-30'),
	[tasklastendtime] [datetime] NOT NULL CONSTRAINT [DF_tb_taskversion_tasklastendtime]  DEFAULT ('2099-12-30'),
	[taskerrorcount] [int] NOT NULL CONSTRAINT [DF_tb_taskversion_taskerrorcount]  DEFAULT ((0)),
	[taskruncount] [int] NOT NULL CONSTRAINT [DF_tb_taskversion_taskruncount]  DEFAULT ((0)),
	[taskfailedcount] [int] NOT NULL CONSTRAINT [DF_tb_taskversion_taskfailedcount]  DEFAULT ((0)),
	[tasksucesscount] [int] NOT NULL CONSTRAINT [DF_tb_taskversion_tasksucesscount]  DEFAULT ((0)),
	[taskrunstatus] [int] NOT NULL CONSTRAINT [DF_tb_taskversion_lasttaskstatus]  DEFAULT ((0)),
	[tasklasterrortime] [datetime] NOT NULL CONSTRAINT [DF_tb_taskversion_tasklasterrortime]  DEFAULT ('2099-12-30'),
	[taskcron] [nvarchar](200) NOT NULL CONSTRAINT [DF_tb_taskversion_taskcron]  DEFAULT (''),
	[nodeid] [int] NOT NULL CONSTRAINT [DF_tb_taskversion_nodeid]  DEFAULT ((0)),
 CONSTRAINT [PK_tb_version] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_tempdata]    Script Date: 2017-05-25 16:53:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_tempdata](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[taskid] [int] NOT NULL,
	[tempdatajson] [varchar](500) NOT NULL,
	[tempdatalastupdatetime] [datetime] NOT NULL,
 CONSTRAINT [PK_tb_tempdata] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_user]    Script Date: 2017-05-25 16:53:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_user](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userpassword] [varchar](50) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[userrole] [int] NOT NULL,
	[userupdatetime] [datetime] NOT NULL,
	[usermobile] [varchar](20) NOT NULL,
	[useremail] [varchar](50) NOT NULL,
	[realname] [nvarchar](50) NOT NULL CONSTRAINT [DF_tb_user_realname]  DEFAULT (''),
	[isdel] [int] NOT NULL CONSTRAINT [DF_tb_user_isdel]  DEFAULT ((0)),
	[createby] [int] NOT NULL CONSTRAINT [DF_tb_user_createby]  DEFAULT ((0)),
	[createtime] [datetime] NOT NULL CONSTRAINT [DF_tb_user_createtime]  DEFAULT (getdate()),
 CONSTRAINT [PK_tb_user] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Index [IX_tb_command_nodeid]    Script Date: 2017-05-25 16:53:08 ******/
CREATE NONCLUSTERED INDEX [IX_tb_command_nodeid] ON [dbo].[tb_commandqueue]
(
	[nodeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_tb_error_errorcreatetime]    Script Date: 2017-05-25 16:53:08 ******/
CREATE NONCLUSTERED INDEX [IX_tb_error_errorcreatetime] ON [dbo].[tb_error]
(
	[errorcreatetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_tb_error_errortype]    Script Date: 2017-05-25 16:53:08 ******/
CREATE NONCLUSTERED INDEX [IX_tb_error_errortype] ON [dbo].[tb_error]
(
	[errortype] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_tb_log_logcreatetime]    Script Date: 2017-05-25 16:53:08 ******/
CREATE NONCLUSTERED INDEX [IX_tb_log_logcreatetime] ON [dbo].[tb_log]
(
	[logcreatetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_tb_performance_taskid]    Script Date: 2017-05-25 16:53:08 ******/
CREATE NONCLUSTERED INDEX [IX_tb_performance_taskid] ON [dbo].[tb_performance]
(
	[taskid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_tb_version_taskid]    Script Date: 2017-05-25 16:53:08 ******/
CREATE NONCLUSTERED INDEX [IX_tb_version_taskid] ON [dbo].[tb_taskversion]
(
	[taskid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_tb_version_version]    Script Date: 2017-05-25 16:53:08 ******/
CREATE NONCLUSTERED INDEX [IX_tb_version_version] ON [dbo].[tb_taskversion]
(
	[version] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_tb_tempdata_taskid]    Script Date: 2017-05-25 16:53:08 ******/
CREATE NONCLUSTERED INDEX [IX_tb_tempdata_taskid] ON [dbo].[tb_tempdata]
(
	[taskid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tb_commandlib] ADD  CONSTRAINT [DF_tb_commandlib_commandfilename]  DEFAULT ('') FOR [commandfilename]
GO
ALTER TABLE [dbo].[tb_commandlib] ADD  CONSTRAINT [DF_tb_commandlib_commandversion]  DEFAULT ('') FOR [commandversion]
GO
ALTER TABLE [dbo].[tb_commandlib] ADD  CONSTRAINT [DF_Table_1_commandfilepath]  DEFAULT ('') FOR [commandsrcfilepath]
GO
ALTER TABLE [dbo].[tb_commandlib] ADD  CONSTRAINT [DF_tb_commandlib_commandsavefilepath]  DEFAULT ('') FOR [commandsavefilepath]
GO
ALTER TABLE [dbo].[tb_commandlib] ADD  CONSTRAINT [DF_tb_commandlib_isdel]  DEFAULT ((0)) FOR [isdel]
GO
ALTER TABLE [dbo].[tb_taskgroup] ADD  CONSTRAINT [DF_tb_category_categoryname]  DEFAULT ('') FOR [groupname]
GO
ALTER TABLE [dbo].[tb_taskgroup] ADD  CONSTRAINT [DF_tb_category_createby]  DEFAULT ((0)) FOR [createby]
GO
ALTER TABLE [dbo].[tb_taskgroup] ADD  CONSTRAINT [DF_tb_category_isdel]  DEFAULT ((0)) FOR [isdel]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'命令文件名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandlib', @level2type=N'COLUMN',@level2name=N'commandfilename'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'命令版本信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandlib', @level2type=N'COLUMN',@level2name=N'commandversion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'命令dll本地path' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandlib', @level2type=N'COLUMN',@level2name=N'commandsrcfilepath'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'命令保存文件路径,根据此路径找寻dll' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandlib', @level2type=N'COLUMN',@level2name=N'commandsavefilepath'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否删除' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandlib', @level2type=N'COLUMN',@level2name=N'isdel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'命令库id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandlibdetail', @level2type=N'COLUMN',@level2name=N'commandlibid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'命令名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandlibdetail', @level2type=N'COLUMN',@level2name=N'commandname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'命令描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandlibdetail', @level2type=N'COLUMN',@level2name=N'commanddescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'命令命名空间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandlibdetail', @level2type=N'COLUMN',@level2name=N'commandnamespace'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'命令class类名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandlibdetail', @level2type=N'COLUMN',@level2name=N'commandmainclassname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'命令参数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandlibdetail', @level2type=N'COLUMN',@level2name=N'commandparams'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最大异常重试次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandlibdetail', @level2type=N'COLUMN',@level2name=N'maxexeceptionretrycount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'命令详情id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandlog', @level2type=N'COLUMN',@level2name=N'commanddetailid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当前执行命令所需参数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandlog', @level2type=N'COLUMN',@level2name=N'commandparams'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0-正常 1- 失败 2-异常' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandlog', @level2type=N'COLUMN',@level2name=N'commandstate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'命令开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandlog', @level2type=N'COLUMN',@level2name=N'commandstarttime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'命令结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandlog', @level2type=N'COLUMN',@level2name=N'commandendtime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分钟为单位，总运行时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandlog', @level2type=N'COLUMN',@level2name=N'totalruntime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'命令队列id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandlog', @level2type=N'COLUMN',@level2name=N'commandqueueid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'命令结果' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandlog', @level2type=N'COLUMN',@level2name=N'commandresult'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'命令名，参考代码枚举' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandqueue', @level2type=N'COLUMN',@level2name=N'commandmainclassname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'命令详情id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandqueue', @level2type=N'COLUMN',@level2name=N'commanddetailid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'命令执行状态，参考代码枚举 0-未执行 1-执行中 2-执行成功 3-执行错误' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandqueue', @level2type=N'COLUMN',@level2name=N'commandstate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandqueue', @level2type=N'COLUMN',@level2name=N'taskid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务版本id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandqueue', @level2type=N'COLUMN',@level2name=N'taskversionid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'节点id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandqueue', @level2type=N'COLUMN',@level2name=N'nodeid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当前执行命令所需参数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandqueue', @level2type=N'COLUMN',@level2name=N'commandparams'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandqueue', @level2type=N'COLUMN',@level2name=N'createby'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandqueue', @level2type=N'COLUMN',@level2name=N'createtime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0-不删除 1-删除' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandqueue', @level2type=N'COLUMN',@level2name=N'isdel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'失败次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_commandqueue', @level2type=N'COLUMN',@level2name=N'failedcount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0-节点日志 1-任务日志' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_log', @level2type=N'COLUMN',@level2name=N'logtype'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'节点对应命令dll版本' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_node', @level2type=N'COLUMN',@level2name=N'nodecommanddllversion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'报警类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_node', @level2type=N'COLUMN',@level2name=N'alarmtype'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'报警用户id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_node', @level2type=N'COLUMN',@level2name=N'alarmuserid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0-不启用 1-启用' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_node', @level2type=N'COLUMN',@level2name=N'isenablealarm'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刷新命令队列状态 0-未执行 1-循环中 ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_node', @level2type=N'COLUMN',@level2name=N'refreshcommandqueuestatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'上次刷新队列时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_node', @level2type=N'COLUMN',@level2name=N'lastrefreshcommandqueuetime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'每次最大刷取多少命令执行' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_node', @level2type=N'COLUMN',@level2name=N'maxrefreshcommandqueuecount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'节点状态 :0-停止 1-运行中' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_node', @level2type=N'COLUMN',@level2name=N'nodestatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_node', @level2type=N'COLUMN',@level2name=N'createby'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否删除' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_node', @level2type=N'COLUMN',@level2name=N'isdel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'保存上次取得命令最大值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_node', @level2type=N'COLUMN',@level2name=N'lastmaxid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'计算机名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_node', @level2type=N'COLUMN',@level2name=N'machinename'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'性能收集json：[' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_node', @level2type=N'COLUMN',@level2name=N'performancecollectjson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1-监控 0-不监控' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_node', @level2type=N'COLUMN',@level2name=N'ifmonitor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'节点编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_nodeperformance', @level2type=N'COLUMN',@level2name=N'nodeid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'网络发送' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_nodeperformance', @level2type=N'COLUMN',@level2name=N'networkupload'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'网络下载' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_nodeperformance', @level2type=N'COLUMN',@level2name=N'networkdownload'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'io读' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_nodeperformance', @level2type=N'COLUMN',@level2name=N'ioread'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'io 写' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_nodeperformance', @level2type=N'COLUMN',@level2name=N'iowrite'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'iis请求' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_nodeperformance', @level2type=N'COLUMN',@level2name=N'iisrequest'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_task', @level2type=N'COLUMN',@level2name=N'taskname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_task', @level2type=N'COLUMN',@level2name=N'taskdescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务命名空间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_task', @level2type=N'COLUMN',@level2name=N'tasknamespace'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务类名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_task', @level2type=N'COLUMN',@level2name=N'taskclassname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'范畴id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_task', @level2type=N'COLUMN',@level2name=N'groupid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否删除' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_task', @level2type=N'COLUMN',@level2name=N'isdel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_task', @level2type=N'COLUMN',@level2name=N'createby'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0-未调度 1-调度中 ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_task', @level2type=N'COLUMN',@level2name=N'taskschedulestatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_task', @level2type=N'COLUMN',@level2name=N'taskremark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0-不暂停调度 1-暂停调度' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_task', @level2type=N'COLUMN',@level2name=N'ispauseschedule'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'报警类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_task', @level2type=N'COLUMN',@level2name=N'alarmtype'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'报警用户id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_task', @level2type=N'COLUMN',@level2name=N'alarmuserid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0-不启用 1-启用' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_task', @level2type=N'COLUMN',@level2name=N'isenablealarm'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0-调度任务 1-单次任务' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_task', @level2type=N'COLUMN',@level2name=N'tasktype'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'下次运行时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_task', @level2type=N'COLUMN',@level2name=N'nextruntime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_task'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务范畴名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_taskgroup', @level2type=N'COLUMN',@level2name=N'groupname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'当前任务执行的日志消息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_tasklog', @level2type=N'COLUMN',@level2name=N'logmsg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务id 关联任务表tb_task' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_tasklog', @level2type=N'COLUMN',@level2name=N'taskid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务版本id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_tasklog', @level2type=N'COLUMN',@level2name=N'taskversionid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务参数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_tasklog', @level2type=N'COLUMN',@level2name=N'taskparams'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务状态 0-未执行 1-执行中 2-执行成功 3-执行失败' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_tasklog', @level2type=N'COLUMN',@level2name=N'taskstatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务运行结果' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_tasklog', @level2type=N'COLUMN',@level2name=N'taskrunresult'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'下次运行时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_tasklog', @level2type=N'COLUMN',@level2name=N'nextruntime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'压缩文件二进制文件' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_taskversion', @level2type=N'COLUMN',@level2name=N'zipfile'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务参数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_taskversion', @level2type=N'COLUMN',@level2name=N'taskparams'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否删除' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_taskversion', @level2type=N'COLUMN',@level2name=N'isdel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_taskversion', @level2type=N'COLUMN',@level2name=N'createby'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_taskversion', @level2type=N'COLUMN',@level2name=N'taskcreatetime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务更新时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_taskversion', @level2type=N'COLUMN',@level2name=N'taskupdatetime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务上次开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_taskversion', @level2type=N'COLUMN',@level2name=N'tasklaststarttime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务上次结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_taskversion', @level2type=N'COLUMN',@level2name=N'tasklastendtime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务出错次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_taskversion', @level2type=N'COLUMN',@level2name=N'taskerrorcount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务运行次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_taskversion', @level2type=N'COLUMN',@level2name=N'taskruncount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务失败次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_taskversion', @level2type=N'COLUMN',@level2name=N'taskfailedcount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务成功次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_taskversion', @level2type=N'COLUMN',@level2name=N'tasksucesscount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最后一次任务执行状态:0 -未执行 1-执行中 2-执行完成' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_taskversion', @level2type=N'COLUMN',@level2name=N'taskrunstatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务上次出错时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_taskversion', @level2type=N'COLUMN',@level2name=N'tasklasterrortime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务所需taskcron表达式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_taskversion', @level2type=N'COLUMN',@level2name=N'taskcron'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'节点id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_taskversion', @level2type=N'COLUMN',@level2name=N'nodeid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'员工工号，也是前台web.config里面配置的登陆用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_user', @level2type=N'COLUMN',@level2name=N'userpassword'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'员工角色，查看代码枚举：开发人员，管理员' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_user', @level2type=N'COLUMN',@level2name=N'userrole'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'员工手机号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_user', @level2type=N'COLUMN',@level2name=N'usermobile'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'真名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_user', @level2type=N'COLUMN',@level2name=N'realname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否删除' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_user', @level2type=N'COLUMN',@level2name=N'isdel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_user', @level2type=N'COLUMN',@level2name=N'createby'
GO
USE [master]
GO
ALTER DATABASE [TaskSchedulingDB] SET  READ_WRITE 
GO
