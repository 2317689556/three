package com.buba.boot1806a;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

import javax.annotation.Resource;

@RunWith(SpringRunner.class)
@SpringBootTest
public class Boot1806aApplicationTests {

    @Autowired
    private JedisPool jedisPool;

    @Test
    public void contextLoads() {
        Jedis jedis = jedisPool.getResource();
        String str = jedis.set("bcReids","springboot");
        System.out.println("set的结果值"+str);
        String value = jedis.get("bcReids");
        System.out.println("get的结果value"+value);
        /*把jedes对象关掉*/
        jedis.close();

    }

}
