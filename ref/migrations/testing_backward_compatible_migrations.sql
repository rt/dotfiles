There might be different approaches that you could take to test for backward compatibility of your migrations.

Here's one approach, considering that you have Repository Tests for the tables that are being affected by your migration:

Checkout target_release - 1 branch
Apply your PRE migrations on unittest DB with version = target_release - 1 (e.g. if your migration is a client migration,  targeted for 16.2 release, you should run your PRE migrations in your 16.1 unittest client DB: lalyta_unittest_db_161)
Run Repository Related Tests (since repositories are part of the core module, you could simply do: cd core && mvn clean install to run all tests in core)

Checkout your story / bug branch were your code changes are (e.g. checkout story_12345_my_super_tp)

Run Repository Related Tests (since repositories are part of the core module, you could simply do: cd core && mvn clean install to run all tests in core)
 Apply your POST migration on unittest DB with version = target_release  (e.g. if your migration is a client migration,  targeted for 16.2 release, you should run your POST migrations in your 16.2 unittest client DB: lalyta_unittest_db_162)
Run Repository Related Tests (since repositories are part of the core module, you could simply do: cd core && mvn clean install to run all tests in core)

Notes:

This approach is useful when you have PRE + POST migrations involved in your changes, for example: renaming a column name, changing a column type.
Why do we apply migrations on unittest DBS? Re: This is because unittest DBs can be easily re-created using the ant createdbs target, so that your DBs can go back to a clean state. 
Steps 2 and 3 - Simulate the state in production when we haven't pushed the NEW release code and PRE Migrations are applied. For example: Production Code = 16.1 code + 16.1 DB + 16.2 PRE Migrations 
Step 3 - You could run the automation test smoke suite to verify that you haven't broken any main functionality. You could also run all the test suite if you like (from dev root directory instead of core)
Steps 4 and 5 - Simulate the state in production when we have pushed the NEW release code and PRE Migrations have been applied. For example: Production Code = 16.2 + 16.1 DB + 16.2 PRE Migrations
Step 4. Same than point 3. And, also, if you have wrote automation tests for your story / bug:
You could apply the PRE Migrations to your automation_client DB and run your automation tests to verify that they pass and your story criteria or bug fix works.
Steps 6 and 7 -  Simulate the state in production when we have pushed the NEW release code and PRE AND POST Migrations have been applied. For example: Production Code = 16.2 + 16.1 DB + 16.2 PRE Migrations + 16.2 POST Migrations, at this point we could say that we have Production Code = 16.2 + 16.2 DB
Step 7. Same than point 4.
If you do not have unit tests nor automation tests that verify your story criteria or bug fix, then instead of running test at steps 3, 5 and 7, you could:
 Mirror a client DB to run some tests (e.g the client where you plan to demo your story or the target client of your story)
 Apply migrations at the specific client from a.
Run smoke tests to verify your story criteria / bug fix.
This could take longer than just running tests
Smile and be happy! (smile)
