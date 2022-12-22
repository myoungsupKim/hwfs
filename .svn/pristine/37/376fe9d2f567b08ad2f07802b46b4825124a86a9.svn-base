package com.hwfs.sc.cmn.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 개인정보취급방침 동의를 관리하는 PersInfoProcPolicy DAO
 * 
 * @ClassName PersInfoProcPolicyDAO.java
 * @Description PersInfoProcPolicyDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.24   	kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.04.24
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/persInfoProcPolicyDAO")
public class PersInfoProcPolicyDAO extends DefaultDAO {
	
	/**
	 * 개인정보취급방침 동의를(을) 저장한다.
	 *
	 * @param mapParam
	 * @return 처리건수
	 */
	public int saveAgreeInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.persInfoProcPolicyDAO.saveAgreeInfo", mapParam);
	}
	
	/**
	 * 개인정보취급방침 동의를(을) 저장한다.
	 *
	 * @param mapParam
	 * @return 처리건수
	 */
	public int saveHRAgree(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.persInfoProcPolicyDAO.saveHRAgree", mapParam);
	}
	
}
