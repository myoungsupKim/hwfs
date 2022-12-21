package com.hwfs.sc.scz.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 업장마스터 주소를 관리하는 AddrMgmtStUpjang DAO
 * 
 * @ClassName AddrMgmtStUpjangDAO.java
 * @Description AddrMgmtStUpjangDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.10.05   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.10.05
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scz/addrMgmtStUpjangDAO")
public class AddrMgmtStUpjangDAO extends DefaultDAO {
	
	/**
	 * 업장마스터 주소 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.addrMgmtStUpjangDAO.selectList", mapParam);
	}

	/**
	 * 업장마스터 주소(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.addrMgmtStUpjangDAO.update", mapParam);
	}
	
}
