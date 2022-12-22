package com.hwfs.fs.fsl.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 식권관리팝업하는 MealTicketPopup DAO
 * 
 * @ClassName MealTicketPopupDAO.java
 * @Description MealTicketPopupDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.26   	손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.05.26
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsl/mealTicketPopupDAO")
public class MealTicketPopupDAO extends DefaultDAO {
	
	/**
	 * 식권팝업 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	
	public RecordSet insertList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.mealTicketPopupDAO.insertList", mapParam);
	}
	
	/**
	 * 식권팝업 목록을 조회한다.(history)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet ticketHistory(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.mealTicketPopupDAO.ticketHistory", mapParam);
	}
	
	
}
