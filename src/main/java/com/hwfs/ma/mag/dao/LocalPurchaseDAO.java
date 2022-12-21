package com.hwfs.ma.mag.dao;

import hone.core.util.record.RecordSet;
import java.util.Map;
import org.springframework.stereotype.Repository;
import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 현지구매내역 LocalPurchaseDAO
 * 
 * @ClassName LocalPurchaseDAO.java
 * @Description  DAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2017.02.24	kihoon			[CH201703_00046] 최초작성
 * </pre>
 * @author FC종합전산구축 : 통합영업 박준석
 * @since 2017.02.27
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ma/mag/localPurchaseDAO")
public class LocalPurchaseDAO extends DefaultDAO {
	
	/**
	 * 정산유형코드 조회.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDltCdList(Map<String, Object> mapParam) throws Exception {
			return super.queryForRecordSet("ma.mag.localPurchaseDAO.selectDltCdList", mapParam);
	}
	
	/**
	 * 현지구매내역조회
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ma.mag.localPurchaseDAO.selectList", mapParam);
	}
}
