package com.hwfs.fs.fsm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 업장 배정 관리하는 MachineRequestAllcRtn DAO
 * 
 * @ClassName MachineRequestAllcRtnDAO.java
 * @Description MachineRequestAllcRtnDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.17   	김예진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.03.17
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsm/machineRequestAllcRtnDAO")
public class MachineRequestAllcRtnDAO extends DefaultDAO {
	
	/**
	 * 기기/기물 신청 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectReqRtnList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsm.machineRequestAllcRtnDAO.selectReqRtnList", mapParam);
	}
	
	/**
	 * 기기/기물 신청 목록을 조회한다.(이벤트 신청 포함)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectReqRtnList2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsm.machineRequestAllcRtnDAO.selectReqRtnList2", mapParam);
	}
	
	/**
	 * 기기/기물 신청 목록을 조회한다.(달력 사용)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectReqRtnList3(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsm.machineRequestAllcRtnDAO.selectReqRtnList", mapParam);
	}

	/**
	 * 기기/기물 신청 목록(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsm.machineRequestAllcRtnDAO.insertReqRtnList", mapParam);
	}
	
	/**
	 * 기기/기물 신청 목록(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsm.machineRequestAllcRtnDAO.updateReqRtnList", mapParam);
	}
	
	/**
	 * 기기/기물 신청 목록(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsm.machineRequestAllcRtnDAO.deleteReqRtnList", mapParam);
	}
	
}
