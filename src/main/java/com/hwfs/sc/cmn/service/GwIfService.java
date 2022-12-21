package com.hwfs.sc.cmn.service;

import hone.core.util.record.Record;

import javax.servlet.http.HttpServletRequest;

 /**
 * 그룹웨어 연동하는 GwIf Service Interface
 * 
 * @ClassName GwIfService.java
 * @Description GwIfService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.18    kksoo        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.03.18
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface GwIfService {

	/**
	 * SLO 연계를 위한 OTA ID를 생성하여 얻는다.
	 *
	 * @param request HttpServletRequest
	 * @return String OTA ID
	 * @throws Exception
	 */
	String selectOtaId (HttpServletRequest request) throws Exception;
	String selectSabun (HttpServletRequest request) throws Exception;
	/**
	 * 전자결재연동 상태를 처리한다.
	 * <pre>
	 * - 스케쥴러에 의해 호출된다.
	 * - SIGN_IF.TB_EVT_INFO에 쌓이는 정보 중 미처리된 건을 읽어 처리
	 * - SIGN_IF.TB_EVT_INFO에 처리 상태로 Update
	 * - SCC_SIGN_INFO에 결재진행정보 Insert orUpdate
	 * </pre>
	 *
	 * @return 처리건수
	 * @throws Exception
	 */
	int processSignStatus () throws Exception;

	/**
	 * 전자결재연동 상태를 건별로 트랜잭션을 분리해서 처리한다.
	 * <pre>
	 * - SIGN_IF.TB_EVT_INFO에 쌓이는 정보 중 미처리된 건을 읽어 처리
	 * - SIGN_IF.TB_EVT_INFO에 처리 상태로 Update
	 * - SCC_SIGN_INFO에 결재진행정보 Insert orUpdate
	 * - 건별로 트랜잭션을 분리해서 처리
	 * </pre>
	 *
	 * @return 처리건수
	 * @throws Exception
	 */
	int processSignStatusNewTx (Record record) throws Exception;

}
