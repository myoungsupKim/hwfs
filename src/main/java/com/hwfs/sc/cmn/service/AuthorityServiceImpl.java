package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dao.AuthorityDAO;
import com.hwfs.sc.cmn.dto.PgmAuthDTO;
import com.hwfs.sc.scc.service.SysUseStatisticsService;

 /**
 * 프로그램 권한, 권한에 맞는 메뉴목록을 조회하고 접속프로그램 정보를 저장하는 Authority ServiceImpl
 * @ClassName AuthorityServiceImpl.java
 * @Description AuthorityServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 02. 10.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 02. 10.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/authorityService")
public class AuthorityServiceImpl extends DefaultServiceImpl implements AuthorityService {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** AuthorityDAO */
    @Resource(name="/sc/cmn/authorityDAO")
    private AuthorityDAO authorityDAO;

	/** SysUseStatisticsService Bean 생성 */
	@Resource(name = "/sc/scc/sysUseStatisticsService")
	private SysUseStatisticsService sysUseStatisticsService;

	/**
	 * 프로그램 사용권한을 조회한다.
	 * <pre>
	 * - 로그인 사용자가 프로그램을 사용할 수 있는 권한을 조회
	 * </pre>
	 *
	 * @param inVar
	 * @return PgmAuthDTO
	 * @throws Exception
	 */
	public PgmAuthDTO selectPgmAuth(Map<String, Object> inVar)
			throws Exception {
		//권한을 적용한 프로그램 권한을 조회한다.
		if (super.propertiesService.getBoolean("authority.apply"))
			return authorityDAO.selectAuthorityApplyPgmAuth(inVar);
		//권한을 적용하지 않는 프로그램 권한을 조회한다.(개발모드)
		else
			return authorityDAO.selectPgmAuth(inVar);
	}

    /**
     * 접속한 사용자가 사용할 수 있는 메뉴를 조회한다.
     *
	 * @param inVar
     * @throws Exception
     */
	public RecordSet selectMenu(Map<String, Object> inVar)
			throws Exception {
		//권한을 적용한 메뉴를 조회한다.
		if (super.propertiesService.getBoolean("authority.apply"))
			return authorityDAO.selectAuthorityApplyMenu(inVar);
		//권한을 적용하지 않는 메뉴를 조회한다.(개발모드)
		else
			return authorityDAO.selectMenu(inVar);
	}

	/**
	 * 시스템사용정보를 저장한다.
	 * <pre>
	 * - 시스템사용통계 처리
	 * - 접속프로그램 정보 처리
	 * - Exception을 발생시키지 않도록 한다. (Exception 무시)
	 * </pre>
	 *
	 * @param inVar
	 */
	public void saveSysUseInfo (Map<String, Object> inVar) {
		try {
			//시스템사용통계 및 접속프로그램 정보 처리
			sysUseStatisticsService.saveStatisticsNewTx(inVar);

			//접속프로그램 정보 update
			authorityDAO.updateConnUserPgm(inVar);
		}catch (Exception e) {
			//Exception 무시
			logger.error("error at AuthorityServiceImpl.saveSysInfo : {}", e.getMessage());
		}
	}

	/**
	 * 접속프로그램 정보를 저장한다.
	 * <pre>
	 * - Exception을 발생시키지 않도록 한다. (Exception 무시)
	 * </pre>
	 *
	 * @param inVar
	 */
	public void updateConnUserPgm (Map<String, Object> inVar) {
		try {
			//접속프로그램 정보 update
			authorityDAO.updateConnUserPgm(inVar);
		}catch (Exception e) {
			//Exception 무시
			logger.error("error at AuthorityServiceImpl.updateConnUserPgm : {}", e.getMessage());
		}
	}

}
