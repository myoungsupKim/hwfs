package com.hwfs.fm.fmp.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 아이템 추가 정보 공유하는 ItemAddInfoShare DAO
 * 
 * @ClassName ItemAddInfoShareDAO.java
 * @Description ItemAddInfoShareDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.09.15   	ydpark        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 ydpark
 * @since 2015.09.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmp/itemAddInfoShareDAO")
public class ItemAddInfoShareDAO extends DefaultDAO {
	
	/**
	 * 조회 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmp.itemAddInfoShareDAO.selectList", mapParam);
	}

	/**
	 * 조회(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmp.itemAddInfoShareDAO.insert", mapParam);
	}
	
	/**
	 * 조회(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmp.itemAddInfoShareDAO.update", mapParam);
	}
	
	/**
	 * 조회(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmp.itemAddInfoShareDAO.delete", mapParam);
	}
	
}
