package com.hwfs.ei.isa.service;

import org.json.JSONObject;

 /**
 * IRIS하는 FsspIris Service Interface
 * 
 * @ClassName FsspIrisService.java
 * @Description FsspIrisService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.12.16    김재섭        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : IRIS 김재섭
 * @since 2015.12.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface FsspIrisService {

	/**
	 * 사업장 조회
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 */
	JSONObject selectBrch(JSONObject header, JSONObject data, JSONObject result) throws Exception;

	/**
	 * 영업장 조회
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 */
	JSONObject selectLoc(JSONObject header, JSONObject data, JSONObject result) throws Exception;
	
	JSONObject selectReceiptTitle(JSONObject header, JSONObject data, JSONObject result) throws Exception;
	
	/**
	 * 사업자번호에 해당하는 거래처가 있는지 확인한다.
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 */
	JSONObject selectCustomer(JSONObject header, JSONObject data, JSONObject result) throws Exception;
	
	/**
	 * POS번호 조회
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 */
	JSONObject selectPos(JSONObject header, JSONObject data, JSONObject result) throws Exception;
	
	/**
	 * VAN 정보
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 */
	JSONObject selectVanInfo(JSONObject header, JSONObject data, JSONObject result) throws Exception;
}
