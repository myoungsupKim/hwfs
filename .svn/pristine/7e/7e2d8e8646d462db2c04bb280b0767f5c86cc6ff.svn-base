package com.hwfs.fm.fmf.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 매출현황(브랜드) 일자별집계 조회하는 BrandBuySaleSum DAO
 * 
 * @ClassName BrandBuySaleSumDAO.java
 * @Description BrandBuySaleSumDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2021.09.12   DEV02        최초생성
 * 
 * </pre>
 * @author [PJT]주문채널통합 : DEV02
 * @since 2021.09.12
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmf/brandBuySaleSumDAO")
public class BrandBuySaleSumDAO extends DefaultDAO {
	
	/**
	 * 매출현황(브랜드) 일자별집계 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.brandBuySaleSumDAO.selectList", mapParam);
	}
	
	/**
	 * 매출현황(브랜드) 브랜드유통 관리부서 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectBrandTm(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.brandBuySaleSumDAO.selectBrandTm", mapParam);
	}

}
