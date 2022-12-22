package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 발주현황하는 ReturnOrderList DAO
 * 
 * @ClassName ReturnOrderListDAO.java
 * @Description ReturnOrderListDAO Class
 * @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2021.08.30   DEV02        최초생성
* </pre>
* @author [PJT]주문채널통합 : DEV02
* @since 2021.08.30
* @version 1.0
* @see 
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
@Repository("/fm/fms/returnOrderListDAO")
public class ReturnOrderListDAO extends DefaultDAO {
	
	/**
	 * 발주현황 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.returnOrderListDAO.selectList", mapParam);
	}
	
	/**
	 * 발주현황 상세목록을 조회한다. (반환)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSub(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.returnOrderListDAO.selectSub", mapParam);
	}
	
	/**
	 * 발주현황 상세목록을 조회한다. (정상발주)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSubOrder(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.returnOrderListDAO.selectSubOrder", mapParam);
	}
	
	/**
	 * 발주현황 브랜드 확정 저장
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateConfirm(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.returnOrderListDAO.updateConfirm", mapParam);
	}
	
	/**
	 * 발주현황 브랜드 반려 저장
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateReturn(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.returnOrderListDAO.updateReturn", mapParam);
	}
}
