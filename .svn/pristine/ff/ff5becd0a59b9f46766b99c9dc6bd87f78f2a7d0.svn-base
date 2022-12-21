package com.hwfs.fs.fsf.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 장례식장 업체정보관리하는 FuneralVendorMgnt DAO
 * 
 * @ClassName FuneralVendorMgntDAO.java
 * @Description FuneralVendorMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.15   	최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.04.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsf/funeralVendorMgntDAO")
public class FuneralVendorMgntDAO extends DefaultDAO {
	
	/**
	 * 장례식장 업체정보관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectFuneralVendorList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralVendorMgntDAO.selectFuneralVendorList", mapParam);
	}
	
	/**
	 * 년월에 순번 max+1 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMaxSeq(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralVendorMgntDAO.selectMaxSeq", mapParam);
	}

	/**
	 * 장례식장 업체정보관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertFuneralVendor(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralVendorMgntDAO.insertFuneralVendor", mapParam);
	}
	
	/**
	 * 장례식장 업체정보관리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateFuneralVendor(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralVendorMgntDAO.updateFuneralVendor", mapParam);
	}
	
	/**
	 * 장례식장 업체정보관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteFuneralVendor(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralVendorMgntDAO.deleteFuneralVendor", mapParam);
	}
	
}
