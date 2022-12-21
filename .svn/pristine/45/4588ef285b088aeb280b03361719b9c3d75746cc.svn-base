package com.hwfs.ei.isa.service;

import org.json.JSONObject;

 /**
 * 특판상품을 정산하는 FsspExact Service Interface
 * 
 * @ClassName FsspExactService.java
 * @Description FsspExactService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.12.07    김재섭        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 특판담당 김재섭
 * @since 2015.12.07
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface FsspExactService {

	/**
	 * 정산내역을 조회한다.
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 */
	JSONObject selectExact(JSONObject header, JSONObject data, JSONObject result) throws Exception;

	/**
	 * 주문내역을 조회한다.
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 */
	JSONObject selectOrder(JSONObject header, JSONObject data, JSONObject result) throws Exception;
	
	/**
	 * 승인상세 내역을 조회한다. 
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 */
	JSONObject selectVanDtl(JSONObject header, JSONObject data, JSONObject result) throws Exception;
	
	/**
	 * 결제건별 주문내역.
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 */
	JSONObject selectSaleVan(JSONObject header, JSONObject data, JSONObject result) throws Exception;
	
	/**
	 * 주문내역을 삭제한다.
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 */
	JSONObject saveOrderCancel(JSONObject header, JSONObject data, JSONObject result) throws Exception;
	
	/**
	 * 주문내역을 변경한다.
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 */
	JSONObject saveOrderChange(JSONObject header, JSONObject data, JSONObject result) throws Exception;
	
	/**
	 * 승인내역을 처리한다.
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 */
	JSONObject saveVanData(JSONObject header, JSONObject data, JSONObject result) throws Exception;
	
	/**
	 * VAN KEY가 설정된 경우, 결제 대상 제외를 수행한다.
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 */
	JSONObject saveClearOrder(JSONObject header, JSONObject data, JSONObject result) throws Exception;
	
	/**
	 * 정산처리
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 */
	JSONObject saveExact(JSONObject header, JSONObject data, JSONObject result) throws Exception;
}
