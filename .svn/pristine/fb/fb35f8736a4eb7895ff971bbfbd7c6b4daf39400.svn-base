package com.hwfs.sc.cmn.service;

import java.util.Map;

 /**
 * 본인인증을 처리하는 OwnCert Service Interface
 * 
 * @ClassName OwnCertService.java
 * @Description OwnCertService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.27    kksoo        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.04.27
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface OwnCertService {

	/**
	 * 본인인증번호를 요청한다.
	 * <pre>
	 * - 발급된 인증번호는 SMS로 발송한다.
	 * </pre>
	 *
	 * @param mapParam
	 *            요청조건 Map
	 * @return String 
	 *            발급된 인증번호
	 * @throws Exception
	*/
	String requestCernNum(Map<String, Object> mapParam) throws Exception;

	/**
	 * 본인인증번호를 확인한다.
	 * <pre>
	 * - 발급된 번호와 DB에 저장된 번호를 비교하여 확인한다.
	 * </pre>
	 * 
	 * @param mapParam
	 *            확인조건 Map
	 * @return boolean 
	 *            확인결과
	 * @throws Exception
	 */
	boolean confirmCernNum(Map<String, Object> mapParam) throws Exception;

	/**
	 * confirmCernNumCheck 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 */
	String confirmCernNumCheck(Map<String, Object> mapParam)throws Exception;
}
