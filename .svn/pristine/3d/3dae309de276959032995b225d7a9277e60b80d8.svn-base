package com.hwfs.sc.scc.service;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dao.LoginDAO;
import com.hwfs.sc.scc.dao.ConnectUserDAO;

/**
 * 접속사용자를 조회하는 ConnectUser Service Implementation
 *
 * @ClassName ConnectUserServiceImpl.java
 * @Description ConnectUserServiceImpl Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.08    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.05.08
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scc/connectUserService")
public class ConnectUserServiceImpl extends DefaultServiceImpl implements
		ConnectUserService {

	/** LogService */
	// private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** ConnectUserDAO Bean 생성 */
	@Resource(name = "/sc/scc/connectUserDAO")
	private ConnectUserDAO connectUserDAO;

	/** LoginDAO */
    @Resource(name="/sc/cmn/loginDAO")
    private LoginDAO loginDAO;
    
	/**
	 * CC별 접속자수를 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectCcByConnectList(Map<String, Object> mapParam)
			throws Exception {
		return connectUserDAO.selectCcByConnectList(mapParam);
	}

	/**
	 * CC별 접속자수를 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectUserList(Map<String, Object> mapParam)
			throws Exception {
		return connectUserDAO.selectList(mapParam);
	}

	/**
	 * 접속사용자 목록을 조회한다.
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

		rtn.put("ccByConnectList",
				connectUserDAO.selectCcByConnectList(mapParam));

		if (mapParam.containsKey("sabun")
				&& !"".equals(mapParam.get("sabun").toString())) {
			rtn.put("userList", connectUserDAO.selectList(mapParam));
		} else {
			rtn.put("userList", null);
		}

		return rtn;
	}
	
	/**
	 * 미접속 상태로 변경한다.
	 *
	 * @param listParam
	 * @throws Exception
	 */
	public void changeDisconnStatus(List<Map<String, Object>> listParam) throws Exception {
		for (int i=0; i<listParam.size(); i++) {
			loginDAO.changeLogoutStatus(listParam.get(i));
		}
	}

}
