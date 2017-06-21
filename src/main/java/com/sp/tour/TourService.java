package com.sp.tour;

import java.util.List;

public interface TourService {
	public List<Tour> listSido();
	public List<Tour> listCity(int snum);
	
	public int insertSido(Tour dto);
	public int insertCity(Tour dto);

	public int deleteSido(int snum);
	public int deleteCity(int cnum);
}
