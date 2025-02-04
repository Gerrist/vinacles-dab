RESTORE DATABASE AdventureWorksDW2022
FROM DISK = '/var/opt/mssql/backup/AdventureWorksDW2022.bak'
WITH MOVE 'AdventureWorksDW2022' TO '/var/opt/mssql/data/AdventureWorksDW2022.mdf',
MOVE 'AdventureWorksDW2022_log' TO '/var/opt/mssql/data/AdventureWorksDW2022.ldf',
REPLACE
GO

USE AdventureWorksDW2022
GO

CREATE VIEW AccountFinanceView AS
SELECT a.AccountKey, a.AccountDescription, f.Amount, f.DateKey
FROM DimAccount a
         INNER JOIN FactFinance f ON a.AccountKey = f.AccountKey;
GO

CREATE PROCEDURE GetSoldItemsByAccount @AccountID INT
AS
BEGIN
SELECT s.CustomerKey        as AccountID,
       p.ProductKey         as ProductID,
       s.OrderQuantity      as Quantity,
       p.EnglishProductName as ProductName,
       p.ListPrice          as Price
FROM FactInternetSales s
         INNER JOIN DimProduct p ON s.ProductKey = p.ProductKey
WHERE s.CustomerKey = @AccountID;
END;
GO