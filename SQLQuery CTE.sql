select * from [dbo].[public grn_data]

create view karan
as(
   ;WITH CTE(grn_no, item_no, custom_unique_key, [duplicate])
   AS (SELECT grn_no, item_no,custom_unique_key, ROW_NUMBER() OVER(PARTITION BY grn_no, item_no,custom_unique_key ORDER BY grn_no, item_no,custom_unique_key) AS [duplicate]
  FROM [dbo].[public grn_data])
  Select FROM CTE WHERE [duplicate] > 1;
)
select * from CTE;
SELECT * FROM CTE;
SELECT * INTO #PAYOUT_CTE_TMP FROM CTE

 ;WITH CTE(grn_no,[duplicate])
   AS (SELECT grn_no, ROW_NUMBER() OVER(PARTITION BY grn_no ORDER BY grn_no) AS [duplicate]
  FROM [dbo].[public grn_data])
  delete FROM CTE WHERE [duplicate] > 1;

  create view Vw_karan as
  (
  select * from  [dbo].[public grn_data]
  )

 ;WITH CTE(description,[duplicate])
   AS (SELECT description, ROW_NUMBER() OVER(PARTITION BY description ORDER BY description) AS [duplicate]
  FROM Vw_karan)
  delete FROM CTE WHERE [duplicate] > 1;
  select * from Vw_karan

  
select count(distinct(description)) from Vw_karan

  
Alter table [dbo].[public grn_data] alter column grn_registered_date datetime
Alter table [dbo].[public grn_data] alter column ok_qty float

select [rows].[description] as [description],
    count(1) as [Count]
from 
(
    select [description]
    from [dbo].[public grn_data] as [$Table]
) as [rows]
group by [description]

select [rows].[description] as [description],
    [rows].[grn_registered_date] as [grn_registered_date],
    sum([rows].[ok_qty]) as [Count]
from 
(
    select [description],
        [grn_registered_date],
        [ok_qty]
    from [dbo].[public grn_data] as [$Table]
) as [rows]
group by [description],
    [grn_registered_date]

SELECT [dbo].[ASN Data].No,[dbo].[ASN Data].ReleaseDatetime, [dbo].[ASN Data].Qty, [dbo].[public grn_data].grn_no, [dbo].[public grn_data].grn_registered_date,[dbo].[public grn_data].ok_qty
into Merged_ASN_GRN 
FROM [dbo].[ASN Data]
LEFT JOIN [dbo].[public grn_data] ON [dbo].[ASN Data].No = [dbo].[public grn_data].asn_no
where  [dbo].[public grn_data].grn_no is not null

select * from Merged_ASN_GRN

 ;WITH Merged_CTE
   AS (SELECT *, ROW_NUMBER() OVER(PARTITION BY Merged_ASN_GRN.No ORDER BY Merged_ASN_GRN.No) AS [duplicate]
  FROM Merged_ASN_GRN)
delete FROM Merged_CTE WHERE [duplicate] > 1;

;WITH CTE(description,[duplicate])
   AS (SELECT description, ROW_NUMBER() OVER(PARTITION BY description ORDER BY description) AS [duplicate]
  FROM Vw_karan)
  delete FROM CTE WHERE [duplicate] > 1;

select * from [dbo].[ASN Data]
select * from [dbo].[public grn_data]

----20 jan, 2023

select * from [dbo].[Merged_ASN_GRN]
select * from 
[dbo].[Vw_karan]


Alter table [dbo].[public grn_data] alter column ok_qty int

select description, grn_no, grn_registered_date, ok_qty,
sum(ok_qty) over(partition by description) as Total_QTY 
from [dbo].[public grn_data]

Select * from [dbo].[public grn_data]

select count (distinct description) from [dbo].[public grn_data]

select * from [dbo].[ASN Data]

select description, No, ReleaseDatetime, Qty,
sum(Qty) over(partition by description) as Total_QTY 
from [dbo].[ASN Data]

select description,No, sum(QTY) as Total_QTY  
from [dbo].[ASN Data]
group by description,No