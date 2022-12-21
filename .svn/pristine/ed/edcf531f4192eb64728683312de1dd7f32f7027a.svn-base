package com.hwfs.rc.rrm.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rrm.dao.StandardRecipeInquirybyItemDAO;

 /**
 * 표준 레시피를 조회(By Item)하는 StandardRecipeInquirybyItem Service Implementation
 * 
 * @ClassName StandardRecipeInquirybyItemServiceImpl.java
 * @Description StandardRecipeInquirybyItemServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.17    Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.04.17
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rrm/standardRecipeInquirybyItemService")
public class StandardRecipeInquirybyItemServiceImpl extends DefaultServiceImpl implements StandardRecipeInquirybyItemService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** StandardRecipeInquirybyItemDAO Bean 생성 */
	@Resource(name = "/rc/rrm/standardRecipeInquirybyItemDAO")
	private StandardRecipeInquirybyItemDAO standardRecipeInquirybyItemDAO;
	

	/**
	 * 표준 레시피 조회(By Item) 목록을 조회한다.
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
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return standardRecipeInquirybyItemDAO.selectList(mapParam);
	}

}
