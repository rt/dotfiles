# Migrations

https://www.brunton-spall.co.uk/post/2014/05/06/database-migrations-done-right/
https://nickcraver.com/blog/2016/05/03/stack-overflow-how-we-do-deployment-2016-edition/#database-migrations

**Migrators**
https://www.npmjs.com/package/postgres-migrations
https://www.npmjs.com/package/node-pg-migrate
... could roll your own too


Database migrations provide a way to have a no-downtime database, but there is
a process cost.

In general, you have a dependency relationship with a provider and consumer and
basic rules are but always think it out.

- Add: Do on provider first
- Delete: Do on consumer first. 
- Move/Rename: Basically, an Add, then Delete

Note, sometimes the provider runs something based on values of the consumer in
which the consumer becomes the source (they can have a two-way relationship)
Often, where app code is specifying something in database.

### Basics

- Run pre migrations, then run tests on master (not your branch)
- Checkout your branch and run tests (with current pre migration run)
- Run post migrations and run tests (you've probably already done this to dev own branch)

- Make a commit for pre-migrations
- Make a commit for code
- Make a commit for post-migrations
