## 项目简介

Wuage是一个前后分离的基于角色权限控制的后台管理系统，目前实现了用户、角色、菜单、部门管理功能。
前端使用了开源项目：[vue-admin-template](https://github.com/PanJiaChen/vue-admin-template)   、Vue、Element UI  

后端使用了：spring boot 、springmvc、 mybatis-plus、shiro、ehcache

演示地址：http://49.234.56.103/


## 项目目录结构

wuage-page  [可参考vue-admin 文档](https://panjiachen.github.io/vue-element-admin-site/zh/guide/)

wuage  为后端代码 ，使用了maven 多模块构建 。结构和简介如下

```
 *
 *   * wuage
 *          wuage-common     自定义的注解类、常量、枚举、controller基类、统一返回数据类、和常用工具类
 *
 *          wuage-dao        数据库映射的实体类、mapper接口、mapper.xml、vm模板、自动代码生产类
 *
 *          wuage-service     业务接口和实现类，和事务切面
 *
 *          wuage-framework  captcha、druid、shiro、mybatis配置类  自定义组件、拦截器、shiro filter、realm、全局异常处理等
 *
 *          wuage-web        controller、启动类 和 各类配置文件ehcache、application、log4j2
```



