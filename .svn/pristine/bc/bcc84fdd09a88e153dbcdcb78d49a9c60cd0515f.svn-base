package com.hwfs.fs.fsm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 기기/기물관리하는 MachineMstReg DAO
 * 
 * @ClassName MachineMstRegDAO.java
 * @Description MachineMstRegDAO Class
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
@Repository("/fs/fsm/machineMstRegDAO")
public class MachineMstRegDAO extends DefaultDAO {
	/**
	 * 마스터등록 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectComboLclass(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsm.machineMstRegDAO.selectComboLclass", mapParam);
	}
	public RecordSet selectComboMclass(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsm.machineMstRegDAO.selectComboMclass", mapParam);
	}
	public RecordSet selectComboSclass(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsm.machineMstRegDAO.selectComboSclass", mapParam);
	}
	public RecordSet selectCodeUse(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsm.machineMstRegDAO.selectCodeUse", mapParam);
	}
	public RecordSet selectMachineMst(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsm.machineMstRegDAO.selectMachineMst", mapParam);
	}
	public int selectMachineMstCnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("fs.fsm.machineMstRegDAO.selectMachineMstCnt", mapParam);
	}
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsm.machineMstRegDAO.selectList", mapParam);
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
		return super.update("fs.fsm.machineMstRegDAO.insertMachineMstMclass", mapParam);
	}
	//소코드
	public int insertMachineMstSclass(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsm.machineMstRegDAO.insertMachineMstSclass", mapParam);
	}
	
	/**기기/기물 목록을 수정한다.*/
	//중코드
	public int updateMachineMstMclass(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsm.machineMstRegDAO.updateMachineMstMclass", mapParam);
	}
	//소코드
	public int updateMachineMstSclass(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsm.machineMstRegDAO.updateMachineMstSclass", mapParam);
	}
	
	/**기기/기물 목록을 삭제한다.*/
	//중코드
	public int deleteMachineMstMclass(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsm.machineMstRegDAO.deleteMachineMstMclass", mapParam);
	}
	//소코드
	public int deleteMachineMstSclass(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsm.machineMstRegDAO.deleteMachineMstSclass", mapParam);
	}
	
	/**
	 * 기기/기물 등록을 등록,수정,삭제
	 *
	 * @param mapParam
	 * @return
	 */
	
	/**기기/기물 등록을 등록한다.*/
	public int insertGrd(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsm.machineMstRegDAO.insertGrd", mapParam);
	}
	
	/**기기/기물 등록을 수정한다.*/
	public int updateGrd(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsm.machineMstRegDAO.updateGrd", mapParam);
	}
	
	/**기기/기물 등록을 삭제한다.*/
	public int deleteGrd(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsm.machineMstRegDAO.deleteGrd", mapParam);
	}
}
