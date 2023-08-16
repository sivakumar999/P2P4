create database Assignement04
on primary
(name = ExerciseDb_data,
filename = 'M:\Simplilearn\mphasis\Phase-2\day-4\Assign4\Asignment4_data.mdf')


--Drop table Products
create table Products (
    PId int identity(500, 1) primary key,
    PName nvarchar(255) not null,
    PPrice Float,
    PTax as (PPrice * 0.1) persisted,
    PCompany nvarchar(50) check (PCompany IN ('Samsung', 'Apple', 'Redmi', 'HTC', 'RealMe', 'Xiaomi')),
    PQty int default 10 check (PQty >= 1)
);

insert into Products (PName, PPrice, PCompany, PQty)
values
    ('TV', 10000, 'Samsung', 5),
    ('Mobile', 200000, 'Apple', 15),
    ('POCO', 25000, 'Redmi', 8),
    ('TV', 30000, 'HTC', 12),
    ('Laptop', 250000, 'RealMe', 10),
    ('Mobile', 18000, 'Xiaomi', 7),
    ('TV', 52000, 'Samsung', 9),
    ('Watch', 28000, 'Apple', 11),
    ('TV', 13000, 'Redmi', 6),
    ('Laptop', 35000, 'HTC', 14)

select * from Products
--------------------------------------
create proc usp_GPD
with encryption
as
begin
    select PId,PName,PPrice + PTax AS PriceWithTax,PCompany,(PQty * (PPrice + PTax)) as TotalPrice
    from Products
end

exec usp_GPD;

delete proc usp_GPD

----------------Procedure for tatal tax-------------------------------------
Create procedure usp_TotalTaxByCompany
    @PCompany nvarchar(50),
    @TotalTax Float Output
as
begin
    select @TotalTax = SUM(PTax)
    from Products
    where PCompany = @PCompany
end


declare @TotalTax Float
exec usp_GetTotalTaxByCompany
    @PCompany = 'Apple',
    @TotalTax = @TotalTax output;
select @TotalTax as TotalTax
