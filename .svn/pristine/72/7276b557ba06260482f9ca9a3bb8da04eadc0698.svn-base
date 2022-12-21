package com.hwfs.ms.msm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 부서조회팝업하는 DeptSearchPop DAO
 * 
 * @ClassName DeptSearchPopDAO.java
 * @Description DeptSearchPopDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.16   	강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 모바일 강대성
 * @since 2015.03.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ms/msm/deptSearchPopDAO")
public class DeptSearchPopDAO extends DefaultDAO {
	
	/**
	 * 부서조회팝업 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.msm.deptSearchPopDAO.selectList", mapParam);
	}	
	
	/**
	 * 담당자조회팝업 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSabunList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.msm.deptSearchPopDAO.selectSabunList", mapParam);
	}
	
	/**
	 * 영업사원검색 팝업 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSalesPersonList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.msm.deptSearchPopDAO.selectSalesPersonList", mapParam);
	}
	
}
