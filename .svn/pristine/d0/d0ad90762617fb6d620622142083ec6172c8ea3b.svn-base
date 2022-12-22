package com.hwfs.sc.cmn.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 어플리케이션 비정상 종료에 대한 자동 로그아웃 처리하는 DAO
 * 
 * @ClassName AutoLogoutDAO.java
 * @Description AutoLogoutDAO Class 
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
@Repository("/sc/cmn/autoLogoutDAO")
public class AutoLogoutDAO extends DefaultDAO {
	
	/**
	 * 어플리케이션 비정상 종료에 대한 자동 로그아웃을 처리한다.
	 * <pre>
	 * - SCC_CONN_USER에서 현재 로그인상태이며 일정시간 사용하지 않은 경우 로그아웃 상태로 변경한다.
	 * </pre>
	 *
	 * @param  mapParam 일정시간 정보
	 * @return 처리건수
	 */
	public int updateAutoLogout(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.autoLogoutDAO.updateAutoLogout", mapParam);
	}

}
