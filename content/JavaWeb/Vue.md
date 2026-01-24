## 1. 快速入门
- 准备工作
	- 引入Vue模块
	- 创建Vue的应用实例
	- 定义元素div，交给Vue（mount()）控制
- 视图驱动视图
	- 准备数据
	- 用差值表达式渲染
```html
<!DOCTYPE html>  
<html lang="zh-CN">  
<head>  
<meta charset="UTF-8">  
<title>快速入门</title>  
</head>  
<body>  
<div id="app">  
<h1>{{message}}</h1>  
<h1>{{count }}</h1>  
</div>  
<script type="module">  
import {createApp} from 'https://unpkg.com/vue@3/dist/vue.esm-browser.js';  
  
createApp({  
data() {  
return {  
message: 'Hello Vue!',  
count: 100  
}  
}  
}).mount('#app');  
</script>  
</body>  
</html>
```
![[cherzing_2026-01-22_22-25-31.png]]
输出：
![[cherzing_2026-01-22_22-26-19.png]]

## Vue常用指令
- 指令：HTML标签上带有v-前缀的特殊属性，不同的指令具有不同的含义，可以实现不同的功能
```html
<p v-xxxx>
</p>
```

| v-for                 | 列表渲染                   |
| --------------------- | ---------------------- |
| v-bind                | 为HTML标签绑定属性值           |
| v-if/v-else-if/v-else | 条件性的渲染某元素，true渲染，否则不渲染 |
| v-show                | 根据条件展示某元素              |
| v-model               | 在表单元素上创建双线数据绑定         |
| v-on                  | 为HTML标签绑定事件            |
|                       |                        |
### v-for
- 作用：列表渲染
- 语法：`<tr v-for="(item,index) in items" :key="item.id">{{item}}</tr>` 
- 参数说明：
	- items：为遍历的数组
	- item为遍历出来的元素
	- index：索引
- key:提升性能，给元素添加唯一标识
### v-bind
- 动态为HTML标签绑定属性值，如设置href，src，Style
![[cherzing_2026-01-23_11-05-10.png]]

### v-if&& v-show
![[cherzing_2026-01-23_11-17-14.png]]

### v-model
![[cherzing_2026-01-23_11-21-22.png]]

### v-on
`@click` 
![[cherzing_2026-01-23_11-58-54.png]]
> methods函数中，要使用this获取到Data中定义的数据

>[!info] [条件渲染](https://cn.vuejs.org/guide/essentials/conditional.html)
>- [v-if](https://cn.vuejs.org/guide/essentials/conditional.html#v-if)
>- [v-else](https://cn.vuejs.org/guide/essentials/conditional.html#v-else)
>- [v-else-if](https://cn.vuejs.org/guide/essentials/conditional.html#v-else-if)
>- [\<template>上的 v-if](https://cn.vuejs.org/guide/essentials/conditional.html#v-if-on-template)
>- [v-show](https://cn.vuejs.org/guide/essentials/conditional.html#v-show)
>- [v-if vs. v-show](https://cn.vuejs.org/guide/essentials/conditional.html#v-if-vs-v-show)
>- [v-if 和 v-for](https://cn.vuejs.org/guide/essentials/conditional.html#v-if-with-v-for)

> [!info] [条件渲染](https://cn.vuejs.org/guide/essentials/list.html)
> - [v-for](https://cn.vuejs.org/guide/essentials/list.html#v-for)
> - [v-for 与对象](https://cn.vuejs.org/guide/essentials/list.html#v-for-with-an-object)
> - [在 v-for 里使用范围值](https://cn.vuejs.org/guide/essentials/list.html#v-for-with-a-range)
> - [\<template> 上的 v-for](https://cn.vuejs.org/guide/essentials/list.html#v-for-on-template)
> - [v-for 与 v-if](https://cn.vuejs.org/guide/essentials/list.html#v-for-with-v-if)
> - [通过 key 管理状态](https://cn.vuejs.org/guide/essentials/list.html#maintaining-state-with-key)
> - [组件上使用 v-for](https://cn.vuejs.org/guide/essentials/list.html#v-for-with-a-component)
> - [数组变化侦测](https://cn.vuejs.org/guide/essentials/list.html#array-change-detection)
> - [展示过滤或排序后的结果](https://cn.vuejs.org/guide/essentials/list.html#displaying-filtered-sorted-results)
