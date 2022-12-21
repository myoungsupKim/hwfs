package com.hwfs.fs.fsa.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 채용만족도조사(FS지원팀)하는 AdoptionFsAppraisal DAO
 * 
 * @ClassName AdoptionFsAppraisalDAO.java
 * @Description AdoptionFsAppraisalDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.13   	김예진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.04.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsa/adoptionFsAppraisalDAO")
public class AdoptionFsAppraisalDAO extends DefaultDAO {
	
	/**
	 * 채용만족도조사 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectReqList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsa.adoptionFsAppraisalDAO.selectReqList", mapParam);
	}
	public RecordSet selectAppraisalList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsa.adoptionFsAppraisalDAO.selectAppraisalList", mapParam);
	}

}
