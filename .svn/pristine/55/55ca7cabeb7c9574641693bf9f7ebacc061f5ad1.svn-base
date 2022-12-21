package com.hwfs.fs.fse.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 기기/기물관리하는 EventInfoMaster DAO
 * 
 * @ClassName EventInfoMasterDAO.java
 * @Description EventInfoMasterDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.05   	김예진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.03.05
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fse/eventInfoMasterDAO")
public class EventInfoMasterDAO extends DefaultDAO {

	/**
	 * 마감현황 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectListCal(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fse.eventInfoMasterDAO.selectListCal", mapParam);
	}
	/**
	 * 마스터등록 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectComboLclass(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fse.eventInfoMasterDAO.selectComboLclass", mapParam);
	}
	public RecordSet selectComboMclass(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fse.eventInfoMasterDAO.selectComboMclass", mapParam);
	}
	public RecordSet selectComboSclass(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fse.eventInfoMasterDAO.selectComboSclass", mapParam);
	}
	public RecordSet selectCodeUse(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fse.eventInfoMasterDAO.selectCodeUse", mapParam);
	}
	public RecordSet selectMachineMst(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fse.eventInfoMasterDAO.selectMachineMst", mapParam);
	}
	public int selectMachineMstCnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("fs.fse.eventInfoMasterDAO.selectMachineMstCnt", mapParam);
	}
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fse.eventInfoMasterDAO.selectList", mapParam);
	}

	
	
	/**
	 * 기기/기물 목록 등록,수정,삭제
	 *
	 * @param mapParam
	 * @return
	 */
	
	/**기기/기물 목록을 등록한다.*/
	//중코드
	public int insertMachineMstMclass(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fse.eventInfoMasterDAO.insertMachineMstMclass", mapParam);
	}
	//소코드
	public int insertMachineMstSclass(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fse.eventInfoMasterDAO.insertMachineMstSclass", mapParam);
	}
	
	/**기기/기물 목록을 수정한다.*/
	//중코드
	public int updateMachineMstMclass(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fse.eventInfoMasterDAO.updateMachineMstMclass", mapParam);
	}
	//소코드
	public int updateMachineMstSclass(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fse.eventInfoMasterDAO.updateMachineMstSclass", mapParam);
	}
	
	/**기기/기물 목록을 삭제한다.*/
	//중코드
	public int deleteMachineMstMclass(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fse.eventInfoMasterDAO.deleteMachineMstMclass", mapParam);
	}
	//소코드
	public int deleteMachineMstSclass(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fse.eventInfoMasterDAO.deleteMachineMstSclass", mapParam);
	}
	
	/**
	 * 기기/기물 등록을 등록,수정,삭제
	 *
	 * @param mapParam
	 * @return
	 */
	
	/**기기/기물 등록을 등록한다.*/
	public int insertGrd(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fse.eventInfoMasterDAO.insertGrd", mapParam);
	}
	
	/**기기/기물 등록을 수정한다.*/
	public int updateGrd(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fse.eventInfoMasterDAO.updateGrd", mapParam);
	}
	
	/**기기/기물 등록을 삭제한다.*/
	public int deleteGrd(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fse.eventInfoMasterDAO.deleteGrd", mapParam);
	}
}
