package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 반환가능품목등록하는 DAO
 * 
 * @ClassName ReturnItemMgntDAO.java
 * @Description ReturnItemMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2021.07.08   DEV02        최초생성
 * </pre>
 * @author [PJT]주문채널통합 : DEV02
 * @since 2021.07.08
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/returnItemMgntDAO")
public class ReturnItemMgntDAO extends DefaultDAO {
	
	/**
	 * 자재를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectItem(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.returnItemMgntDAO.selectItem", mapParam);
	}
	
	/**
	 * 반환가능품목을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectReturnItem(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.returnItemMgntDAO.selectReturnItem", mapParam);
	}
	
	/**
	 * 반환가능품목 DATA를 추가한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertReturnItem(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.returnItemMgntDAO.insertReturnItem", mapParam);
	}
	
	/**
	 * 반환가능품목 DATA를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateReturnItem(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.returnItemMgntDAO.updateReturnItem", mapParam);
	}
	
	/**
	 * 반환가능품목 DATA를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteReturnItem(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.returnItemMgntDAO.deleteReturnItem", mapParam);
	}

}
