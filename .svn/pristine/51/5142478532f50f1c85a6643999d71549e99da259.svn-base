package com.hwfs.guide.sample.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.guide.sample.dao.TestErrorDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * 오류 발생을 테스트하는 TestError Service Implementation
 * 
 * @ClassName TestErrorServiceImpl.java
 * @Description TestErrorServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.10.16    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.10.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/guide/sample/testErrorService")
public class TestErrorServiceImpl extends DefaultServiceImpl implements TestErrorService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** TestErrorDAO Bean 생성 */
	@Resource(name = "/guide/sample/testErrorDAO")
	private TestErrorDAO testErrorDAO;
	

	/**
	 * 오류 발생 테스트
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet raiseHoneErr1(Map<String, Object> mapParam) throws Exception {
		return testErrorDAO.raiseHoneErr1(mapParam);
	}

	/**
	 * 오류 발생 테스트
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet raiseHoneErr2(Map<String, Object> mapParam) throws Exception {
		return testErrorDAO.raiseHoneErr2(mapParam);
	}
}
