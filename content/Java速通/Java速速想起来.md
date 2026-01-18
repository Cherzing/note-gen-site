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
### Map
- 键值对（key-value）
# MySQL
## 增
```SQL
insert into students values
(values1,values2,values3);
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