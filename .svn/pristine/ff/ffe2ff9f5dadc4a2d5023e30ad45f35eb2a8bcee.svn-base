package com.hwfs.rc.rrm.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rrm.dao.RecipeInquirybyItemDAO;

 /**
 * 업장 레시피를 조회(by Item)하는 RecipeInquirybyItem Service Implementation
 * 
 * @ClassName RecipeInquirybyItemServiceImpl.java
 * @Description RecipeInquirybyItemServiceImpl Class
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
@Service("/rc/rrm/recipeInquirybyItemService")
public class RecipeInquirybyItemServiceImpl extends DefaultServiceImpl implements RecipeInquirybyItemService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** RecipeInquirybyItemDAO Bean 생성 */
	@Resource(name = "/rc/rrm/recipeInquirybyItemDAO")
	private RecipeInquirybyItemDAO recipeInquirybyItemDAO;
	

	/**
	 * 업장 레시피 조회(by Item) 목록을 조회한다.
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
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception
	{
		RecordSet rs = recipeInquirybyItemDAO.selectCenterCode(mapParam);
		Record record = rs.get(0);

		String centerCode = (String) record.get("centerCode");

		if( centerCode.equals("") )
		{
			mapParam.put("centerCode", "300001");
		}
		else
		{
			mapParam.put("centerCode", centerCode);
		}
		
		return recipeInquirybyItemDAO.selectList(mapParam);
	}

}
