## 增
```SQL
insert into students 
values (values1,values2,values3);
```
## 删
```SQl
delete
from students
where id>=5 and id <= 10;
```
或者：
```SQL
delete
from students
where id between 5 and 10;
```
## 改
```SQL
update students 
set name = '大牛',score = 66 
where id = 1;
```

## 查
### 基本查询
```SQL
select * from students;
```
### 条件查询
```SQL
select * 
from students 
where score >= 88;
```
### 分页查询
```SQL
select id,name,gender,score
from students
order by score desc
limit 20 offset 0;
```
- `desc` 表示倒序
- `0` 表示序列从0开始
- `20` 表示每页限制20条数据

## 四大特性（ACID）
1. **原子性（Atomicity）**：事务中的所有操作要么全部成功执行，要么全部不执行。若事务在执行过程中发生错误，系统会回滚到事务开始前的状态。
2. **一致性（Consistency）**：事务执行前后，数据库必须保持一致状态，即满足所有预定义的约束（如主键、外键、唯一性、检查约束等）。事务不会破坏数据库的完整性。
3. **隔离性（Isolation）**：多个并发事务之间互不干扰。一个事务的中间状态对其他事务不可见，直到该事务提交。不同隔离级别（如读未提交、读已提交、可重复读、串行化）控制可见性和并发行为。
4. **持久性（Durability）**：一旦事务提交，其对数据库的修改将永久保存，即使系统发生故障（如断电、崩溃），数据也不会丢失。