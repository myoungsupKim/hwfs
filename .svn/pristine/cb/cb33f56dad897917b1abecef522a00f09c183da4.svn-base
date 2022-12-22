package com.hwfs.ei.isa.service;

import org.json.JSONObject;

 /**
 * 통합회계에서 특판상품을 주문 처리하는 FsspOrder Service Interface
 * 
 * @ClassName FsspOrderService.java
 * @Description FsspOrderService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.11.23    김재섭        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 정보기획팀 김재섭
 * @since 2015.11.23
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface FsspOrderService {

	/**
	 * 특판상품 주문 목록을 조회한다.
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
	JSONObject selectGoodsList(JSONObject header, JSONObject data, JSONObject result) throws Exception;
	
	/**
	 * 상품주문내역을 조회한다.
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 */
	JSONObject selectGoodsOrderList(JSONObject header, JSONObject data, JSONObject result) throws Exception;

	/**
	 * 주문내역을 처리한다.
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 */
	JSONObject saveOrder(JSONObject header, JSONObject data, JSONObject result) throws Exception;
	
	/**
	 * 특정시즌 상품에 대하여 주문가능을 체크한다.
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 */
	JSONObject selectValidation(JSONObject header, JSONObject data, JSONObject result) throws Exception;
}
