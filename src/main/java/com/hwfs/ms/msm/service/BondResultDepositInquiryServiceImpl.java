package com.hwfs.ms.msm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ms.msm.dao.BondResultDepositInquiryDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * 거래처별 채권/실적/입금조회하는 BondResultDepositInquiry Service Implementation
 * 
 * @ClassName BondResultDepositInquiryServiceImpl.java
 * @Description BondResultDepositInquiryServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.01    강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 현장지원_모바일 강대성
 * @since 2015.06.01
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ms/msm/bondResultDepositInquiryService")
public class BondResultDepositInquiryServiceImpl extends DefaultServiceImpl implements BondResultDepositInquiryService {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** BondResultDepositInquiryDAO Bean 생성 */
	@Resource(name = "/ms/msm/bondResultDepositInquiryDAO")
	private BondResultDepositInquiryDAO bondResultDepositInquiryDAO;
	

	/**
	 * 거래처별 채권/실적/입금조회 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return bondResultDepositInquiryDAO.selectList(mapParam);
	}
	
}
