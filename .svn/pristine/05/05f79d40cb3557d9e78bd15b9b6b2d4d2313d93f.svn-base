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
import com.hwfs.ms.msm.dao.CustomerInformationInquiryDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * 거래처정보조회하는 CustomerInformationInquiry Service Implementation
 * 
 * @ClassName CustomerInformationInquiryServiceImpl.java
 * @Description CustomerInformationInquiryServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.25    강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 모바일 강대성
 * @since 2015.03.25
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ms/msm/customerInformationInquiryService")
public class CustomerInformationInquiryServiceImpl extends DefaultServiceImpl implements CustomerInformationInquiryService {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** CustomerInformationInquiryDAO Bean 생성 */
	@Resource(name = "/ms/msm/customerInformationInquiryDAO")
	private CustomerInformationInquiryDAO customerInformationInquiryDAO;
	

	/**
	 * 거래처정보조회(가망고객) 목록을 조회한다.
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
	public RecordSet selectCustList(Map<String, Object> mapParam) throws Exception {
		return customerInformationInquiryDAO.selectCustList(mapParam);
	}
	
	/**
	 * 거래처정보조회(거래고객) 목록을 조회한다.
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
	public RecordSet selectUpjangList(Map<String, Object> mapParam) throws Exception {
		return customerInformationInquiryDAO.selectUpjangList(mapParam);
	}
	
}
