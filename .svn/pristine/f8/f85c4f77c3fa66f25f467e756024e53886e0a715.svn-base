package com.hwfs.ms.mom.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ms.mom.dao.AdditionOrderReportDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * 추가발주현황 조회하는 AdditionOrderReport Service Implementation
 * 
 * @ClassName AdditionOrderReportServiceImpl.java
 * @Description AdditionOrderReportServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.09    강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 현장지원_모바일 강대성
 * @since 2015.06.09
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ms/mom/additionOrderReportService")
public class AdditionOrderReportServiceImpl extends DefaultServiceImpl implements AdditionOrderReportService {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** AdditionOrderReportDAO Bean 생성 */
	@Resource(name = "/ms/mom/additionOrderReportDAO")
	private AdditionOrderReportDAO additionOrderReportDAO;
	

	/**
	 * 추가발주현황 조회 목록을 조회한다.
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
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return additionOrderReportDAO.selectList(mapParam);
	}
	
	/**
	 * 추가발주현황 조회 목록을 조회한다.
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
	public RecordSet selectListOld(Map<String, Object> mapParam) throws Exception {
		return additionOrderReportDAO.selectListOld(mapParam);
	}

	/**
	 * 추가발주현황(상세) 조회 목록을 조회한다.
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
	public RecordSet selectDetailList(Map<String, Object> mapParam) throws Exception {
		return additionOrderReportDAO.selectDetailList(mapParam);
	}
}
