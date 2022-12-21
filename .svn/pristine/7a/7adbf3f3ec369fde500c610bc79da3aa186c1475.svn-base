package com.hwfs.fs.fsl.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsl.dao.PublishYnPopupDAO;

 /**
 * 세금계산서 PublishYnPopup Service Implementation
 * 
 * @ClassName PublishYnPopupServiceImpl.java
 * @Description PublishYnPopupServiceImpl Class
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
@Service("/fs/fsl/publishYnPopupService")
public class PublishYnPopupServiceImpl extends DefaultServiceImpl implements PublishYnPopupService {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** PublishYnPopupDAO Bean 생성 */
	@Resource(name = "/fs/fsl/publishYnPopupDAO")
	private PublishYnPopupDAO publishYnPopupDAO;
	

	/**
	 * 세금계산서 목록을 조회한다.
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
	public RecordSet selectPublishYnList(Map<String, Object> mapParam) throws Exception {
		return publishYnPopupDAO.selectPublishYnList(mapParam);
	}

}
