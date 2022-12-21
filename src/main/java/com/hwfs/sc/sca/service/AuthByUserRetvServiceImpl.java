package com.hwfs.sc.sca.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.sca.dao.AuthByUserRetvDAO;

/**
 * 권한별 사용자를 조회하는 AuthByUserRetv Service Implementation
 *
 * @ClassName AuthByUserRetvServiceImpl.java
 * @Description AuthByUserRetvServiceImpl Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.31    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.03.31
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/sca/authByUserRetvService")
public class AuthByUserRetvServiceImpl extends DefaultServiceImpl implements
		AuthByUserRetvService {

	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/** AuthByUserRetvDAO Bean 생성 */
	@Resource(name = "/sc/sca/authByUserRetvDAO")
	private AuthByUserRetvDAO authByUserRetvDAO;

	/**
	 * 권한별 사용자 목록을 조회한다.
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
		return authByUserRetvDAO.selectList(mapParam);
	}

	public RecordSet selectBoardSysType(Map<String, Object> mapParam) throws Exception {
		return authByUserRetvDAO.selectBoardSysType(mapParam);
	}
	
	public RecordSet selectBbsRoleUser(Map<String, Object> mapParam) throws Exception {
		return authByUserRetvDAO.selectBbsRoleUser(mapParam);
	}
}
