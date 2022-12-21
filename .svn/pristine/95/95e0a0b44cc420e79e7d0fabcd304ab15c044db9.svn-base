package com.hwfs.fs.fsm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 기기/기물 as/폐기 관리하는 MachineAshisDisuse DAO
 * 
 * @ClassName MachineAshisDisuseDAO.java
 * @Description MachineAshisDisuseDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.13   	김예진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.03.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsm/machineAshisDisuseDAO")
public class MachineAshisDisuseDAO extends DefaultDAO {
	
	/**
	 * 기기/기물 as/폐기 관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectComboMgrp() throws Exception {
		return super.queryForRecordSet("fs.fsm.machineAshisDisuseDAO.selectComboMgrp", "");
	}
	public RecordSet selectComboMclass(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsm.machineAshisDisuseDAO.selectComboMclass", mapParam);
	}
	public RecordSet selectComboSclass(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsm.machineAshisDisuseDAO.selectComboSclass", mapParam);
	}
	public RecordSet selectAsList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsm.machineAshisDisuseDAO.selectAsList", mapParam);
	}
	public RecordSet selectDisuseList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsm.machineAshisDisuseDAO.selectDisuseList", mapParam);
	}

	/**
	 * 기기/기물 as 관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertAs(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsm.machineAshisDisuseDAO.insertAs", mapParam);
	}
	
	/**
	 * 기기/기물 as 관리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateAs(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsm.machineAshisDisuseDAO.updateAs", mapParam);
	}
	
	/**
	 * 기기/기물 as 관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteAs(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsm.machineAshisDisuseDAO.deleteAs", mapParam);
	}

	/**
	 * 기기/기물 폐기 관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertDisuse(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsm.machineAshisDisuseDAO.insertDisuse", mapParam);
	}
	
	/**
	 * 기기/기물 폐기 관리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateDisuse(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsm.machineAshisDisuseDAO.updateDisuse", mapParam);
	}
	
	/**
	 * 기기/기물 폐기 관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteDisuse(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsm.machineAshisDisuseDAO.deleteDisuse", mapParam);
	}
	
}
