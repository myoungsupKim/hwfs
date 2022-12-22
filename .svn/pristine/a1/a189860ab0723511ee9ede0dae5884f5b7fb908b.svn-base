package com.hwfs.ei.cmn.service;

import org.json.JSONObject;

 /**
 * 통합회계에서 공통으로 호출하는 FsspCommon Service Interface
 * 
 * @ClassName FsspCommonService.java
 * @Description FsspCommonService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.11.23    김재섭        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 김재섭
 * @since 2015.11.23
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface FsspCommonService {

	/**
	 * 특판 시즌정보를 조회한다.
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 */
	JSONObject selectSeason(JSONObject header, JSONObject data, JSONObject result) throws Exception;

	/**
	 * 공통코드를 조회한다.
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 */
	JSONObject selectCommonCode(JSONObject header, JSONObject data, JSONObject result) throws Exception;
	
	/**
	 * PO Code를 조회한다.
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 */
	JSONObject selectPoCode(JSONObject header, JSONObject data, JSONObject result) throws Exception;
	
	/**
	 * 부문(BU)를 조회한다.
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 */
	JSONObject selectBu(JSONObject header, JSONObject data, JSONObject result) throws Exception;
	
	/**
	 * 사업장 상품 생성여부
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 */
	JSONObject selectCreateBrchItem(JSONObject header, JSONObject data, JSONObject result) throws Exception;
	
	/**
	 * 영업장 상품 생성여부
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 */
	JSONObject selectCreateLocItem(JSONObject header, JSONObject data, JSONObject result) throws Exception;
}
