package com.hwfs.rc.rrm.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

 /**
 * 업장 레시피를 조회(by Recipe)하는 RecipeInquirybyRecipe Service Interface
 * 
 * @ClassName RecipeInquirybyRecipeService.java
 * @Description RecipeInquirybyRecipeService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.17    Y        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 Y
 * @since 2015.04.17
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface RecipeInquirybyRecipeService {

	/**
	 * 업장 레시피 조회(by Recipe) 목록을 조회한다.
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
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;

}
