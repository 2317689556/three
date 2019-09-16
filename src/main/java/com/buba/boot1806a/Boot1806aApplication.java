package com.buba.boot1806a;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.buba.boot1806a.dao")
public class Boot1806aApplication {

    public static void main(String[] args) {
        SpringApplication.run(Boot1806aApplication.class, args);
    }

}
