package com.hwfs.fs.fsf.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 상품운영리스트하는 FuneralTransList DAO
 * 
 * @ClassName FuneralTransListDAO.java
 * @Description FuneralTransListDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.19   	최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.05.19
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsf/funeralTransListDAO")
public class FuneralTransListDAO extends DefaultDAO {
	
	/**
	 * 상품운영리스트 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectFuneralTransList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralTransListDAO.selectFuneralTransList", mapParam);
	}

	/**
	 * 상품운영리스트(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralTransListDAO.insert", mapParam);
	}
	
	/**
	 * 상품운영리스트(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralTransListDAO.update", mapParam);
	}
	
	/**
	 * 상품운영리스트(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralTransListDAO.delete", mapParam);
	}
	
}
