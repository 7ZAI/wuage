package com.wuage.utils;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.core.exceptions.MybatisPlusException;
import com.baomidou.mybatisplus.core.toolkit.StringPool;
import com.baomidou.mybatisplus.generator.AutoGenerator;
import com.baomidou.mybatisplus.generator.InjectionConfig;
import com.baomidou.mybatisplus.generator.config.*;
import com.baomidou.mybatisplus.generator.config.po.TableInfo;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;
import com.baomidou.mybatisplus.generator.engine.VelocityTemplateEngine;


import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Generator {
    /**
     * <p>
     * 读取控制台内容
     * </p>
     */
    public static String scanner(String tip) {
        Scanner scanner = new Scanner(System.in);
        StringBuilder help = new StringBuilder();
        help.append("请输入" + tip + "：");
        System.out.println(help.toString());
        if (scanner.hasNext()) {
            String ipt = scanner.next();
            if (ipt != null && ipt.length()>0) {
                return ipt;
            }
        }
        throw new MybatisPlusException("请输入正确的" + tip + "！");
    }


    public static void main(String[] args) {

        // 代码生成器
        AutoGenerator mpg = new AutoGenerator();
        // 全局配置
        GlobalConfig gc = new GlobalConfig();
        String projectPath = System.getProperty("user.dir");
        gc.setOutputDir(projectPath + "/wuage-dao/src/target/generateCode");
        gc.setAuthor("binblink");

        //生成后是否打开文件夹
        gc.setOpen(false);
        //是否覆盖之前的生成的同名文件
        gc.setFileOverride(true);

        gc.setBaseColumnList(true);
        gc.setBaseResultMap(true);
        gc.setMapperName("%sMapper");
        gc.setServiceName("%sService");
        gc.setServiceImplName("%sServiceImpl");
        gc.setIdType(IdType.ASSIGN_UUID);
//        gc.setEntityName("%s");
        // gc.setSwagger2(true); 实体属性 Swagger2 注解
        mpg.setGlobalConfig(gc);

        // 数据源配置
        DataSourceConfig dsc = new DataSourceConfig();
        dsc.setUrl("jdbc:mysql://192.168.77.2:3306/wuage?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8");
        // dsc.setSchemaName("public");
        dsc.setDriverName("com.mysql.cj.jdbc.Driver");
        dsc.setUsername("root");
        dsc.setPassword("123456");

        mpg.setDataSource(dsc);
//        com.baomidou.mybatisplus.generator.engine.AbstractTemplateEngine
        // 包配置
        PackageConfig pc = new PackageConfig();
//        pc.setModuleName("");
        pc.setParent("com.wuage");
        pc.setEntity("entity");
        pc.setMapper("mapper");

        //如果设置一下会生成默认的
//        pc.setService("service");
//        pc.setServiceImpl("service.impl");
//        pc.setController(null);
//        pc.setXml("resources");
        mpg.setPackageInfo(pc);
//        FreemarkerTemplateEngine freemarkerTemplateEngine = new FreemarkerTemplateEngine();
        VelocityTemplateEngine velocityTemplateEngine = new VelocityTemplateEngine();
        // 自定义配置
        InjectionConfig cfg = new InjectionConfig() {
            @Override
            public void initMap() {

            }
        };



//        // 自定义输出配置
        List<FileOutConfig> focList = new ArrayList<>();
        //自定义配置会被优先输出
        focList.add(new FileOutConfig("/codeTemplate/mapper.xml.vm") {
            @Override
            public String outputFile(TableInfo tableInfo) {

                // 自定义输出文件名 ，如果你 Entity 设置了前后缀、此处注意 xml 的名称会跟着发生变化！！
                return projectPath + "/wuage-dao/src/target/generateCode/mapper"
                        + "/" + tableInfo.getEntityName() + "Mapper" + StringPool.DOT_XML;
            }

        });


//
        focList.add(new FileOutConfig("/codeTemplate/service.java.vm") {
            @Override
            public String outputFile(TableInfo tableInfo) {

                // 自定义输出文件名 ， 如果你 Entity 设置了前后缀、此处注意 xml 的名称会跟着发生变化！！
                return projectPath + "/wuage-dao/src/target/generateCode/java/com.wuage.service"
                        + "/"+tableInfo.getEntityName()+"Service"+  StringPool.DOT_JAVA;
            }
        });

        focList.add(new FileOutConfig("/codeTemplate/serviceImpl.java.vm") {
            @Override
            public String outputFile(TableInfo tableInfo) {


                return projectPath + "/wuage-dao/src/target/generateCode/java/com.wuage.service"+"/impl"
                         + "/"+ tableInfo.getEntityName() +"ServiceImpl"+ StringPool.DOT_JAVA;
            }
        });

        focList.add(new FileOutConfig("/codeTemplate/controller.java.vm") {
            @Override
            public String outputFile(TableInfo tableInfo) {

                return projectPath + "/wuage-dao/src/target/generateCode/java/com/wuage/controller/"
                        +tableInfo.getEntityName() +"Controller"+StringPool.DOT_JAVA;
            }
        });
////
//        cfg.setFileCreate(new IFileCreate() {
//            @Override
//            public boolean isCreate(ConfigBuilder configBuilder, FileType fileType, String filePath) {
//                // 判断自定义文件夹是否需要创建
//                checkDir("调用默认方法创建的目录");
//                return false;
//            }
//        });
//
        cfg.setFileOutConfigList(focList);
        mpg.setCfg(cfg);
        // 配置模板
        TemplateConfig templateConfig = new TemplateConfig();

        // 配置自定义输出模板
        //指定自定义模板路径，注意不要带上.ftl/.vm, 会根据使用的模板引擎自动识别 ftl.myCodeTemple
//         templateConfig.setEntity("templates/entity2.java");
//        templateConfig.setService("ftl/myCodeTemple/service.java");

//        templateConfig.setMapper("/codeTemplate/mapper.java");

//        templateConfig.setServiceImpl("ftl/myCodeTemple/serviceImpl.java");
        //控制是否按默认的生成文件 设置为null则不生成默认的
        templateConfig.setXml(null);
        templateConfig.setController(null);
        templateConfig.setService(null);
        templateConfig.setServiceImpl(null);

        mpg.setTemplate(templateConfig);


        // 策略配置
        StrategyConfig strategy = new StrategyConfig();

//        strategy.setSuperEntityClass("com.baomidou.ant.common.BaseEntity");
        strategy.setEntityLombokModel(true);
        strategy.setRestControllerStyle(true);

        strategy.setNaming(NamingStrategy.underline_to_camel);
        strategy.setColumnNaming(NamingStrategy.underline_to_camel);
        // 公共父类
        strategy.setSuperControllerClass("com.wuage.controller.BaseController");
        // 写于父类中的公共字段
//        strategy.setSuperEntityColumns("id");
        strategy.setInclude(scanner("表名，多个英文逗号分割").split(","));
//        strategy.setControllerMappingHyphenStyle(true);

        //去除表前缀
        strategy.setTablePrefix("sys_");
//      strategy.setTablePrefix(pc.getModuleName() + "_");
        mpg.setStrategy(strategy);
        mpg.setTemplateEngine(velocityTemplateEngine);
        mpg.execute();
    }
}
