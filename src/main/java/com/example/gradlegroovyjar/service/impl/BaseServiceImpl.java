package com.example.gradlegroovyjar.service.impl;


import com.example.gradlegroovyjar.service.BaseService;
import org.springframework.stereotype.Service;

@Service
public class BaseServiceImpl implements BaseService {
    public int GetCount(int num1, int num2) {
        System.out.printf("return: %d", num1 + num2);
        return num1+num2;
    }
}
