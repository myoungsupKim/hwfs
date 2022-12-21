package com.hwfs.fs.fsf.service;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsf.dao.FuneralSaleSumDAO;

 /**
 * 매출집계관리(일별/월별/년별)하는 FuneralSaleSum Service Implementation
 * 
 * @ClassName FuneralSaleSumServiceImpl.java
 * @Description FuneralSaleSumServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.28    최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.04.28
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsf/funeralSaleSumService")
public class FuneralSaleSumServiceImpl extends DefaultServiceImpl implements FuneralSaleSumService {
	
	/** FuneralSaleSumDAO Bean 생성 */
	@Resource(name = "/fs/fsf/funeralSaleSumDAO")
	private FuneralSaleSumDAO funeralSaleSumDAO;
	

	/**
	 * 매출집계관리 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public Map<String, RecordSet> selectFuneralSaleSumList(Map<String, Object> mapParam) throws Exception {
		
		mapParam.put("sumType", "01");	// 일별 집계
		RecordSet rs1 = funeralSaleSumDAO.selectFuneralSaleSum(mapParam);
		mapParam.put("sumType", "02");	// 월별 집계
		RecordSet rs2 = funeralSaleSumDAO.selectFuneralSaleSum(mapParam);
		mapParam.put("sumType", "03");	// 년별 집계
		RecordSet rs3 = funeralSaleSumDAO.selectFuneralSaleSum(mapParam);
		Map<String, RecordSet> rsMap = new HashMap<String, RecordSet>();
		rsMap.put("saleDateSum", rs1);
		rsMap.put("saleMonthSum", rs2);
		rsMap.put("saleYearSum", rs3);
		return rsMap;
	}	
	
	/**
	 * 매출집계관리 목록을 품목별로 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public Map<String, RecordSet> selectFuneralSaleSumItemList(Map<String, Object> mapParam) throws Exception {
		
		mapParam.put("sumType", "01");	// 일별 집계
		RecordSet rs1 = funeralSaleSumDAO.selectFuneralSaleItemSum(mapParam);
		mapParam.put("sumType", "02");	// 월별 집계
		RecordSet rs2 = funeralSaleSumDAO.selectFuneralSaleItemSum(mapParam);
		mapParam.put("sumType", "03");	// 년별 집계
		RecordSet rs3 = funeralSaleSumDAO.selectFuneralSaleItemSum(mapParam);
		Map<String, RecordSet> rsMap = new HashMap<String, RecordSet>();
		rsMap.put("saleDateSum", rs1);
		rsMap.put("saleMonthSum", rs2);
		rsMap.put("saleYearSum", rs3);
		return rsMap;
	}	
}
