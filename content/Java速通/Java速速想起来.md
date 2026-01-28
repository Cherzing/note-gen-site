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
接口定义了一个类应该**做什么**，但不指定**如何做**。
#### 核心特点
- **完全抽象**（Java 8前）：只包含方法声明，不包含实现
    
- **多继承**：类可以实现多个接口，解决Java单继承的限制
    
- **不能实例化**：需要通过实现类来创建对象
    
- **默认public访问权限**：接口中的方法默认都是public的

```java
public interface Animal {
    // 常量（自动为 public static final）
    String CATEGORY = "生物";
    
    // 抽象方法（自动为 public abstract）
    void eat();
    void sleep();
    
    // Java 8+ 默认方法
    default void breathe() {
        System.out.println("呼吸中...");
    }
    
    // Java 8+ 静态方法
    static void describe() {
        System.out.println("这是一个动物接口");
    }
}


```java
// 实现接口
class Dog implements Animal {
    @Override
    public void eat() {
        System.out.println("狗吃狗粮");
    }
    
    @Override
    public void sleep() {
        System.out.println("狗在睡觉");
    }
}

// 使用
Animal myDog = new Dog();
myDog.eat();
myDog.breathe();  // 使用默认方法
Animal.describe(); // 调用静态方法
```
```java
interface Swimmable {
    void swim();
}

interface Flyable {
    void fly();
}

// 实现多个接口
class Duck implements Animal, Swimmable, Flyable {
    @Override
    public void eat() { System.out.println("鸭子吃谷物"); }
    
    @Override
    public void sleep() { System.out.println("鸭子睡觉"); }
    
    @Override
    public void swim() { System.out.println("鸭子在游泳"); }
    
    @Override
    public void fly() { System.out.println("鸭子在飞行"); }
}
```

#### 接口 vs 抽象类

| 特性    | 接口             | 抽象类           |
| ----- | -------------- | ------------- |
| 多重继承  | ✓ 可以**实现**多个接口 | ✗ 只能**继承**一个类 |
| 方法实现  | 默认方法           | 可以有具体方法       |
| 构造器   | ✗ 没有构造器        | ✓ 可以有构造器      |
| 字段    | 只能是常量          | 可以有各种字段       |
| 访问修饰符 | 默认public       | 可以是任意修饰符      |
| 设计理念  | "能做什么"         | "是什么"         |


### 内部类
> 类的五大成员：
> - 属性
> - 方法
> - 构造器
> - 代码块
> - 内部类


内部类（Inner Class）是定义在另一个类内部的类。内部类最大的特点：**可以直接访问私有属性**，并且可以体现**类与类之间的包含关系**

1. 定义在外部类局部位置上（比如方法内）：
	- 局部内部类（有类名）
	- 匿名内部类（没有类名，重点！！！！！）
2. 定义在外部类的成员位置上：
	- 成员内部类（没用static修饰）
	- 静态内部类（使用static修饰）
#### 1. 成员内部类
```java
class Outer {
    private int x = 10;
    class Inner {
        void print() { System.out.println(x); } // 直接访问外部类私有成员
    }
}
```
#### 2. 静态内部类
```java
class Outer {
    static class StaticInner {
        void print() { System.out.println("Static nested"); }
    }
}
```
#### 3. 局部内部类
1. 局部内部类是定义在外部类的局部位置，通常在方法
2. 可以直接访问外部类的所有成员，包含私有的
3. 不能添加访问修饰符，但是可以使用final修饰
4. 作用域：仅仅在定义它的方法或代码块中
5. 局部内部类可以直接访问外部类的成员
```java
void method() {
    final int y = 20;
    class Local {
        void print() { 
	        System.out.println(y); 
        } // 访问 effectively final 变量
    }
    new Local().print();
}
```
定义在方法中的局部内部类：
```java
public class LocalInnerClassExample {
    private String outerField = "Outer field";

    public void createLocalInner() {
        // 局部变量（effectively final）
        int localVar = 42;
        String message = "Hello from method";

        // 定义局部内部类
        class LocalInner {
            // 可以访问外部类的成员
            public void display() {
                System.out.println("Accessing outer class field: " + outerField);
                // 可以访问方法中的 effectively final 变量
                System.out.println("Local variable (effectively final): " + localVar);
                System.out.println("Message: " + message);
            }

            // 局部内部类可以有方法
            public void anotherMethod() {
                System.out.println("Another method in local inner class");
            }
        }

        // 在方法内创建局部内部类的实例并使用
        LocalInner local = new LocalInner();
        local.display();
        local.anotherMethod();
    }

