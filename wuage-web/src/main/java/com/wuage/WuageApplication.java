package com.wuage;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import java.util.concurrent.locks.ReentrantLock;

@SpringBootApplication(scanBasePackages = {"com.wuage"})
@EnableAspectJAutoProxy
@EnableTransactionManagement
public class WuageApplication {
//  ReentrantLock

    public static void main(String[] args) {
        SpringApplication.run(WuageApplication.class, args);
    }

}
