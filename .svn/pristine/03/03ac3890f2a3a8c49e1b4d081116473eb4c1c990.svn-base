package com.hwfs.fs.fsf.service;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsf.dao.FuneralAdjustSumDAO;


 /**
 * 정산집계관리(일별/월별/년별)하는 FuneralAdjustSum Service Implementation
 * 
 * @ClassName FuneralAdjustSumServiceImpl.java
 * @Description FuneralAdjustSumServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.29    최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.04.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsf/funeralAdjustSumService")
public class FuneralAdjustSumServiceImpl extends DefaultServiceImpl implements FuneralAdjustSumService {
	
	/** FuneralAdjustSumDAO Bean 생성 */
	@Resource(name = "/fs/fsf/funeralAdjustSumDAO")
	private FuneralAdjustSumDAO funeralAdjustSumDAO;
	

	/**
	 * 정산집계관리 목록을 조회한다.
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
	public Map<String, RecordSet> selectFuneralAdjustSumList(Map<String, Object> mapParam) throws Exception {
		
		mapParam.put("sumType", "01");	// 일별 집계
		RecordSet rs1 = funeralAdjustSumDAO.selectFuneralAdjustSumList(mapParam);
		mapParam.put("sumType", "02");	// 월별 집계
		RecordSet rs2 = funeralAdjustSumDAO.selectFuneralAdjustSumList(mapParam);
		mapParam.put("sumType", "03");	// 년별 집계
		RecordSet rs3 = funeralAdjustSumDAO.selectFuneralAdjustSumList(mapParam);
		Map<String, RecordSet> rsMap = new HashMap<String, RecordSet>();
		rsMap.put("adjustDateSum", rs1);
		rsMap.put("adjustMonthSum", rs2);
		rsMap.put("adjustYearSum", rs3);
		return rsMap;
	}	
}
