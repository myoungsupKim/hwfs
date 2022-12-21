// [속도개선 Project 시작] 2017. 7. 3. 최범주 입금처리이력 및 매출보정이력을 조회한다.
package com.hwfs.fm.fmf.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fmf.dao.SaleModifyHistoryDAO;

/**
 * 입금처리이력 및 매출보정이력을 조회하는 SaleModifyHistory Service Implementation
 * 
 * @ClassName SaleModifyHistoryServiceImpl.java
 * @Description SaleModifyHistoryServiceImpl Class 
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
@Service("/fm/fmf/saleModifyHistoryService")
public class SaleModifyHistoryServiceImpl extends DefaultServiceImpl implements SaleModifyHistoryService {

	/** SaleModifyHistoryDAO Bean 생성 */
	@Resource(name = "/fm/fmf/saleModifyHistoryDAO")
	private SaleModifyHistoryDAO saleModifyHistoryDAO;

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/**
	 * 입금처리이력 및 매출보정이력 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		RecordSet rtn_rs = null;
		String tabIndex = mapParam.get("tabIndex").toString();
		
		logger.debug("★★★★★ 탭 인덱스 : [" + tabIndex + "]");
		
		// 입금처리이력일 경우
		if ( "0".equals(tabIndex) ) {
			rtn_rs =  saleModifyHistoryDAO.selectList1(mapParam);
			
		// 매출보정이력일 경우
		} else if ( "1".equals(tabIndex) ) {
			rtn_rs =  saleModifyHistoryDAO.selectList2(mapParam);
		}
		
		return rtn_rs;
	}	
}
// [속도개선 Project   끝] 2017. 7. 3. 최범주