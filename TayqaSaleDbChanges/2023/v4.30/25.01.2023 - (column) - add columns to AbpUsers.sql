ALTER TABLE AbpUsers
ADD LastActivatorDeactivatorUserId BigInt NULL;

ALTER TABLE AbpUsers
ADD LastActivationDeactivationDate DateTime NULL;
