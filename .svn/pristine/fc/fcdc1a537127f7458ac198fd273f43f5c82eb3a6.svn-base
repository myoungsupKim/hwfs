package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dao.FindDeptDAO;

 /**
 * 사업부-팀에 속하는 부서를 조회하는 FindDept Service Implementation
 * 
 * @ClassName FindDeptServiceImpl.java
 * @Description FindDeptServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.16    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.06.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/findDeptService")
public class FindDeptServiceImpl extends DefaultServiceImpl implements FindDeptService {
	
	/** FindDeptDAO Bean 생성 */
	@Resource(name = "/sc/cmn/findDeptDAO")
	private FindDeptDAO findDeptDAO;
	

	/**
	 * 사업부-팀에 속하는 부서 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectDeptList(Map<String, Object> mapParam) throws Exception {
		return findDeptDAO.selectDeptList(mapParam);
	}
}
