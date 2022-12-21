package com.hwfs.fs.fse.dao;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 사업부 기기/기물 조회 팝업하는 UtensilPop DAO
 * 
 * @ClassName UtensilPopDAO.java
 * @Description UtensilPopDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.03   	김미경        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김미경
 * @since 2015.06.03
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fse/utensilPopDAO")
public class UtensilPopDAO extends DefaultDAO {
	
	/**
	 * 사업부 기기/기물 조회 팝업 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fse.utensilPopDAO.selectList", mapParam);
	}
	
	/**
	 * 대분류 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCodeLclass(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fse.utensilPopDAO.selectCodeLclass", mapParam);
	}
	
	/**
	 * 중분류 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCodeMclass(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fse.utensilPopDAO.selectCodeMclass", mapParam);
	}

}
