package com.hwfs.fs.fsb.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 사업장기준정보 저장권한 관리 UpjangRemainQtyRegDAO
 * 
 * @ClassName UpjangRemainQtyRegDAO.java
 * @Description UpjangRemainQtyRegDAO Class
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
@Repository("/fs/fsb/upjangRemainQtyRegDAO")
public class UpjangRemainQtyRegDAO extends DefaultDAO {
	
	/**
	 * 사업장기준정보 권한 대상 조회
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.upjangRemainQtyRegDAO.selectUpjangRemainQtyRegList", mapParam);
	}
	
	/**
	 * 사업장기준정보 권한 대상 추가
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertUpjangRemainQtyReg(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangRemainQtyRegDAO.insertUpjangRemainQtyReg", mapParam);
	}
	
	/**
	 * 사업장기준정보 권한 대상 수정
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateUpjangRemainQtyReg(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangRemainQtyRegDAO.updateUpjangRemainQtyReg", mapParam);
	}
	
	/**
	 *  사업장기준정보 권한 대상 삭제
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteUpjangRemainQtyReg(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangRemainQtyRegDAO.deleteUpjangRemainQtyReg", mapParam);
	}
}