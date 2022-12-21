package com.hwfs.fs.fsa.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 채용만족도평가하는 AdoptionSiteAppraisal DAO
 * 
 * @ClassName AdoptionSiteAppraisalDAO.java
 * @Description AdoptionSiteAppraisalDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.14   	김예진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.04.14
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsa/adoptionSiteAppraisalDAO")
public class AdoptionSiteAppraisalDAO extends DefaultDAO {
	
	/**
	 * 채용만족도평가 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsa.adoptionSiteAppraisalDAO.selectList", mapParam);
	}

	/**
	 * 채용만족도평가(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsa.adoptionSiteAppraisalDAO.insert", mapParam);
	}
	
	/**
	 * 채용만족도평가(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsa.adoptionSiteAppraisalDAO.update", mapParam);
	}
	
	/**
	 * 채용만족도평가(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsa.adoptionSiteAppraisalDAO.delete", mapParam);
	}
	
	/**
	 * 채용만족도평가(을)를 완료 처리 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateAppraisal(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsa.adoptionSiteAppraisalDAO.updateAppraisal", mapParam);
	}
}
