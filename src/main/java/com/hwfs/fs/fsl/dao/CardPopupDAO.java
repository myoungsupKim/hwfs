package com.hwfs.fs.fsl.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 카드사팝업하는 CardPopup DAO
 * 
 * @ClassName CardPopupDAO.java
 * @Description CardPopupDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.28   	손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.05.28
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsl/cardPopupDAO")
public class CardPopupDAO extends DefaultDAO {
	
	/**
	 * 카드사팝업 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.cardPopupDAO.selectList", mapParam);
	}
	public RecordSet selectMealList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.cardPopupDAO.selectMealList", mapParam);
	}

}
