package com.hwfs.sc.cmn.dao;

import java.util.Map;
import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 
 * 
 * @ClassName GetPriceInfoDAO.java
 * @Description GetPriceInfoDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018. 8. 21.   kihoon        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kihoon
 * @since 2018. 8. 21.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/getPriceInfoDAO")
public class GetPriceInfoDAO extends DefaultDAO {
	
	/**
	 * 대상정보 조회
	 * <pre>
	 * - 
	 * </pre>
	 *
	 * @param  mapParam 일정시간 정보
	 * @return 처리건수
	 */
	public RecordSet selectCondList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.getPriceInfoDAO.selectCondList", mapParam);
	}
	
	/**
	 * 대상정보 조회
	 * <pre>
	 * - 
	 * </pre>
	 *
	 * @param  mapParam 일정시간 정보
	 * @return 처리건수
	 */
	public RecordSet selectTargetList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.getPriceInfoDAO.selectTargetList", mapParam);
	}
	
	/**
	 * 가격정보 삭제
	 * <pre>
	 * - 
	 * </pre>
	 *
	 * @param  mapParam 일정시간 정보
	 * @return 처리건수
	 */
	public int deletePriceInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.getPriceInfoDAO.deletePriceInfo", mapParam);
	}
	
	/**
	 * 가격정보 수집
	 * <pre>
	 * - 
	 * </pre>
	 *
	 * @param  mapParam 일정시간 정보
	 * @return 처리건수
	 */
	public int insertPriceInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.getPriceInfoDAO.insertPriceInfo", mapParam);
	}

}
