package com.hwfs.fs.fsl.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsl.dao.MealTicketPopupDAO;
import com.tobesoft.xplatform.data.DataSet;


 /**
 * 식권팝업 MealTicketPopup Service Implementation
 * 
 * @ClassName MealTicketPopupServiceImpl.java
 * @Description MealTicketPopupServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.26    손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.05.26
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsl/mealTicketPopupService")
public class MealTicketPopupServiceImpl extends DefaultServiceImpl implements MealTicketPopupService {
	

	/** MealTicketPopupDAO Bean 생성 */
	@Resource(name = "/fs/fsl/mealTicketPopupDAO")
	private MealTicketPopupDAO mealTicketPopupDAO;
	

	/**
	 * 식권팝업 목록을 조회한다.
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
		return mealTicketPopupDAO.insertList(mapParam);
	}
	
	/**
	 * 식권팝업 목록을 조회한다.(history)
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
	public RecordSet ticketHistory(Map<String, Object> mapParam) throws Exception {
			return mealTicketPopupDAO.ticketHistory(mapParam);
	}
	
}
