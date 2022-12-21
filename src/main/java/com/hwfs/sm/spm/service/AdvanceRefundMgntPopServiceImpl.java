package com.hwfs.sm.spm.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.spm.dao.AdvanceRefundMgntPopDAO;

 /**
 * 선수금 환불처리를 하는 AdvanceRefundMgntPop Service Implementation
 * 
 * @ClassName AdvanceRefundMgntPopServiceImpl.java
 * @Description AdvanceRefundMgntPopServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.30    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.04.30
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/spm/advanceRefundMgntPopService")
public class AdvanceRefundMgntPopServiceImpl extends DefaultServiceImpl implements AdvanceRefundMgntPopService {
	
	/** AdvanceRefundMgntPopDAO Bean 생성 */
	@Resource(name = "/sm/spm/advanceRefundMgntPopDAO")
	private AdvanceRefundMgntPopDAO advanceRefundMgntPopDAO;
	

	/**
	 * 선수금 환불처리 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return advanceRefundMgntPopDAO.selectList(mapParam);
	}

}
