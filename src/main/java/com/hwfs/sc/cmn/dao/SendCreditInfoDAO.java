package com.hwfs.sc.cmn.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * SendCreditInfoDAO에 대한 설명 작성
 * @ClassName SendCreditInfoDAO.java
 * @Description SendCreditInfoDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016. 12. 2.   901X5L        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 901X5L
 * @since 2016. 12. 2.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/sendCreditInfoDAO")
public class SendCreditInfoDAO extends DefaultDAO {

	/**
	 * 영업사원 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPartSalesList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.sendCreditInfoDAO.selectPartSalesList", mapParam);
	}
	
	/**
	 * 여신정보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCreditInfo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.sendCreditInfoDAO.selectCreditInfo", mapParam);
	}
	
}
