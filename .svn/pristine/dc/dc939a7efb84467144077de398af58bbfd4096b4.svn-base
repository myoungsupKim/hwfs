package com.hwfs.sc.cmn.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 본인인증을 처리하는하는 OwnCert DAO
 * 
 * @ClassName OwnCertDAO.java
 * @Description OwnCertDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.27   	kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.04.27
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/ownCertDAO")
public class OwnCertDAO extends DefaultDAO {
	
	/**
	 * 등록된 사용자인지를 조회한다.
	 *
	 * @param mapParam
	 * @return String 
	 */
	public String selectUserInfo(Map<String, Object> mapParam) throws Exception {
		return (String)super.queryForObject("sc.cmn.ownCertDAO.selectUserInfo", mapParam, String.class);
	}

	/**
	 * 등록된 본인인증번호를 조회한다.
	 *
	 * @param mapParam
	 * @return String 
	 */
	public String selectCernNum(Map<String, Object> mapParam) throws Exception {
		return (String)super.queryForObject("sc.cmn.ownCertDAO.selectCernNum", mapParam, String.class);
	}

	/**
	 * 본인인증 처리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return 처리건수
	 */
	public int updateCernNum(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.ownCertDAO.updateCernNum", mapParam);
	}
	
}
