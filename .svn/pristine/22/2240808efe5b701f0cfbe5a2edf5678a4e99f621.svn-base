package com.hwfs.rc.rrm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 매출 추정 양식 SaleEstFrm DAO
 * 
 * @ClassName SaleEstFrmDAO.java
 * @Description SaleEstFrmDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2019.01.07    김지영        최초생성
 * </pre>
 * @author 김지영
 * @since 2019.01.07
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */

@Repository("/rc/rrm/saleEstFrmDAO")
public class SaleEstFrmDAO extends DefaultDAO
{
	/**
	 * 매출 추정 양식 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception
	{
		return super.queryForRecordSet("rc.rrm.saleEstFrmDAO.selectList", mapParam);
	}
	
	/**
	 * 월별 단가를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectMmPriceList(Map<String, Object> mapParam) throws Exception
	{
		return super.queryForRecordSet("rc.rrm.saleEstFrmDAO.selectMmPriceList", mapParam);
	}
	
	/**
	 * 월별 단가를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertMmPrice(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.saleEstFrmDAO.insertMmPrice", mapParam);
	}
	
	/**
	 * 일별 매출 정보를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertDdPrice(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.saleEstFrmDAO.insertDdPrice", mapParam);
	}
}