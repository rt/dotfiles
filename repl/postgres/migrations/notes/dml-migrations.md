### DML Migrations

These are usually when the code refers to data in the database such as configs.
It is possible to do this with 
- Migrations
- In the app code where you can reference two changing names (but you need to delete the code in the following release)
- Admin (do it manually)

**With migrations**

*pre*
```sql
INSERT INTO translations (name, translation, type)
  SELECT 'KEY_NEW', translation, type
    FROM translations
    WHERE name = 'KEY_OLD';
```

*post*
```sql
DELETE FROM translations WHERE name = 'KEY_OLD';
```

It is also possible to do this in app code where you use a different *get* method to handle both,
then return to the original *get* method in the next release.

**With Code**

When the copying of data is complex, the code approach can work because it
knows what to access (or what exists) but requires code changes in consecutive
releases. That is, in the app code `if (old config exists) use it else use new
config`.

post

```sql
UPDATE configuration SET name = 'new_config_name' WHERE config_name = 'old_config_name';
```

This is very targeted though as you have to know/hard code the old and new name in the app code, then change back in the following release.



