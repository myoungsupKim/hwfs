package com.hwfs.fs.fsa.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsa.dao.AdoptionSitePopDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * 채용관리사이트팝업하는 AdoptionSitePop Service Implementation
 * 
 * @ClassName AdoptionSitePopServiceImpl.java
 * @Description AdoptionSitePopServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.26    yanghj        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 yanghj
 * @since 2015.03.26
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsa/adoptionSitePopService")
public class AdoptionSitePopServiceImpl extends DefaultServiceImpl implements AdoptionSitePopService {

	/** AdoptionSitePopDAO Bean 생성 */
	@Resource(name = "/fs/fsa/adoptionSitePopDAO")
	private AdoptionSitePopDAO adoptionSitePopDAO;
	

	/**
	 * 채용관리사이트팝업 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return adoptionSitePopDAO.selectList(mapParam);
	}

}
