package com.hwfs.fs.fsb.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 사업장기준정보 저장권한 관리 UpjangRemainVendorMgntDAO
 * 
 * @ClassName UpjangRemainVendorMgntDAO.java
 * @Description UpjangRemainVendorMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2019.05.20   	kihoon        최초생성
 * </pre>
 * @author 한화시스템/ICT : kihoon
 * @since 2019.05.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2019 by HANWHA CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsb/upjangRemainVendorMgntDAO")
public class UpjangRemainVendorMgntDAO extends DefaultDAO {
	
	/**
	 * 사업장기준정보 권한 대상 조회
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.upjangRemainVendorMgntDAO.selectUpjangRemainVendorList", mapParam);
	}
	
	/**
	 * 사업장기준정보 권한 대상 추가
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertUpjangRemainVendor(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangRemainVendorMgntDAO.insertUpjangRemainVendor", mapParam);
	}
	
	/**
	 * 사업장기준정보 권한 대상 수정
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateUpjangRemainVendor(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangRemainVendorMgntDAO.updateUpjangRemainVendor", mapParam);
	}
	
	/**
	 *  사업장기준정보 권한 대상 삭제
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteUpjangRemainVendor(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangRemainVendorMgntDAO.deleteUpjangRemainVendor", mapParam);
	}
}