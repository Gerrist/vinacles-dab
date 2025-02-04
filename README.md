# Vinacles DAB API

## Introduction

Since I currently only own a Macbook machine and Vinacles seem to use a Windows machines, I have decided to use Docker to
run the application. This way I can ensure that the application runs on any machine.
Also, I used the AdventureWorksDW2022 database instead of the provided AdventureWorks2022 database since the latter did not include the required tables. This is why some names may differ from the ones provided in the assignment.

## Requirements

- [x] GraphQL: http://localhost:5000/graphql/
- [x] Swagger: http://localhost:5000/swagger/index.html
- [x] Product entity: dab-config.json line 35
- [x] Category entity: dab-config.json line 61
- [x] SubCategory entity: dab-config.json line 87
- [x] New Account and FactFinance view
- [x] New stored procedure which searches on account ID and returns all sold items

## Project setup

1. Clone the repository
2. Ensure Docker Compose is installed
3. Run `docker compose up setup` to download en restore sample data. This step is required only once.
   once.
4. Run `docker compose up` to start the required containers for DAB.
5. Access GraphQL via http://localhost:5000/graphql/ or Swagger via http://localhost:5000/swagger/index.html

## Examples

Hint: You can also use the example requests in the /examples folder

### Get sold items by account id 16352

```
http://localhost:5000/api/GetSoldItemsByAccount?AccountID=16352
```

### Query sold items by account id 16352

```graphql
query {
   executeGetSoldItemsByAccount(AccountID: 16352) {
     AccountID
     ProductID
     Quantity
     ProductName
     Price
   } 
}
```

### Get first 4 account finance views

```
http://localhost:5000/api/AccountFinanceView?$first=4
```

### Query first 4 AccountFinanceViews

```graphql
query {
  accountFinanceViews(first: 4) {
    items {
      AccountKey
      AccountDescription
      Amount
      DateKey
    }
  } 
}
```

### Query account with ID 4' finances

```graphql
query {
  accountFinanceView_by_pk(AccountKey: 4) {
    AccountKey
    AccountDescription
    Amount
    DateKey
  } 
}
```
