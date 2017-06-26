package com.sp.blog.guest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("blog.guest.guestService")
public class GuestServiceImpl implements GuestService {
	@Autowired
	private CommonDAO dao;
	
	@Override
	public int insertGuest(Guest dto) {
		int result=0;
		try {
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("tableName", dto.getTableName());
			int maxNum=dao.getIntValue("blogGuest.maxNum", map);
			dto.setNum(maxNum+1);
			
			result=dao.insertData("blogGuest.insertGuest", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Guest> listGuest(Map<String, Object> map) {
		List<Guest> list=null;
		try {
			list=dao.getListData("blogGuest.listGuest", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.getIntValue("blogGuest.dataCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int deleteGuest(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.deleteData("blogGuest.deleteGuest", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

}
