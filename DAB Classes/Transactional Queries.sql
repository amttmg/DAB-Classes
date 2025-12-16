
CREATE TABLE [dbo].[Students1](
	[id] [int] NOT NULL,
	[name] [varchar](50) NULL,
	[address] [varchar](50) NULL,
	[phone] [varchar](50) NULL,
 CONSTRAINT [PK_Students1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


insert into Students1 values(1, 'Amrit Tamang', 'Kathmandu', '9842411793');
insert into Students1 values(2, 'Suman Subedi', 'Lalitpur', '9804009448')

delete from students1;

select * from Students1;