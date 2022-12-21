package com.hwfs.sc.scz.service;

import java.util.List;
import java.util.Map;

 /**
 * 고정자산명세서를 조회하는 FixedAssetsList Service Interface
 * 
 * @ClassName FixedAssetsListService.java
 * @Description FixedAssetsListService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.11.11    김재섭        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.11.11
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface FixedAssetsListService {

	/**
	 * 고정자산명세서 목록을 조회한다.
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
	List<Map<String, Object>> selectList(Map<String, Object> mapParam) throws Exception;

}
