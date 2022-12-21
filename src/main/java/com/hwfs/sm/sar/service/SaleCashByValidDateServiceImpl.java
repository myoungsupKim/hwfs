package com.hwfs.sm.sar.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.sar.dao.SaleCashByValidDateDAO;

 /**
 * 영업현금을 관리하는 SaleCashByValidDate Service Implementation
 * 
 * @ClassName SaleCashByValidDateServiceImpl.java
 * @Description SaleCashByValidDateServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.22    Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.07.22
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/sar/saleCashByValidDateService")
public class SaleCashByValidDateServiceImpl extends DefaultServiceImpl implements SaleCashByValidDateService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SaleCashByValidDateDAO Bean 생성 */
	@Resource(name = "/sm/sar/saleCashByValidDateDAO")
	private SaleCashByValidDateDAO saleCashByValidDateDAO;
	

	/**
	 * 영업현금 내역 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return saleCashByValidDateDAO.selectList(mapParam);
	}
	
	/**
	 * 영업현금 내역 목록을 조회한다. (영업잔액조회 -From~To)
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList2(Map<String, Object> mapParam) throws Exception {
		return saleCashByValidDateDAO.selectList2(mapParam);
	}

}
