package com.hwfs.fs.fsa.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsa.dao.AdoptionFsAppraisalDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * 채용만족도조사(FS지원팀)하는 AdoptionFsAppraisal Service Implementation
 * 
 * @ClassName AdoptionFsAppraisalServiceImpl.java
 * @Description AdoptionFsAppraisalServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.13    김예진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.04.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsa/adoptionFsAppraisalService")
public class AdoptionFsAppraisalServiceImpl extends DefaultServiceImpl implements AdoptionFsAppraisalService {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** AdoptionFsAppraisalDAO Bean 생성 */
	@Resource(name = "/fs/fsa/adoptionFsAppraisalDAO")
	private AdoptionFsAppraisalDAO adoptionFsAppraisalDAO;
	

	/**
	 * 채용만족도조사 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectReqList(Map<String, Object> mapParam) throws Exception {
		return adoptionFsAppraisalDAO.selectReqList(mapParam);
	}
	public RecordSet selectAppraisalList(Map<String, Object> mapParam) throws Exception {
		return adoptionFsAppraisalDAO.selectAppraisalList(mapParam);
	}
}
