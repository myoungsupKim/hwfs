package com.hwfs.ei.isa.service;

import org.json.JSONObject;

 /**
 * 특판상품관리하는 FsspGoods Service Interface
 * 
 * @ClassName FsspGoodsService.java
 * @Description FsspGoodsService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.12.17    김재섭        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 특판 김재섭
 * @since 2015.12.17
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface FsspGoodsService {

	/**
	 * 특판상품 목록을 조회한다.
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 */
	JSONObject selectGoods(JSONObject header, JSONObject data, JSONObject result) throws Exception;
	
	/**
	 * 상품 생성/수정
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 */
	JSONObject saveGoods(JSONObject header, JSONObject data, JSONObject result) throws Exception;
}
