package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 고객시스템 Interface하는 CustSysInterface DAO
 * 
 * @ClassName CustSysInterfaceDAO.java
 * @Description CustSysInterfaceDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.12   	최영준        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.06.12
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/custSysInterfaceDAO")
public class CustSysInterfaceDAO extends DefaultDAO {
	
	/**
	 * 고객시스템 Interface - 창고(배송처) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSubinv(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.custSysInterfaceDAO.selectSubinv", mapParam);
	}
	
	/**
	 * 고객시스템 Interface - 상품정보 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectItem(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.custSysInterfaceDAO.selectItem", mapParam);
	}
	
	/**
	 * 고객시스템 Interface - 주문정보 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectOrder(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.custSysInterfaceDAO.selectOrder", mapParam);
	}
	
	/**
	 * 고객시스템 Interface - 거래내역 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectTrans(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.custSysInterfaceDAO.selectTrans", mapParam);
	}
	
	/**
	 * 고객시스템 Interface - 결과확인 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectResult(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.custSysInterfaceDAO.selectResult", mapParam);
	}
	
	/**
	 * 고객시스템 Interface - 주문정보2 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectOrder2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.custSysInterfaceDAO.selectOrder2", mapParam);
	}
	
	/**
	 * 고객시스템 Interface - 거래내역2 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectTrans2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.custSysInterfaceDAO.selectTrans2", mapParam);
	}
	
	/**
	 * 고객시스템 Interface - 월 거래내역 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectTransMonth(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.custSysInterfaceDAO.selectTransMonth", mapParam);
	}

	/**
	 * 고객시스템 Interface(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.custSysInterfaceDAO.insert", mapParam);
	}
	
	/**
	 * 고객시스템 Interface(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.custSysInterfaceDAO.update", mapParam);
	}
	
	/**
	 * 고객시스템 Interface(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.custSysInterfaceDAO.delete", mapParam);
	}
	
}
