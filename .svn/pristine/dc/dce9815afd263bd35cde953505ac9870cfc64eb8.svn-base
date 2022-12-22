package com.hwfs.sc.cmn.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * VAN 사 사업장 매핑 관리하는 DAO
 * 
 * @ClassName VanBrchMapnMgtDAO.java
 * @Description VanBrchMapnMgtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.15   	ChAoS        최초생성
 * </pre>
 * @author 통합영업회계(ISA) : ChAoS
 * @since 2015.07.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/vanBrchMapnMgtDAO")
public class VanBrchMapnMgtDAO extends DefaultDAO {
	
	/**
	 * VAN 사 사업장 매핑 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectVanBrchMapnList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.vanBrchMapnMgtDAO.selectVanBrchMapnList", mapParam);
	}

	/**
	 * VAN 사 SFTP 접속정보를 중복 제거하여 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectVanSftpConnInfoList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.vanBrchMapnMgtDAO.selectVanSftpConnInfoList", mapParam);
	}

}