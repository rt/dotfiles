# queries

```sql
select type, count(tanslationid) from translations group by type order by type limit 5;

select * from table where like '%aaa%'; //or ilike
select * from table where lower(value) similar to '%(foo|bar|baz)%';

begin
rollback
commit
```



