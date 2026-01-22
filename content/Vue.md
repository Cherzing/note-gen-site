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
## Ajax