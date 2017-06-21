package com.sp.tour;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("tour.tourService")
public class TourServiceImpl implements TourService{
	@Autowired
	private CommonDAO dao;
	
	@Override
	public List<Tour> listSido() {
		List<Tour> list = null;
		
		try {
			list=dao.getListData("tour.listSido");
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return list;
	}

	@Override
	public List<Tour> listCity(int snum) {
		List<Tour> list = null;
		
		try {
			list=dao.getListData("tour.listCity", snum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return list;
	}

	@Override
	public int insertSido(Tour dto) {
		int result=0;
		
		try {
			result=dao.getIntValue("tour.seqSido");
			dto.setSnum(result);
			dao.insertData("tour.insertSido", dto);
		} catch (Exception e) {
			result=0;
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public int insertCity(Tour dto) {
		int result=0;
		
		try {
			result=dao.getIntValue("tour.seqCity");
			dto.setCnum(result);
			dao.insertData("tour.insertCity", dto);
		} catch (Exception e) {
			result=0;
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public int deleteSido(int snum) {
		int result=0;
		try {
			result=dao.deleteData("tour.deleteSido", snum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int deleteCity(int cnum) {
		int result=0;
		try {
			result=dao.deleteData("tour.deleteCity", cnum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

}
