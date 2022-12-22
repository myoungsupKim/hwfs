package com.hwfs.sc.cmn.dao;

import java.util.Map;

import hone.core.util.record.RecordSet;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * FC POS 마스터 외부 인터페이스용  DAO 개체
 * @ClassName ExternalVanApprvIFDAO.java
 * @Description ExternalVanApprvIFDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2019.01.18.   김명섭        최초생성
 * </pre>
 * @author FC정보기획팀
 * @since 2019.01.18.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/externalPosMasterIFDAO")
public class ExternalPosMasterIFDAO extends DefaultDAO {
	
	/**
	 * 영업장 마스터를 조회한다.
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectOutletMst(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.cmn.externalPosMasterIFDAO.selectOutletMst", parameter);
	}

	/**
	 * 식음좌석 코드를 조회한다.
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectFnbTableCd(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.cmn.externalPosMasterIFDAO.selectFnbTableCd", parameter);
	}
	
	/**
	 * 영업장 메뉴 코드를 조회한다.
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectOutletMenu(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.cmn.externalPosMasterIFDAO.selectOutletMenu", parameter);
	}

	public RecordSet selectSmsResult(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.cmn.externalPosMasterIFDAO.selectSmsResult", parameter);
	}

	/**
	 * 로그정보를 입력한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int logInsert(Map<String, Object> parameter) throws Exception {
		return super.update("sc.cmn.externalPosMasterIFDAO.logInsert", parameter);
	}
	
}
