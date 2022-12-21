package com.hwfs.sm.saa.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.saa.dao.AccdClientListDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * 사고 거래선 현황하는 AccdClientList Service Implementation
 * 
 * @ClassName AccdClientListServiceImpl.java
 * @Description AccdClientListServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.29    김미경        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김미경
 * @since 2015.05.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/saa/accdClientListService")
public class AccdClientListServiceImpl extends DefaultServiceImpl implements AccdClientListService {

	/** AccdClientListDAO Bean 생성 */
	@Resource(name = "/sm/saa/accdClientListDAO")
	private AccdClientListDAO accdClientListDAO;
	

	/**
	 * 기간별 사고거래선에 대한 채권현황을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return accdClientListDAO.selectList(mapParam);
	}

}
