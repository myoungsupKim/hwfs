package com.hwfs.sc.cmn.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;
import com.hwfs.sc.cmn.dto.PgmAuthDTO;

/**
 * 프로그램 권한, 권한에 맞는 메뉴목록을 조회하고 접속프로그램 정보를 저장하는 DAO
 * @ClassName AuthorityDAO.java
 * @Description AuthorityDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 2.10.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 2.10.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/authorityDAO")
public class AuthorityDAO extends DefaultDAO {

	/**
	 * 권한이 적용되지 않는 프로그램 권한을 조회한다.
	 *
	 * @param
	 * @return
	 * @throws Exception
	 */
	public PgmAuthDTO selectPgmAuth(Map<String, Object> inVar) throws Exception {
		Record rc = super.queryForRecord("sc.cmn.authorityDAO.selectPgmAuth", inVar);

		PgmAuthDTO pgmAuthDTO = new PgmAuthDTO();
		pgmAuthDTO.setDelYn(rc.getString("delYn"));
		pgmAuthDTO.setExlYn(rc.getString("exlYn"));
		pgmAuthDTO.setInsYn(rc.getString("insYn"));
		pgmAuthDTO.setPrtYn(rc.getString("prtYn"));
		pgmAuthDTO.setSavYn(rc.getString("savYn"));
		pgmAuthDTO.setSrcYn(rc.getString("srcYn"));
		pgmAuthDTO.setPersInfoYn(rc.getString("persInfoYn"));
		pgmAuthDTO.setAdminYn(rc.getString("adminYn"));
		pgmAuthDTO.setAuthApplyYn(rc.getString("authApplyYn"));

		return pgmAuthDTO;
	}

	/**
	 * 권한이 적용된 프로그램 권한을 조회한다.
	 *
	 * @param
	 * @return
	 * @throws Exception
	 */
	public PgmAuthDTO selectAuthorityApplyPgmAuth(Map<String, Object> inVar) throws Exception {
		Record rc = super.queryForRecord("sc.cmn.authorityDAO.selectAuthorityApplyPgmAuth", inVar);

		PgmAuthDTO pgmAuthDTO = new PgmAuthDTO();
		pgmAuthDTO.setDelYn(rc.getString("delYn"));
		pgmAuthDTO.setExlYn(rc.getString("exlYn"));
		pgmAuthDTO.setInsYn(rc.getString("insYn"));
		pgmAuthDTO.setPrtYn(rc.getString("prtYn"));
		pgmAuthDTO.setSavYn(rc.getString("savYn"));
		pgmAuthDTO.setSrcYn(rc.getString("srcYn"));
		pgmAuthDTO.setPersInfoYn(rc.getString("persInfoYn"));
		pgmAuthDTO.setAdminYn(rc.getString("adminYn"));
		pgmAuthDTO.setAuthApplyYn(rc.getString("authApplyYn"));
		
		return pgmAuthDTO;
	}

	/**
	 * 권한이 적용되지 않는 시스템별 메뉴를 조회한다.
	 *
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectMenu(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.cmn.authorityDAO.selectMenu", parameter);
	}

	/**
	 * 권한이 적용되어 있는 시스템별 메뉴를 조회한다.
	 *
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectAuthorityApplyMenu(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.cmn.authorityDAO.selectAuthorityApplyMenu", parameter);
	}

	/**
	 * 접속프로그램 정보를 update한다.
	 *
	 * @return 처리건수
	 * @throws Exception
	 */
	public int updateConnUserPgm(Map<String, Object> parameter) throws Exception {
		return super.update("sc.cmn.authorityDAO.updateConnUserPgm", parameter);
	}

}
