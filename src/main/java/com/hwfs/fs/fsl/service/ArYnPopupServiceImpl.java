package com.hwfs.fs.fsl.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsl.dao.ArYnPopupDAO;

 /**
 *  ArYnPopup Service Implementation
 * 
 * @ClassName ArYnPopupServiceImpl.java
 * @Description ArYnPopupServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.30    이지운        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 이지운
 * @since 2015.07.30
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsl/arYnPopupService")
public class ArYnPopupServiceImpl extends DefaultServiceImpl implements ArYnPopupService {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** ArYnPopupDAO Bean 생성 */
	@Resource(name = "/fs/fsl/arYnPopupDAO")
	private ArYnPopupDAO arYnPopupDAO;
	

	/**
	 * 채권대체 목록을 조회한다.
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
	public RecordSet selectArYnList(Map<String, Object> mapParam) throws Exception {
		return arYnPopupDAO.selectArYnList(mapParam);
	}

}
