package com.hwfs.sc.cmn.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * KICC의 승인처리를하는 KiccApproval DAO
 *
 * @ClassName KiccApprovalDAO.java
 * @Description KiccApprovalDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.21   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.07.21
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/kiccApprovalDAO")
public class KiccApprovalDAO extends DefaultDAO {


	/**
	 * 특정 승인 정보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectCardApproval(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.kiccApprovalDAO.selectCardApproval", mapParam);
	}


	/**
	 * KICC 승인처리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.kiccApprovalDAO.selectList", mapParam);
	}

	/**
	 * KICC 승인처리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.kiccApprovalDAO.insert", mapParam);
	}

	/**
	 * KICC 승인처리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.kiccApprovalDAO.update", mapParam);
	}

	/**
	 * KICC 승인처리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.kiccApprovalDAO.delete", mapParam);
	}

}
