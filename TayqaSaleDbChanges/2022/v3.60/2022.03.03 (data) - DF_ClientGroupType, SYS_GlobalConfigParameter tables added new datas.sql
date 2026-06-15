insert into DF_ClientGroupType(Type, Name)
values(10, 'DistributionGroup')

go

insert into SYS_GlobalConfigParameter(Name, Value, Description, Status, CreatedDate)
values('ItemGroupTypeForDistribution', 3, 'Item group type for distribution', 1, GETDATE()),
('ClientGroupTypeForDistribution', 10, 'Client group type for distribution', 1, GETDATE())
