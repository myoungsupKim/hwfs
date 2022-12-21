package com.hwfs.fs.fsb.service;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsb.dao.UpjangChangeHistoryDAO;


 /**
 * 업장이력조회하는 UpjangChangeHistory Service Implementation
 * 
 * @ClassName UpjangChangeHistoryServiceImpl.java
 * @Description UpjangChangeHistoryServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.20    최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.05.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsb/upjangChangeHistoryService")
public class UpjangChangeHistoryServiceImpl extends DefaultServiceImpl implements UpjangChangeHistoryService {
	
	/** UpjangPackHistoryDAO Bean 생성 */
	@Resource(name = "/fs/fsb/upjangChangeHistoryDAO")
	private UpjangChangeHistoryDAO upjangChangeHistoryDAO;
	

	/**
	 * 업장이력조회 목록을 조회한다.
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
	public Map<String, RecordSet> selectUpjangChangeHistory(Map<String, Object> mapParam) throws Exception {
		RecordSet rs1 = upjangChangeHistoryDAO.selectUpjangChangeHistory(mapParam);
		RecordSet rs2 = upjangChangeHistoryDAO.selectMpriceInfoHistory(mapParam);
				
		Map<String, RecordSet> rsMap = new HashMap<String, RecordSet>();
		rsMap.put("accountingInfo", rs1);
		rsMap.put("mpriceInfo", rs2);
		
		return rsMap;
	}
	
}
