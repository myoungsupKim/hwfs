package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * VAN 사 사업장 매핑 관리하는 Service Interface
 * 
 * @ClassName VanBrchMapnMgtService.java
 * @Description VanBrchMapnMgtService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.15    ChAoS        최초생성
 *  
 * </pre>
 * @author 통합영업회계(ISA) : ChAoS
 * @since 2015.07.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface VanBrchMapnMgtService {

	/**
	 * VAN 사 사업장 매핑 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectVanBrchMapnList(Map<String, Object> mapParam) throws Exception;

	/**
	 * VAN 사 SFTP 접속정보를 중복 제거하여 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectVanSftpConnInfoList(Map<String, Object> mapParam) throws Exception;
	
}