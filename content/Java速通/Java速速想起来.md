# Java
## 数组操作
Java的程序入口地址是`main` 方法，而`main` 方法可以接受一个命令行参数，是一个`String[]` 数组，命令参数由JVM接受用户输入并传main方法：
```Java
package cn.cherzing;  
  
import java.util.Scanner;  
  
/**  
 * @author Cherzing  
 * @date 2026/01/14 0014 22:11  
 * @description FromHead  
 */public class FromHead {  
    public static void main(String[] args) {  
        for (String arg:args){  
            System.out.println(arg);  
        }  
    }  
}
```
## 方法重载
在一个类中，我们可以定义多个方法。如果有一系列方法，它们的功能都是类似的，只有参数有所不同，那么，可以把这一组方法名做成_同名_方法。例如，在`Hello`类中，定义多个`hello()`方法：
```java
class Hello {
    public void hello() {
        System.out.println("Hello, world!");
    }

    public void hello(String name) {
        System.out.println("Hello, " + name + "!");
    }

    public void hello(String name, int age) {
        if (age < 18) {
            System.out.println("Hi, " + name + "!");
        } else {
            System.out.println("Hello, " + name + "!");
        }
    }
}


```
## 多态
同一操作作用于不同对象时，可产生不同行为
## 集合
### List
- 顺序
```java
public class TestList {  
    public static void main(String[] args) {  
        ArrayList<Integer> list = new ArrayList<>();  
        list.add(1);  
        list.add(2);  
        list.add(3);  
        list.add(4);  
        list.add(5);  
        for (Integer integer : list) {  
            System.out.print(integer + " ");  
        }  
    }  
}
```
### Set
- 可以用Set集合去重
#### TreeSet
- 不允许出现重复元素，不保证集合中元素的顺序，允许包含值为null的元素，但最多只能一个。
#### HashSet
- 可以实现排序等功能
### Map
- 键值对（key-value）
#### TreeMap

#### HashMap

## IO

| 类型  | 基础接口                           | 用途          |
| --- | ------------------------------ | ----------- |
| 字节流 | `InputStream` / `OutputStream` | 处理原始二进制数据   |
| 字符流 | `Reader` / `Writer`            | 处理Unicode文本 |
> 字节流不可直接用于二进制文件，如视频、图片


## JDBC基础
1. 加载驱动
2. 建立连接
3. 创建一个Statement实例
4. 执行SQL语句
5. 处理结果
6. 关闭对象资源

# MySQL
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