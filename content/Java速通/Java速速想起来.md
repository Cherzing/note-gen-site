Java最高效学习路线图（依次向下顺序学习即可）
Java基础：[BV1gb42177hm](https://www.bilibili.com/video/BV1gb42177hm/?spm_id_from=333.788.video.desc.click) 
Javaweb+AI：[BV1yGydYEE3H](https://www.bilibili.com/video/BV1yGydYEE3H/?spm_id_from=333.788.video.desc.click) 
苍穹外卖：[BV1TP411v7v6](https://www.bilibili.com/video/BV1TP411v7v6/?spm_id_from=333.788.video.desc.click) 
AI+若依框架：[BV1pf421B71v](https://www.bilibili.com/video/BV1pf421B71v/?spm_id_from=333.788.video.desc.click) 
微服务全套：[BV1S142197x7](https://www.bilibili.com/video/BV1S142197x7/?spm_id_from=333.788.video.desc.click) 
学成在线项目：[BV1j8411N7Bm](https://www.bilibili.com/video/BV1j8411N7Bm/?spm_id_from=333.788.video.desc.click) 
黑马头条项目：[BV1Qs4y1v7x4](https://www.bilibili.com/video/BV1Qs4y1v7x4/?spm_id_from=333.788.video.desc.click) 
23年Java大厂面试：[BV1yT411H7YK](https://www.bilibili.com/video/BV1yT411H7YK/?spm_id_from=333.788.video.desc.click)

韩顺平Java：[Java](https://www.bilibili.com/video/BV1fh411y7R8?spm_id_from=333.788.videopod.episodes&vd_source=f38da837f7ffc103f340849927ff2d1f&p=404)

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

## 面向对象编程（基础）
### [[#创建对象的流程分析]]
### 方法重载
重载（Overloading）是指在一个类中可以定义多个方法，它们具有相同的名称但参数列表不同（包括参数类型、参数个数或参数顺序不同）。重载是一种编译时多态（静态多态）的表现。 
### this关键字
#### 核心概念
是一个特殊的应用变量，指向当前对象的实例，在类的实例方法和构造器中可用
```Java
public class Person {
    private String name;
    
    public Person(String name) {
        this.name = name;  // this指向正在创建的Person对象
    }
}
```
#### 区分成员变量与局部变量
```java
public class Student {
    private String name;      // 成员变量
    
    public void setName(String name) {  // 参数（局部变量）
        // 使用this区分同名变量
        this.name = name;     // 左边是成员变量，右边是参数
    }
    
    public String getName() {
        return this.name;     // 明确引用成员变量
    }
}
```
#### 在构造器中调用其他构造器
```java
public class Rectangle {
    private int x, y, width, height;
    
    // 无参构造器调用有参构造器
    public Rectangle() {
        this(0, 0, 0, 0);  // 必须是第一条语句！
    }
    
    public Rectangle(int width, int height) {
        this(0, 0, width, height);
    }
    
    public Rectangle(int x, int y, int width, int height) {
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
    }
}
```
#### 返回当前对象的引用
```java
public class Calculator {
    private int value;
    
    public Calculator add(int num) {
        value += num;
        return this;  // 返回当前对象
    }
    
    public Calculator multiply(int num) {
        value *= num;
        return this;
    }
    
    // 链式调用示例
    public static void main(String[] args) {
        int result = new Calculator()
            .add(5)      // 返回Calculator对象
            .multiply(2) // 继续调用
            .add(3)
            .getValue();
    }
}
```
#### 作为参数传递
```java
public class Employee {
    private String name;
    
    public void register() {
        // 将当前对象传递给方法
        Company.registerEmployee(this);
    }
    
    public void compare(Employee other) {
        if (this == other) {  // 比较是否是同一个对象
            System.out.println("Same object");
        }
    }
}
```
#### 在内部类中访问外部实例
```java
public class Outer {
    private int value = 10;
    
    class Inner {
        private int value = 20;
        
        public void print() {
            System.out.println("Inner value: " + this.value);        // 20
            System.out.println("Outer value: " + Outer.this.value);  // 10
        }
    }
}
```
#### 在实例初始化模块中使用
```java
public class MyClass {
    private int x;
    
    // 实例初始化块
    {
        this.x = initialize();  // 可以使用this
    }
    
    private int initialize() {
        return 100;
    }
}
```

> 简单来说，哪个对象调用，this就代表哪个对象
## 面向对象编程（中级）
### 面向对象的三大特征
### 封装
一种将数据（属性）和行为（方法）捆绑在一起，并对外部隐藏实现细节的机制。
- **隐藏内部实现**：将对象的属性和实现细节隐藏起来
- **公开访问接口**：通过公共方法提供对属性的安全访问
- **数据保护**：防止外部代码直接访问和修改内部数据
使用访问修饰符控制成员可见性：
```java
public class BankAccount {
    // private - 完全封装，仅本类可见
    private String accountNumber;
    private double balance;
    private String ownerName;
    
    // protected - 子类和同包可见
    protected String bankCode;
    
    // default (包私有) - 同包可见
    String branchName;
    
    // public - 完全公开
    public static final String BANK_NAME = "MyBank";
    
    // 构造方法
    public BankAccount(String accountNumber, String ownerName, double initialBalance) {
        this.accountNumber = accountNumber;
        this.ownerName = ownerName;
        // 通过setter设置，可以进行验证
        this.setBalance(initialBalance);
    }
}
```

### 继承
允许一个类（子类/派生类）基于另一个类（父类/基类）来构建，**继承父类的属性和方法**，同时可以添加新的特性或修改现有行为。
### 多态

### super关键字
代表父类的引用，用于访问父类的属性、方法、构造器
### Object类

### 方法重载
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

## 面向对象编程（高级）
### 类变量和类方法
#### 类变量
**类变量**是用`static`关键字修饰的成员变量，它属于**类本身**而不是类的任何实例。所有实例共享同一个类变量。
#### 类方法
**类方法（静态方法）** 是用`static`关键字修饰的方法，它属于**类本身**，可以直接通过类名调用，不需要创建对象。
- 用途：常用于工具方法（如 `Math.sqrt()`）、计数器、配置参数等与具体对象状态无关的场景。
### 理解main方法语法
1. **`public`**
    - 访问修饰符，表示该方法对 JVM 可见。JVM 在启动时需能访问此方法，因此必须为 `public`。
2. **`static`**
    - 表示该方法属于类本身，而非类的实例。JVM 在执行程序时不会先创建对象，而是直接通过类名调用 `main`，因此必须是静态的。
3. **`void`**
    - 返回类型。`main` 方法不返回任何值给 JVM，故返回类型必须为 `void`。
4. **`main`**
    - 方法名。JVM 严格识别名为 `main` 的方法作为入口。拼写错误（如 `Main`）将导致 `NoSuchMethodError`。
5. **`(String[] args)`**
    - 参数列表。`args` 是一个字符串数组，用于接收命令行传入的参数。例如运行 `java MyClass arg1 arg2` 时，`args[0] = "arg1"`，`args[1] = "arg2"`。
    - 自 Java 5 起，也可使用可变参数形式：`main(String... args)`，语义等价。
### 代码块
1. **普通代码块（Local Block）**
	- 定义在方法内部。
	- 作用：限制变量作用域、提高可读性或用于临时逻辑分组。
	- 示例：
 ```java
public void method() {
    {
        int x = 10; // x 仅在此块内有效
        System.out.println(x);
    }
    // System.out.println(x); // 编译错误：x 未定义
}
```
2. 静态代码块
	- 使用 `static` 修饰，定义在类中、方法外。
	- **执行时机**：类被加载到 JVM 时执行，**仅执行一次**，早于任何构造器或实例创建。
	- **用途**：初始化静态变量，尤其是复杂初始化（如读取配置、建立数据库连接等）。
	- 示例：
```java
public class Example {
    static int count;
    static {
        count = 0;
        System.out.println("静态代码块执行");
    }
}
```
3. 实例代码块
	- 无 `static` 修饰，定义在类中、方法外。
	- **执行时机**：每次创建对象时，在**调用构造器之前**执行（先于构造器体）。
	- **用途**：多个构造器有共同初始化逻辑时，避免重复代码。
```java
public class Example {
    {
        System.out.println("实例代码块执行");
    }
    public Example() { }
}
// new Example() 输出："实例代码块执行"
```
4. 同步代码块
	- 用于多线程控制，格式：`synchronized (lockObject) { ... }`
	- 作用：对指定对象加锁，确保同一时间只有一个线程执行该块。
```java
public void safeMethod() {
    synchronized (this) {
        // 临界区代码
    }
}
```
### 单例设计模式
#### 饿汉式：急于创建实例
	- 类加载时即创建实例
	- 线程安全。
	- 缺点：创建了对象，但是没有使用，造成浪费
1. 私有构造方法 
2. 私有静态常量，类加载时初始化  
3. 公共静态方法获取实例
```java
package cn.cherzing.test;  
  
/**  
 * @author Cherzing  
 * @date 2026/01/22 0022 19:13  
 * @description SingleTon  
 */
 public class SingleTonEager {  
    public static void main(String[] args) {  
        GirlFriend instance = GirlFriend.getInstance();  
        System.out.println(instance.toString());  
    }  
}  
class GirlFriend{  
    // 1. 私有构造方法  
    // 2. 私有静态常量，类加载时初始化  
    // 3. 公共静态方法获取实例  
    private String name;  
    private GirlFriend(String name){  
        this.name = name;  
    }  
    private static GirlFriend gf = new GirlFriend("XiaoHua");  
    public static GirlFriend getInstance(){  
        return gf;  
    }  
  
    @Override  
    public String toString() {  
        return "GirlFriend{" +  
                "name='" + name + '\'' +  
                '}';  
    }  
}
```
#### 懒汉式：不急于创建实例
	- 首次调用 `getInstance()` 时创建实例。
	- **问题**：多线程下可能创建多个实例。
1. 构造器私有化
2. 定义一个static静态属性对象
3. 提供一个public的static方法，可以返回一个Cat对象

```java
package cn.cherzing.test;  
  
/**  
 * @author Cherzing  
 * @date 2026/01/22 0022 19:21  
 * @description SingleTonLazy  
 */public class SingleTonLazy {  
    public static void main(String[] args) {  
        Cat instance = Cat.getInstance();  
        System.out.println(instance.toString());  
    }  
}  
class Cat{  
    private String name;  
    private static Cat cat;  
  
    public Cat(String name) {  
        this.name = name;  
    }  
  
    public static Cat getInstance(){  
        if (cat == null){  
            cat = new Cat("XiaoKeAi");  
        }  
        return cat;  
    }  
  
    @Override  
    public String toString() {  
        return "Cat{" +  
                "name='" + name + '\'' +  
                '}';  
    }  
}
```
### final关键字
1. final变量
	- 值不可改变
2. final方法
	- 禁止子类重写(override)
3. final类
	- 禁止被继承
### 抽象类
> 1. 不能被实例化的类，用于定义子类的同于结构和行为
> 2. 抽象类会被**继承**，子类实现其方法
> 
```java
public abstract class Animal {
    // 抽象方法：子类必须实现
    public abstract void makeSound();
    
    // 具体方法：子类可直接继承或重写
    public void sleep() {
        System.out.println("Sleeping...");
    }
}
```

### 接口

### 内部类



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

