package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import com.hwfs.sc.cmn.dto.PgmAuthDTO;

 /**
 * 프로그램 권한, 권한에 맞는 메뉴목록을 조회하고 접속프로그램 정보를 저장하는 Authority Service Interface
 * 
 * @ClassName AuthorityService.java
 * @Description AuthorityService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.02.10.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 02. 10.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface AuthorityService {
	
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
	public PgmAuthDTO selectPgmAuth (Map <String, Object> inVar) throws Exception;

    /**
     * 접속한 사용자가 사용할 수 있는 메뉴를 조회한다.
     *
	 * @param inVar
     * @throws Exception
     */
	public RecordSet selectMenu (Map <String, Object> inVar) throws Exception;
	
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
	public void saveSysUseInfo (Map<String, Object> inVar);

	/**
	 * 접속프로그램 정보를 저장한다.
	 * <pre>
	 * - Exception을 발생시키지 않도록 한다. (Exception 무시)
	 * </pre>
	 *
	 * @param inVar
	 */
	public void updateConnUserPgm (Map<String, Object> inVar);

}
