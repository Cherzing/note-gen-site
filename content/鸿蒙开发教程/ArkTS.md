---
tags:
  - 教程
  - HarmonyOS
---
[ArkTS语言介绍](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/introduction-to-arkts)
[ArkTS视频课程](https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717496870909384?pathId=101667550095504391)
[详细内容](https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717496870909384?pathId=101667550095504391)


## ArkTS基础知识
### 赋值
```TS
关键字 变量/常量:类型注释 = 值
```
> 变量声明：
> ```TypeScript
> let count:number = 0;
> count = 40;
> ```
> 常量声明：
> ```TS
> const MAX_COUNT:100;
> ```
### 类型
- 基础类型：`string` `number` `boolean` `null` `undefined` `bigint` 
- 引用类型：`Interface` `Object` `Function` `Array` `Class` `Tuple` `Enum` 
- 枚举类型：`Enum` 
- 联合类型：`Union` 
- 类型别名：`Type Aliases` 
### 语句
- 条件语句：`if else` 
- 循环
### 函数的声明和使用
1. 传入是一个值，还是两个值
```TS
function funName(a:number,b?:number):number{
	return a+b;
}
```
可传入一个参数，两个参数：
```TS
funName(1);
funName(1,2);
```
2. 传入是默认值，还是给定值：
```TS
function funName(a:number,b:number = 2):number{
	return a+b;
}
```
可使用默认值2：
```TS
funName(1);//输出3
function(1,3);//输出4
```
3. 箭头函数：
```TS
(参数列表):返回类型=>{函数体}
```
Example：
```TS
//函数返回值类型可以省略，省略根据执行体判断
const printInfo = (name:string):void=>{console.log(name)};
//执行体只有一行，可以省略花括号
const printInfo=(name:string)=>console.log(name);

//常用作回调函数：
let students:string[] = ['XiaoMing','XiaoZhang','XiaoWang','XiaoCao'];
	student.forEach((student:string)=>{console.log(student)});
```
4. 闭包函数：一个函数将另一个函数作为返回值，保留对内部作用域的访问
```TS
function outerFunc():()=>string{
	let count = 0;
	return():string=>{
		count++;
		return count.toString();
	}
}
let invoker = outerFunc();
console.log(invoker());//输出1
console.log(invoker());//输出2
```
### 类的声明和使用
```TS
class Person{
	name:string  = 'Xiaoming';
	age:number=20;
	isMale:boolean=true;
}
//new创建
const person = new Person();
console.log(person.name);
//字面量创建
const person:Person={name:'XiaoZhang',age='20',isMale='true'};
const.log(person.name);
```
方法：
```ts
class Person {  
  name: string = 'Xiaoming';  
  age: number = 20;  
  isMale: boolean = true;  
  
  constructor(name: string, age: number, isMale: boolean) {  
    this.name = name;  
    this.age = age;  
    this.isMale = isMale;  
  }  
  
  public printInfo(): void {  
    if (this.isMale == true) {  
      console.log(`${this.name} is a boy and he is ${this.age} years old.`);  
    } else {  
      console.log(`${this.name} is a girl and she is ${this.age} years old.`);  
    }  
  }}  
  
const person: Person = { name: 'XiaoZhang', age: 20, isMale: true };  
person.printInfo();
```
- 封装
将数据隐藏起来，只对外部提供必要的接口和操作数据（使用private关键字）
```ts
class Person{  
  private name:string = 'XiaoCao';  
  private age:number = 12;  
  private isMale:boolean = true;  
  
  constructor(name:string,age:number,isMale:boolean) {  
    this.name = name;  
    this.age = age;  
    this.isMale = isMale;  
  }  
  public static set age(value:number){  
    this.age = value;  
  }  
  public static get age():number{  
    return this.age;  
  }  
}
```
- 继承
```ts
class Person {  
  private name: string = 'XiaoCao';  
  private age: number = 12;  
  private isMale: boolean = true;  
  
  constructor(name: string, age: number, isMale: boolean) {  
    this.name = name;  
    this.age = age;  
    this.isMale = isMale;  
  }  
  
  public static set age(value: number) {  
    this.age = value;  
  }  
  
  public static get age(): number {  
    return this.age;  
  }  
}  
  
class Employee extends Person {  
  private department: string = '开发部';  
  
  constructor(name: string, age: number, isMale: boolean, department: string) {  
    super(name, age, isMale);  
    this.department = department;  
  }  
}  
const employee:Employee = new Employee('Cherzing',20,true,'开发部');
```
- 多态：子类继承父类，重写父类方法
```TS
class Employee extends Person {  
  private department: string = '开发部';  
  
  constructor(name: string, age: number, isMale: boolean, department: string) {  
    super(name, age, isMale);  
    this.department = department;  
  }  
  public printInfo(): void {  
    super.printInfo();  
    console.log(`work in this ${this.department}部门`)  
  }  
}  
const employee:Employee = new Employee('Cherzing',20,true,'开发部');
```
### 接口
约束和规范类的方法
```ts
/**  
 * 接口的申明  
 */interface AreaSize{  
  width:number;  
  height:number;  
  size?:number; //可选属性  
  readonly address:string;//只读属性  
}  
interface Areasize{  
  calculateAreaSize():number;  
  someMethod():string;  
}  
/**
* 接口的实现
*/
class RectangleSize implements AreaSize{  
  width: number = 0;  
  height: number = 0;  
  someMethod(){  
    console.log('Some Method called!');  
  }  
}
```
### 命名空间的概念和使用
将代码的区域划分，控制命名冲突和组织代码
```TS
  
namespace MyNameSpace{  
  export interface AreaSize{  
    width:number;  
    height:number;  
  }  
}  
let areaSize:MyNameSpace = {with:100,height:100};
```
### 模块导入与导出
 - `export from` 用于从一个模块中导出所有导出项，或从一个模块中导出多个特定的导出项
![[PixPin_2026-01-12_21-38-21.png]]
- `import` 支持条件延迟加载，提升页面的加载速度
```TS
// Test.ets
export function hello(){
	console.info('Hello');
}

// Page.ets
import('./Test').then(ns =>{
	ns.hello();
);
```