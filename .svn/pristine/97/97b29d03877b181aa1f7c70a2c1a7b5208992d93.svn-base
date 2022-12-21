package com.hwfs.sc.sca.service;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.sca.dao.AuthByMenuRetvDAO;

/**
 * 메뉴별 권한정보를 조회하는 AuthByMenuRetv Service Implementation
 *
 * @ClassName AuthByMenuRetvServiceImpl.java
 * @Description AuthByMenuRetvServiceImpl Class
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
@Service("/sc/sca/authByMenuRetvService")
public class AuthByMenuRetvServiceImpl extends DefaultServiceImpl implements
		AuthByMenuRetvService {

	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/** AuthByMenuRetvDAO Bean 생성 */
	@Resource(name = "/sc/sca/authByMenuRetvDAO")
	private AuthByMenuRetvDAO authByMenuRetvDAO;

	/**
	 * 메뉴별 권한정보 메뉴목록을 조회한다.
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
	public RecordSet selectMenuList(Map<String, Object> mapParam)
			throws Exception {
		return authByMenuRetvDAO.selectMenuList(mapParam);
	}

	/**
	 * 메뉴별 권한정보 권한/사용자목록을 조회한다.
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
	public Map<String, RecordSet> selectList(Map<String, Object> mapParam)
			throws Exception {
		Map<String, RecordSet> rtn = new HashMap<String, RecordSet>();

		rtn.put("RoleList", authByMenuRetvDAO.selectRoleList(mapParam));
		rtn.put("UserList", authByMenuRetvDAO.selectUserList(mapParam));

		return rtn;
	}

}
