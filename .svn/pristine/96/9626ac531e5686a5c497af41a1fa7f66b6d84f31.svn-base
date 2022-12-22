package com.hwfs.sm.sar.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.sar.dao.SuspenseReturnRequestPopDAO;

 /**
 * SAP 계좌번호를 조회하는 SuspenseReturnRequestPop Service Implementation
 * 
 * @ClassName SuspenseReturnRequestPopServiceImpl.java
 * @Description SuspenseReturnRequestPopServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.19    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.05.19
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/sar/suspenseReturnRequestPopService")
public class SuspenseReturnRequestPopServiceImpl extends DefaultServiceImpl implements SuspenseReturnRequestPopService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SuspenseReturnRequestPopDAO Bean 생성 */
	@Resource(name = "/sm/sar/suspenseReturnRequestPopDAO")
	private SuspenseReturnRequestPopDAO suspenseReturnRequestPopDAO;

	/**
	 * SAP 계좌번호 목록을 조회한다.
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
		return suspenseReturnRequestPopDAO.selectList(mapParam);
	}
	/**
	 * SAP 전환 목록을 조회한다.
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
		return suspenseReturnRequestPopDAO.selectDetailList(mapParam);
	}

}
