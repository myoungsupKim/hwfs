package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 관련서류 및 첨부파일을 관리하는 PaperMgmt DAO
 * 
 * @ClassName PaperMgmtDAO.java
 * @Description PaperMgmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.05   	최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.03.05
 * @version 1.0
 * @see  
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/paperMgmtDAO")
public class PaperMgmtDAO extends DefaultDAO {
	
	/**
	 * 서류관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.paperMgmtDAO.selectList", mapParam);
	}
	public RecordSet selectMigList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.paperMgmtDAO.selectMigList", mapParam);
	}
	public RecordSet selectPath(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.paperMgmtDAO.selectPath", mapParam);
	}

	/**
	 * 문서정보를 조회한다.(1 ROW)
	 * <pre>
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectDoc(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.paperMgmtDAO.selectDoc", mapParam);
	}
	
	/**
	 * 문서정보를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertDoc(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.paperMgmtDAO.insertDoc", mapParam);
	}
	
	/**
	 * 문서정보를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateDoc(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.paperMgmtDAO.updateDoc", mapParam);
	}
	
	/**
	 * 문서정보를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteDoc(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.paperMgmtDAO.deleteDoc", mapParam);
	}
	
	
	/**
	 * 문서정보를 수정한다. : 자료이관
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateMig(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.paperMgmtDAO.updateMig", mapParam);
	}
	
}
