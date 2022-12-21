package com.hwfs.ms.mef.dao;

import java.util.Map;

import hone.core.util.record.RecordSet;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;
import com.hwfs.guide.sample.dto.SampleSearchDTO;
import com.hwfs.ms.mef.dto.FileUploadEfoodistDTO;

 /**
 * E-FOODIST등록관리(파일첨부)하는 FileUploadEfoodist DAO
 * 
 * @ClassName FileUploadEfoodistDAO.java
 * @Description FileUploadEfoodistDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.17   	강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : E-FOODIST(런타임,모바일) 강대성
 * @since 2015.03.17
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ms/mef/fileUploadEfoodistDAO")
public class FileUploadEfoodistDAO extends DefaultDAO {
	
	/**
	 * E-FOODIST등록관리(파일첨부) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("ms.mef.fileUploadEfoodistDAO.selectList", parameter);
	}
	
	/**
	 * E-FOODIST등록관리(파일첨부) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDetailList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("ms.mef.fileUploadEfoodistDAO.selectDetailList", parameter);
	}
	
	/**
	 * E-FOODIST등록관리(파일첨부) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPopList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("ms.mef.fileUploadEfoodistDAO.selectPopList", parameter);
	}

	/**
	 * E-FOODIST등록관리(파일첨부)(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> parameter) throws Exception {
		return super.update("ms.mef.fileUploadEfoodistDAO.insert", parameter);
	}
	
	/**
	 * E-FOODIST등록관리(파일첨부)(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> parameter) throws Exception {
		return super.update("ms.mef.fileUploadEfoodistDAO.update", parameter);
	}
	
	/**
	 * E-FOODIST등록관리(파일첨부)(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> parameter) throws Exception {
		return super.update("ms.mef.fileUploadEfoodistDAO.delete", parameter);
	}
	
	/**
	 * E-FOODIST등록여부를 확인한다(중복건 체크)
	 *
	 * @param mapParam
	 * @return
	 */
	public int saveChk(Map<String, Object> parameter) throws Exception {
		return queryForInt ("ms.mef.fileUploadEfoodistDAO.saveChk", parameter);
	}
}
