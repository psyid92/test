package com.sp.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("demo.demoService")
public class DemoServiceImpl implements DemoService {
	
	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertDemo(Demo dto) throws Exception {
		try {
			dao.insertData("demo.insertDemo1", dto);
			dao.insertData("demo.insertDemo2", dto);
			dao.insertData("demo.insertDemo3", dto);
		} catch (Exception e) {
			throw e;
		}
	}
}
