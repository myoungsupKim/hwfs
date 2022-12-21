package com.hwfs.sm.sar.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.sar.dao.CardIsaApDataInquiryDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * 신용카드 거래내역 정보(SFTP파일 다운로드 내용) 조회하는 CardIsaApDataInquiry Service Implementation
 * 
 * @ClassName CardIsaApDataInquiryServiceImpl.java
 * @Description CardIsaApDataInquiryServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016.01.20    DSKANG        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유성진
 * @since 2016.01.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/sar/cardIsaApDataInquiryService")
public class CardIsaApDataInquiryServiceImpl extends DefaultServiceImpl implements CardIsaApDataInquiryService {
	
	/** CardIsaApDataInquiryDAO Bean 생성 */
	@Resource(name = "/sm/sar/cardIsaApDataInquiryDAO")
	private CardIsaApDataInquiryDAO cardIsaApDataInquiryDAO;
	

	/**
	 * 신용카드 거래내역 정보(SFTP파일 다운로드 내용) 조회한다.
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
		return cardIsaApDataInquiryDAO.selectList(mapParam);
	}
	
}
