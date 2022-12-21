package com.hwfs.sc.sch.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.sch.dao.AuthChngHistDAO;

/**
 * 권한변경이력을 관리하는 AuthChngHist Service Implementation
 * 
 * @ClassName AuthChngHistServiceImpl.java
 * @Description AuthChngHistServiceImpl Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.24    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.03.24
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/sch/authChngHistService")
public class AuthChngHistServiceImpl extends DefaultServiceImpl implements
		AuthChngHistService {

	/** AuthChngHistDAO Bean 생성 */
	@Resource(name = "/sc/sch/authChngHistDAO")
	private AuthChngHistDAO authChngHistDAO;

	/**
	 * 권한변경이력 목록을 조회한다.
	 * 
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return authChngHistDAO.selectList(mapParam);
	}

}
