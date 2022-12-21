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
import com.hwfs.ms.msm.dao.DeptSearchPopDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * 부서조회팝업하는 DeptSearchPop Service Implementation
 * 
 * @ClassName DeptSearchPopServiceImpl.java
 * @Description DeptSearchPopServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.16    강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 모바일 강대성
 * @since 2015.03.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ms/msm/deptSearchPopService")
public class DeptSearchPopServiceImpl extends DefaultServiceImpl implements DeptSearchPopService {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** DeptSearchPopDAO Bean 생성 */
	@Resource(name = "/ms/msm/deptSearchPopDAO")
	private DeptSearchPopDAO deptSearchPopDAO;
	

	/**
	 * 부서조회팝업 목록을 조회한다.
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
		return deptSearchPopDAO.selectList(mapParam);
	}
	
	/**
	 * 담당자조회팝업 목록을 조회한다.
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
	public RecordSet selectSabunList(Map<String, Object> mapParam) throws Exception {
		return deptSearchPopDAO.selectSabunList(mapParam);
	}
	
	/**
	 * 영업사원 팝업 목록을 조회한다.
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
	public RecordSet selectSalesPersonList(Map<String, Object> mapParam) throws Exception {
		return deptSearchPopDAO.selectSalesPersonList(mapParam);
	}
	
}
