select * from [Person].[Person]

select PersonType, count(*) from [Person].[Person]
group by PersonType

select color, count(color) as Count_of_Product from [Production].[Product]
where color = 'Black' or color = 'Red'
group by color

select color, count(color) as Count_of_Product from [Production].[Product]
where color in ('Black', 'Red')
group by color

