package com.hwfs.sc.cmn.service;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dao.PersInfoProcPolicyDAO;

 /**
 * 개인정보취급방침 동의를 관리하는 PersInfoProcPolicy Service Implementation
 * 
 * @ClassName PersInfoProcPolicyServiceImpl.java
 * @Description PersInfoProcPolicyServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.24    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.04.24
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/persInfoProcPolicyService")
public class PersInfoProcPolicyServiceImpl extends DefaultServiceImpl implements PersInfoProcPolicyService {
	
	/** PersInfoProcPolicyDAO Bean 생성 */
	@Resource(name = "/sc/cmn/persInfoProcPolicyDAO")
	private PersInfoProcPolicyDAO persInfoProcPolicyDAO;
	

	/**
	 * 개인정보취급방침 동의를 저장한다.
	 *
	 * @param mapParam
	 *            Map 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	public int saveAgreeInfo(Map<String, Object> mapParam) throws Exception {
		return persInfoProcPolicyDAO.saveAgreeInfo(mapParam);
	}
	
	/**
	 * 노무수령거부 동의를 저장한다.
	 *
	 * @param mapParam
	 *            Map 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	public int saveHRAgree(Map<String, Object> mapParam) throws Exception {
		return persInfoProcPolicyDAO.saveHRAgree(mapParam);
	}
}
