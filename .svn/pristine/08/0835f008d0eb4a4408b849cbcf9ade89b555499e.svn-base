package com.hwfs.sc.scu.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.sc.cmn.dao.LoginDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.scu.dao.UserChangeDAO;

 /**
 * 사용자 변경을하는 UserChange Service Implementation
 * 
 * @ClassName UserChangeServiceImpl.java
 * @Description UserChangeServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.08.19    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.08.19
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scu/userChangeService")
public class UserChangeServiceImpl extends DefaultServiceImpl implements UserChangeService {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** UserChangeDAO Bean 생성 */
	@Resource(name = "/sc/scu/userChangeDAO")
	private UserChangeDAO userChangeDAO;
	
	/** LoginDAO */
    @Resource(name="/sc/cmn/loginDAO")
    private LoginDAO loginDAO;

	/**
	 * 사용자 변경 목록을 조회한다.
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
		return userChangeDAO.selectList(mapParam);
	}
	
	public LoginDTO doLogin (HttpServletRequest req, Map<String, Object> mapParam) throws Exception {
		//무단사용자 점검을 위한 설정 추가
		mapParam.put("connIp", req.getRemoteAddr());
		mapParam.put("applyAuthYn", super.propertiesService.getBoolean("authority.apply")?"Y":"N");
		mapParam.put("pwd", "tmpPwd");

		//사용자정보 조회
		LoginDTO loginDTO = loginDAO.selectLoginInfo(mapParam);

		loginDTO.setAccessIp(req.getRemoteAddr()); 	// 사용자접속 IP 설정

		if (SessionUtil.isLogin(req))
			SessionUtil.removeLoginSession(req);

		// 로그인 세션에 저장
		SessionUtil.setLoginSession(req, loginDTO);
		
		//사용자변경이력을 생성한다.
		userChangeDAO.insertUserChngLog(mapParam);

		return loginDTO;
	}

	/**
	 * upadteAcctStatus 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @throws Exception
	 * @see com.hwfs.sc.scu.service.UserChangeService#upadteAcctStatus(java.util.Map)
	*/
	@Override
	public void upadteAcctStatus(Map<String, Object> mapParam) throws Exception {
		userChangeDAO.upadteAcctStatus(mapParam);
		
	}

	/**
	 * upadtePassword 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @throws Exception
	 * @see com.hwfs.sc.scu.service.UserChangeService#upadtePassword(java.util.Map)
	*/
	@Override
	public void upadtePassword(Map<String, Object> mapParam) throws Exception {
		if ("내부".equals(mapParam.get("userType").toString())) {
			mapParam.put("pwd", mapParam.get("sabun").toString());
		}
		else {
			mapParam.put("pwd", mapParam.get("sabun").toString().replaceAll("CS", ""));
		}
		
		userChangeDAO.upadtePassword(mapParam);
	}

}
