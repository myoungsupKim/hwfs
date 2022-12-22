package com.hwfs.fs.fso.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 마케터배부등록팝업하는 MarketerDivPopup DAO
 * 
 * @ClassName MarketerDivPopupDAO.java
 * @Description MarketerDivPopupDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.02   	박준석        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 박준석
 * @since 2015.07.02
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fso/marketerDivPopupDAO")
public class MarketerDivPopupDAO extends DefaultDAO {
	
	/**
	 * 마케터배부등록팝업 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.marketerDivPopupDAO.selectList", mapParam);
	}
	
	/**
	 * 마케터배부등록 총합을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectTotalSumChk(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.marketerDivPopupDAO.selectTotalSumChk", mapParam);
	}
	
	/**
	 * 마케터배부등록팝업 입력전 중복대상을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMarketerDupChk(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.marketerDivPopupDAO.selectMarketerDupChk", mapParam);
	}

	/**
	 * 마케터배부등록팝업(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.marketerDivPopupDAO.insert", mapParam);
	}
	
	/**
	 * 마케터배부등록팝업(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.marketerDivPopupDAO.update", mapParam);
	}
	
	/**
	 * 마케터배부등록팝업(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.marketerDivPopupDAO.delete", mapParam);
	}
	
}
