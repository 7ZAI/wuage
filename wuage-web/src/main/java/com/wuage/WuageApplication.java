package com.wuage;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication(scanBasePackages = {"com.wuage"})
@EnableAspectJAutoProxy
@EnableTransactionManagement
public class WuageApplication {


    public static void main(String[] args) {
        SpringApplication.run(WuageApplication.class, args);
    }

}
