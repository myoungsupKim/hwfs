package com.hwfs.sc.scu.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.scu.dao.UserMenuDAO;

 /**
 * 사용자별 부여 메뉴를 조회하는 UserMenu Service Implementation
 *
 * @ClassName UserMenuServiceImpl.java
 * @Description UserMenuServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.20    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.07.20
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scu/userMenuService")
public class UserMenuServiceImpl extends DefaultServiceImpl implements UserMenuService {

	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** UserMenuDAO Bean 생성 */
	@Resource(name = "/sc/scu/userMenuDAO")
	private UserMenuDAO userMenuDAO;


	/**
	 * 사용자별 메뉴 목록을 조회한다.
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
		return userMenuDAO.selectList(mapParam);
	}
}
