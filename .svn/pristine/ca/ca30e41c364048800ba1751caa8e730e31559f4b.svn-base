package com.hwfs.rc.sle.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * .하는 IfFmbSaleInq DAO
 * 
 * @ClassName IfFmbSaleInqDAO.java
 * @Description IfFmbSaleInqDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.09.08   	맹수영        최초생성
 * </pre>
 * @author FC종합전산구축 : 영업회계 맹수영
 * @since 2015.09.08
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/sle/ifFmbSaleInqDAO")
public class IfFmbSaleInqDAO extends DefaultDAO {
	
	/**
	 * . 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.sle.ifFmbSaleInqDAO.selectList", mapParam);
	}

	/**
	 * .(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.sle.ifFmbSaleInqDAO.insert", mapParam);
	}
	
	/**
	 * .(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.sle.ifFmbSaleInqDAO.update", mapParam);
	}
	
	/**
	 * .(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.sle.ifFmbSaleInqDAO.delete", mapParam);
	}
	
}
