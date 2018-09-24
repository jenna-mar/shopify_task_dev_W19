# Shopify - Backend Developer Internship Challenge - W2019

### Description

This project implements a Web API (documented [here](public/docs/index.html)) to model the following relationships:

1. Shops have many Products 
2. Shops have many Orders
3. Products have many Line Items
4. Orders have many Line Items

The solution fulfils all listed requirements of the [Shopify - Winter 2019 - Backend Developer Internship Challenge](https://docs.google.com/document/d/1YYDRf_CgQRryf5lZdkZ2o3Hm3erFSaISL1L1s8kLqsI/edit).

##### Bonus Features

  * API implemented in [GraphQL](https://graphql.org/) (rather than REST)
  * Full [CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete) operations supported across all models 
  * Core functionality [tested in RSpec](spec/)
  * Database (PostgreSQL btw) [seeded with meaningful data](db/seeds.rb)
  * Can be containerized locally with `docker-compose build` and `docker-compose up`

### Usage

Our GraphQL API is [documented in full](public/docs/index.html) and can be accessed on a local server at /docs (for example, http://localhost:3000/docs).
The API can be accessed locally at /graphql (for example, http://localhost:3000/graphql).

In example, one might retrieve the data model for a given customer, from the command-line (via `curl`) with the following GraphQL request:

```
$ curl -X POST -H "Content-Type: application/json" -d '{ "query": "{ shop(id: 1){name products{title}} " }' http://localhost:3000/graphql

{"data": {"shop": {"name":"Example Store 1", "products":[{"title":"Example Product"}] }}
```

### Developer Setup

#### Prerequisites

The command-line environment for installation requires:

  * [Ruby (>= v2.3.1)](https://www.ruby-lang.org/en/documentation/installation/)

#### Setup

From the project directory (assuming a [local clone](https://help.github.com/articles/cloning-a-repository/) of this repo):

* Install required gems via `bundle install`
* Seed & initialize the database via `rails db:setup`
* Instantiate a local server instance of the application via `rails server`

It should now be possible to query the live application, as per our deployed instance, at `localhost:3000` .

#### Testing

To run the entire test suite, simply execute `rspec spec`.

Similarly, to execute tests recursively under a given subdirectory, specify `rspec spec/path/to/subdirectory`.