    public static void main(String[] args) {
        LocalInnerClassExample example = new LocalInnerClassExample();
        example.createLocalInner();
    }
}
```
输出：
```TXT
Accessing outer class field: Outer field
Local variable (effectively final): 42
Message: Hello from method
Another method in local inner class
```
#### 4. 匿名内部类！！！
- 没有名字，通常用于继承类或实现接口的**一次性使用**。
- 语法：`new SuperType() { /* 匿名类体 */ }`
- 常用于事件监听、Lambda 表达式替代
```java
public class AnonymousInnerClassExample {
    public static void main(String[] args) {
        // 匿名内部类：实现 Runnable 接口
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                System.out.println("Thread is running using anonymous inner class.");
            }
        });
        thread.start();
    }
}
```
## 枚举
用于定义固定数量的常量集合。它本质上是继承自 `java.lang.Enum` 的 **final 类**，具备类的特性（可包含字段、方法、构造器等），同时提供编译期安全和类型安全
### 自定义枚举
1. 不需要提供setXxx方法，因为枚举对象值通常为只读,可以提供get方法
2. 对枚举对象/属性使用final+static共同修饰，实现底层优化.
3. 枚举对象名通常使用全部大写，常量的命名规范
4. 枚举对象根据需要，也可以有多个属性
```JAVA
public class TestEnum {  
    public static void main(String[] args) {  
        System.out.println(Season.SPRING);  
    }  
}  
class Season{  
    private String name;  
    private String des;  
    public final static Season SPRING = new Season("春天","温暖");  
    public final static Season Summer = new Season("夏天","炎热");  
    public final static Season FALL = new Season("秋天","凉爽");  
    public final static Season WINTER = new Season("冬天","寒冷");  
  
    public Season(String name, String des) {  
        this.name = name;  
        this.des = des;  
    }  
  
    @Override  
    public String toString() {  
        return "Season{" +  
                "name='" + name + '\'' +  
                ", des='" + des + '\'' +  
                '}';  
    }  
}
```
### 使用`enum`关键字实现枚举
1. 当我们使用enum关键字开发一个枚举类时，默认会继承Enum类
2. 传统的public static final Season2SPRING=newSeason2("春天"，"温暖"）；简化成SPRING（“春天”，“温暖”），这里必须知道，它调用的是哪个构造器
3. 如果使用无参构造器创建枚举对象，则实参列表和小括号都可以省略
4. 当有多个枚举对象时，使用，间隔，最后有一个分号结尾
5. 枚举对象必须放在枚举类的行首
6. 本质还是public static final
```java
enum Day {  
    MONDAY("忙戴","周一"),  
    TUESDAY("",""),  
    WEDNESDAY("",""),  
    THURSDAY("",""),  
    FRIDAY("",""),  
    SATURDAY("",""),  
    SUNDAY("","");  
    private String name;  
    private String desc;  
  
