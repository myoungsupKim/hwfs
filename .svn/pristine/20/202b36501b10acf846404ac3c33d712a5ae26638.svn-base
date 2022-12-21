package com.hwfs.sc.cmn.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dao.AutoLogoutDAO;

/**
 * 어플리케이션 비정상 종료에 대한 자동 로그아웃 처리하는 Service Implementation
 * 
 * @ClassName AutoLogoutServiceImpl.java
 * @Description AutoLogoutServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 7. 7.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 7. 7.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/autoLogoutService")
public class AutoLogoutServiceImpl extends DefaultServiceImpl implements AutoLogoutService {
	
	/** AutoLogoutDAO Bean 생성 */
	@Resource(name = "/sc/cmn/autoLogoutDAO")
	private AutoLogoutDAO autoLogoutDAO;
	

	
	/**
	 * 어플리케이션 비정상 종료에 대한 자동 로그아웃을 처리한다.
	 * <pre>
	 * - 스케쥴러에 의해 호출된다.
	 * - SCC_CONN_USER에서 현재 로그인상태이며 일정시간 사용하지 않은 경우 로그아웃 상태로 변경한다.
	 * </pre>
	 *
	 * @return 처리건수
	 * @throws Exception
	 */
	public int processAutoLogout () throws Exception {
		//처리기준 설정
		Map<String, Object> mapParam = new HashMap<String, Object>();
		mapParam.put("overMinute", propertiesService.getInt("autologout.over.mimute", 30));
		
		return autoLogoutDAO.updateAutoLogout(mapParam);
	}

}
