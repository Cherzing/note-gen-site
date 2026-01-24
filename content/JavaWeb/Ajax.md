Ajax（Asynchronous JavaScript and XML）是一种用于创建异步 Web 应用的技术，其核心是通过 `XMLHttpRequest`（或现代的 `fetch` API）在不重新加载整个页面的情况下，与服务器交换数据并更新部分网页内容。

关键特性：
- **异步通信**：浏览器向服务器发送请求后，无需等待响应即可继续执行其他操作。(不需要刷新页面)
- **局部更新**：仅更新页面中需要变化的部分，而非整页刷新。
- **数据格式不限于 XML**：尽管名称包含 XML，但实际可使用 JSON、HTML、纯文本等格式。现代开发中 JSON 更为常见。
- **依赖 JavaScript**：需通过 JS 发起请求、处理响应，并操作 DOM 实现动态更新。

典型使用场景包括表单提交验证、自动补全搜索、无限滚动加载等。

技术栈组成：
- JavaScript（控制逻辑）
- XMLHttpRequest / fetch（网络请求）
- DOM（页面更新）
- 服务器端（提供 API 接口）

> 注意：Ajax 本身不是一种语言或框架，而是一种**编程模式**。

> 同步与异步：
> ![[cherzing_2026-01-23_13-01-51.png]]

## Axios
- 对原生的Ajax进行封装，简化书写，快速开发
- https://www.axios-http.cn/docs/intro
### Get
https://www.axios-http.cn/docs/example
```JavaScript
// 向给定ID的用户发起请求  
axios.get('/user?ID=12345')  
.then(function (response) {  
// 处理成功情况  
console.log(response);  
})  
.catch(function (error) {  
// 处理错误情况  
console.log(error);  
})  
.finally(function () {  
// 总是会执行  
});
```
### POST
https://www.axios-http.cn/docs/post_example
```javaScript
axios.post('/user', {
    firstName: 'Fred',
    lastName: 'Flintstone'
  })
  .then(function (response) {
    console.log(response);
  })
  .catch(function (error) {
    console.log(error);
  });
```
### async & await
- 可以通过async、await可以让异步变为同步操作。async就是来声明一个异步方法，await是用来等待异步任务执行。
