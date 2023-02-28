一、单个字段值是重复

1. 找出单个字段上的所有重复值 

   ```mysql
   select fieldName from tableName group by fieldName having count(*) > 1 #sql1
   select min(id) id from tableName group by fieldName having count(*) > 1 #sql2 
   ```

2. 找出单个字段上所有的重复记录

   ```mysql
   #先找出所有的重复值，然后在查一次条件带上in(重复值)
   select * from tableName where fieldName in (sql1) #这里sql1 就是上面第一条sql语句
   #完整sql语句如下
   select * from tableName where fieldName in (select fieldName from tableName group by fieldName having count(*) > 1) #sql3
   
   ```

3. 删除重复记录，只保留一条

   ```mysql
   #思路先找出所有重复记录，在排除重复值最小，
   #(sql1)和(sql4) 都是子查询，(sql1)找出所有重复值，(sql4)找出重复记录里面id值最小的一条记录
   select * from tableName where fieldName in (sql3) having id not in (sql2)
   #完整sql如下
   #sql4
   select * from tableName 
   	where 
   		fieldName in (select fieldName from tableName group by fieldName having count(*) > 1) all_of_field_value
   	having 
   		id not in (select min(id) id from tableName where fieldName group by fieldName having count(*) > 1)) 
   #子查询的 from 子句和更新、删除对象使用同一张表
   #解决办法,将查询结果集
   
   delete form tableName 
   		where id in (
       	select tmp.id (sql4) as tmp
       )
   
   #完整mysql如下
   delete form tableName 
   		where id in (
       	select tmp.id (
           select * from tableName where fieldName in (select fieldName from tableName group by fieldName having count(*) > 1) all_of_field_value having 
   		id not in (select min(id) id from tableName where fieldName group by fieldName having count(*) > 1)) ) as tmp
       )
      
   ```

   

二、多个字段值查重和去重

1. ​	多个字段值同理(也可以使用临时表)

   ```mysql
   #最小id
   create TEMPORARY table tmp_min_ids (select min(id) id from distribution_full_gift_activity_rule group by activity_id,category_id,brand_id,product_id having count(*)>1);
   #所有重复的值
   create TEMPORARY table tmp_all_repeat_value (select activity_id,category_id,brand_id,product_id from distribution_full_gift_activity_rule group by activity_id,category_id,brand_id,product_id having count(*)>1);
   #所有重复的记录
   create TEMPORARY table tmp_all_repeat_ids (select id from distribution_full_gift_activity_rule where (activity_id,category_id,brand_id,product_id) in (select * from tmp_all_repeat_value));
   #删除重复的记录只保留一条最小的id
   delete from distribution_full_gift_activity_rule  where id in (select id from tmp_all_repeat_ids) and id not in (select id from tmp_min_ids);
   
   ```

   