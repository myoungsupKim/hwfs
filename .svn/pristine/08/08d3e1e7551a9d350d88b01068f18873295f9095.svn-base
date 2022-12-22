package com.hwfs.rc.rcm.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rcm.dao.CloseMgntDtlPopDAO;

 /**
 * 일마감 정보하는 CloseMgntDtlPop Service Implementation
 * 
 * @ClassName CloseMgntDtlPopServiceImpl.java
 * @Description CloseMgntDtlPopServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.08.11    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.08.11
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rcm/closeMgntDtlPopService")
public class CloseMgntDtlPopServiceImpl extends DefaultServiceImpl implements CloseMgntDtlPopService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** CloseMgntDtlPopDAO Bean 생성 */
	@Resource(name = "/rc/rcm/closeMgntDtlPopDAO")
	private CloseMgntDtlPopDAO closeMgntDtlPopDAO;
	

	/**
	 * 일마감 정보를 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return closeMgntDtlPopDAO.selectList(mapParam);
	}

	/**
	 * 일마감 매출정보를 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectSalsList(Map<String, Object> mapParam) throws Exception {
		return closeMgntDtlPopDAO.selectSalsList(mapParam);
	}

	/**
	 * 일마감 매출정보를 조회한다(사업장일마감용).
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectSalsListMag(Map<String, Object> mapParam) throws Exception {
		return closeMgntDtlPopDAO.selectSalsListMag(mapParam);
	}
	
	/**
	 * 일마감 지불정보를 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectPayList(Map<String, Object> mapParam) throws Exception {
		return closeMgntDtlPopDAO.selectPayList(mapParam);
	}

	/**
	 * 일마감 지불정보를 조회한다(사업장일마감용).
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectPayListMag(Map<String, Object> mapParam) throws Exception {
		return closeMgntDtlPopDAO.selectPayListMag(mapParam);
	}
}
