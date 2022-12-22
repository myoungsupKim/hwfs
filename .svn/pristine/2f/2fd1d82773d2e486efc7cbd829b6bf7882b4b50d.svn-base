package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dao.CustSearchDAO;

/**
 * 거래처를 검색하는 CustSearch Service Implementation
 *
 * @ClassName CustSearchServiceImpl.java
 * @Description CustSearchServiceImpl Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.23    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.03.23
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/custSearchService")
public class CustSearchServiceImpl extends DefaultServiceImpl implements
		CustSearchService {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/** CustSearchDAO Bean 생성 */
	@Resource(name = "/sc/cmn/custSearchDAO")
	private CustSearchDAO custSearchDAO;

	/**
	 * 거래처 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		// Parameter에 대한 Log를 기록한다.
		logParameter(mapParam);

		return custSearchDAO.selectList(mapParam);
	}

	/**
	 * Parameter의 값을 출력한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @throws Exception
	 */
	private void logParameter(Map<String, Object> parameter) throws Exception {
		Set<String> key = parameter.keySet();
		Iterator<String> it = key.iterator();

		logger.debug("================================================================================");
		logger.debug(" Cust Search Parameter");
		logger.debug("================================================================================");
		while (it.hasNext()) {
			String k = it.next();
			logger.debug(" " + k + " : " + parameter.get(k));
		}
		logger.debug("================================================================================");
	}
}
