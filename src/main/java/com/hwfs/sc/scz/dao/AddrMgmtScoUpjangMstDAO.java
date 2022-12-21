package com.hwfs.sc.scz.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 사업장 주소정제를 보정하는 AddrMgmtScoUpjangMst DAO
 * 
 * @ClassName AddrMgmtScoUpjangMstDAO.java
 * @Description AddrMgmtScoUpjangMstDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.10.06   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.10.06
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scz/addrMgmtScoUpjangMstDAO")
public class AddrMgmtScoUpjangMstDAO extends DefaultDAO {
	
	/**
	 * 사업장 주소 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.addrMgmtScoUpjangMstDAO.selectList", mapParam);
	}

	/**
	 * 사업장 주소(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.addrMgmtScoUpjangMstDAO.update", mapParam);
	}
	
	
}
