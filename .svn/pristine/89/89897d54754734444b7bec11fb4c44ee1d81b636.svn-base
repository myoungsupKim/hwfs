package com.hwfs.fs.fsb.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 사업장을 일괄수정하는 UpjangPackModify DAO
 * 
 * @ClassName UpjangPackModifyDAO.java
 * @Description UpjangPackModifyDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.21   	김예진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.05.21
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsb/upjangPackModifyDAO")
public class UpjangPackModifyDAO extends DefaultDAO {
	
	/**
	 * 사업장 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.upjangPackModifyDAO.selectList", mapParam);
	}

	/**
	 * history에 등록.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackModifyDAO.insert", mapParam);
	}

	/**
	 * 사업장(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackModifyDAO.update", mapParam);
	}
	
	/**
	 * 사업장(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackModifyDAO.delete", mapParam);
	}
	
}
