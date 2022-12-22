package com.hwfs.ms.mef.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ms.mef.dao.EfoodistWebzineDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * E-FOODIST웹 매거진 조회하는 EfoodistWebzine Service Implementation
 * 
 * @ClassName EfoodistWebzineServiceImpl.java
 * @Description EfoodistWebzineServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.18    강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 모바일(E-FOODIST웹 매거진) 강대성
 * @since 2015.03.18
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ms/mef/efoodistWebzineService")
public class EfoodistWebzineServiceImpl extends DefaultServiceImpl implements EfoodistWebzineService {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** EfoodistWebzineDAO Bean 생성 */
	@Resource(name = "/ms/mef/efoodistWebzineDAO")
	private EfoodistWebzineDAO efoodistWebzineDAO;
	

	/**
	 * E-FOODIST웹 매거진 조회 목록을 조회한다.
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
		return efoodistWebzineDAO.selectList(mapParam);
	}	
}
