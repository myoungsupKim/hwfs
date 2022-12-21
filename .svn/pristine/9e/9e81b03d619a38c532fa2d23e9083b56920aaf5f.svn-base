package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
* 수발주제어 예외품목 등록하는 Service
* 
* @ClassName ExceptionItemMgntService.java
* @Description ExceptionItemMgntService Class
* @Modification-Information
* <pre>
*    수정일             수정자                 수정내용
*  ----------   ----------   -------------------------------
*  2022.04.22   hye.jin94    최초생성
* </pre>
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
@Repository("/fm/fms/exceptionItemMgntDAO")
public class ExceptionItemMgntDAO extends DefaultDAO {
	
	/**
	 * 자재를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectItem(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.exceptionItemMgntDAO.selectItem", mapParam);
	}
	
	/**
	 * 수발주제어 예외품목을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectExceptionItem(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.exceptionItemMgntDAO.selectExceptionItem", mapParam);
	}
	
	/**
	 * 수발주제어 예외품목 DATA를 추가한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertExceptionItem(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.exceptionItemMgntDAO.insertExceptionItem", mapParam);
	}
	
	/**
	 * 수발주제어 예외품목 DATA를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateExceptionItem(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.exceptionItemMgntDAO.updateExceptionItem", mapParam);
	}
	
	/**
	 * 수발주제어 예외품목 DATA를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteExceptionItem(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.exceptionItemMgntDAO.deleteExceptionItem", mapParam);
	}

	/**
	 * 수발주제어 예외품목 DATA 입력/수정/삭제 내역 히스토리를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertHisExceptionItem(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.exceptionItemMgntDAO.insertHisExceptionItem", mapParam);
	}

}
