USE [BikeStores]
GO
/****** Object:  StoredProcedure [dbo].[OrdersReport]    Script Date: 01-02-2024 15:51:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 ALTER   Procedure [dbo].[OrdersReport](@TopN int)

 as 

 begin

 with CTE as 
 (
     select  
	 C.[Name], C.CategoryID, sum(P.ListPrice) as Total_Price,
	 rank() over (order by sum(P.ListPrice)) as [Rank]
	 from [Production].[Product] P
	 inner join [Production].[Category] C
	 on P.CategoryID = C.CategoryID
	 group by C.[Name], C.CategoryID
)
select *
from CTE
where [Rank] <= @TopN

end