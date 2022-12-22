package com.hwfs.fs.fsf.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 매출집계관리(일별/월별/년별)하는 FuneralSaleSum DAO
 * 
 * @ClassName FuneralSaleSumDAO.java
 * @Description FuneralSaleSumDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.28   	최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.04.28
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsf/funeralSaleSumDAO")
public class FuneralSaleSumDAO extends DefaultDAO {
	
	/**
	 * 매출집계관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectFuneralSaleSum(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralSaleSumDAO.selectFuneralSaleSum", mapParam);
	}	

	/**
	 * 매출집계관리 목록을 품목별로 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectFuneralSaleItemSum(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralSaleSumDAO.selectFuneralSaleSumItem", mapParam);
	}	
}
