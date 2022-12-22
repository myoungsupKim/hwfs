package com.hwfs.fs.fsl.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 선수금 선택하는 AdvanceAmtPopup DAO
 * 
 * @ClassName AdvanceAmtPopupDAO.java
 * @Description AdvanceAmtPopupDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.30   	이지운        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 이지운
 * @since 2015.07.30
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsl/advanceAmtPopupDAO")
public class AdvanceAmtPopupDAO extends DefaultDAO {
	
	/**
	 * 선수금 선택 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectAdvanceAmtList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.advanceAmtPopupDAO.selectAdvanceAmtList", mapParam);
	}

	/**
	 * 선수금 선택(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.advanceAmtPopupDAO.insert", mapParam);
	}
	
	/**
	 * 선수금 선택(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.advanceAmtPopupDAO.update", mapParam);
	}
	
	/**
	 * 선수금 선택(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.advanceAmtPopupDAO.delete", mapParam);
	}
	
}