    Day(String name, String desc) {  
        this.name = name;  
        this.desc = desc;  
    }  
}
```

调用以上枚举类：
```java
public class TestEnum {  
    public static void main(String[] args) {  
        System.out.println(Season.SPRING);  
        System.out.println(Day.MONDAY);  
    }  
}
```
## 注解
三个基本的Annotation:
1.  `@Override`: 限定某个方法，是重写父类方法, 该注解只能用于方法
2. `@Deprecated`: 用于表示某个程序元素(类, 方法等)已过时
3. `@SuppressWarnings`: 抑制编译器警告
## 异常
### Error
- 继承自 `java.lang.Error`。
- 表示 JVM 无法恢复的严重问题（如 `OutOfMemoryError`, `StackOverflowError`）。
- **不应被捕获或处理**，程序通常直接终止。
### Exception
- 继承自 `java.lang.Exception`。
- 分为两类：
    - **Checked Exception（受检异常）**
        - 编译器强制要求处理（如 `IOException`, `SQLException`）。
        - 必须通过 `try-catch` 捕获或 `throws` 声明抛出。
    - **Unchecked Exception（非受检异常）**
        - 继承自 `RuntimeException`（如 `NullPointerException`, `ArrayIndexOutOfBoundsException`）。
        - 编译器不强制处理，但运行时可能崩溃。
## 常用类
### 包装类

### String类
**字符串特性**
- `String` 对象一旦创建，其内容**无法修改**。
```java
String str = "Hello";
// String对象一旦创建，内容就不能更改
str = str + " World";  // 实际上创建了新的String对象
```
- 所有看似“修改”字符串的方法（如 `concat()`, `substring()`）均返回**新对象**。
- **特点**：
	- **不可变性**：String对象的内容一旦创建就不可改变
	- **字符串常量池**：相同的字符串字面量会被复用
	- **线程安全**：天然线程安全（不可变对象）
**String类的常见方法**
```java
String s = "Hello World";
s.length();      // 长度
s.charAt(0);     // 获取字符
s.substring(6);  // 子串
s.indexOf("W");  // 查找位置
s.equals("hello"); // 比较（区分大小写）
s.equalsIgnoreCase("hello"); // 不区分大小写比较
s.concat("!");   // 连接
s.replace("H", "h"); // 替换
```
### StringBuffer 类
```java
StringBuffer sb = new StringBuffer();  // 初始容量16
StringBuffer sb2 = new StringBuffer("Hello");
```
**特点：**
- **可变性**：可以在原对象上修改内容
- **线程安全**：所有方法都有synchronized关键字修饰
- **性能较好**：比String在频繁修改时性能好
**常见方法：**
```java
StringBuffer sb = new StringBuffer("Hello");
sb.append(" World");       // 追加
sb.insert(5, ",");         // 在指定位置插入
sb.delete(5, 6);           // 删除
sb.reverse();              // 反转
sb.replace(6, 11, "Java"); // 替换
sb.setCharAt(0, 'h');      // 设置指定位置字符
sb.capacity();             // 获取容量
sb.length();               // 获取长度
```

### StringBuilder 类
```java
StringBuilder sb = new StringBuilder();
StringBuilder sb2 = new StringBuilder("Hello");
```
**特点：**
- **可变性**：可以在原对象上修改内容
- **非线程安全**：没有同步锁，性能更高
- **性能最优**：单线程环境下性能最好
**方法：**
```java
StringBuilder sb = new StringBuilder("Hello");
sb.append(" World");
sb.insert(5, ",");
// ... 方法基本与StringBuffer一致
```

| 特性       | StringBuilder | StringBuffer         |
| -------- | ------------- | -------------------- |
| **线程安全** | ❌ 非线程安全       | ✅ 线程安全               |
| **性能**   | 更快（约10-15%）   | 稍慢（因为同步开销）           |
| **同步**   | 方法不同步         | 方法使用 synchronized 同步 |
| **使用场景** | 单线程环境         | 多线程环境                |
**常用方法：**
- `append(Object obj)`: 追加任意类型（调用 `String.valueOf()`）。
- `insert(int offset, String str)`: 在指定位置插入。
- `delete(int start, int end)`: 删除子串。
- `replace(int start, int end, String str)`: 替换子串。
- `reverse()`: 反转字符序列。
- `toString()`: 返回不可变的 `String` 对象。
### Math 类

### Arrays 类

### System 类

### BigInteger 和BigDecimal 类

### 日期类

## 集合
主要分为两大类
[[#Collection]]和[[#Map]]

![[Pasted image 20260125101601.png]]
### Collection
![[Pasted image 20260125135859.png]]
#### List
**有序、重复**
##### ArrayList
动态数组
- 随机访问 O(1)  
- 插入/删除 O(n)（尾部 O(1)）  
- **非线程安全**
##### LinkedList
双向链表
- 插入/删除 O(1)（已知节点）  
- 随机访问 O(n)  
- 额外内存开销（前后指针）
##### Vector
动态数组
- **线程安全**（方法加 `synchronized`）  
- 性能低于 `ArrayList`

#### Set
![[Pasted image 20260125135922.png]]
**无序、不可重复**
##### TreeSet
底层：红黑树
- **自然排序**或自定义 `Comparator`  
- 不允许 `null`（除非自定义比较器处理）
##### HashSet
底层：HashMap
- 基于哈希表  
- **无序**  
- 允许一个 `null` 元素  
- **非线程安全**
### Map
- 键值对（key-value）
#### TreeMap

#### HashMap

#### Hashtable

## 泛型

## 多线程

## IO流

## 网络编程

## 反射

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

