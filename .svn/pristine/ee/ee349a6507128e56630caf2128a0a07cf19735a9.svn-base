// [속도개선 Project 시작] 2017. 7. 3. 최범주 입금처리이력 및 매출보정이력을 조회한다.
package com.hwfs.fm.fmf.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 입금처리이력 및 매출보정이력을 조회하는 SaleModifyHistory DAO
 * 
 * @ClassName SaleModifyHistoryDAO.java
 * @Description SaleModifyHistoryDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2017.07.03    최범주        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 최범주
 * @since 2017.07.03
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmf/saleModifyHistoryDAO")
public class SaleModifyHistoryDAO extends DefaultDAO {

	/**
	 * 입금처리이력 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList1(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.saleModifyHistoryDAO.selectList1", mapParam);
	}
	
	/**
	 * 매출보정이력 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.saleModifyHistoryDAO.selectList2", mapParam);
	}
}
// [속도개선 Project   끝] 2017. 7. 3. 최범주