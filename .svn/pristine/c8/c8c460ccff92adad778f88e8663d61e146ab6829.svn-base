package com.hwfs.sc.cmn.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.service.SessionService;
import com.hwfs.sc.cmn.dao.LoginDAO;


 /**
 * WAS에서 발생시킨 Session Destroyed 이벤트를 처리하기 위한 Service Implementation
 * - 프로젝트에서 상속받아 DB에 로그아웃 처리한다. 
 * @ClassName SessionServiceImpl.java
 * @Description SessionServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 9. 14.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 9. 14.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service
public class SessionServiceImpl implements SessionService {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** LoginDAO */
    @Resource(name="/sc/cmn/loginDAO")
    private LoginDAO loginDAO;
    
	/**
	 * 세션이 삭제될 때 발생하는 이벤트
	 * <pre>
	 * - SessionTimeout에 의해 발생
	 * - 프로젝트에서 상속받아 logout 처리 한다.
	 * </pre>
	 *
	 * @param sessionId  Session ID
	 */
	@Override
	public void sessionDestroyed(String sessionId) {
		Map<String, Object> mapParam = new HashMap<String, Object>();
		mapParam.put("sessionId", sessionId);
		try {
			//미접속 상태로 변경한다.
			loginDAO.changeLogoutStatusBySessionId(mapParam);
		}catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
 	}

}
