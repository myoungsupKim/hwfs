package com.hwfs.sc.cmn.sap;

import org.json.JSONObject;

/**
 * EAIRequest에 대한 설명 작성
 *
 * @ClassName EAIRequest.java
 * @Description EAIRequest Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 10.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 4. 10.
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface EAIRequest {

	/**
	 * EAI에서 할당 받은 인터페이스 ID
	 *
	 * @return
	 */
	String getInterfaceId();

	/**
	 * setter로 통해 할당 받은 값을 EAI와 통신에 맞는 형태의 JSONObject로 반환한다.
	 *
	 * @param systemCode
	 *            : EAI에서 할당 받은 시스템 코드
	 * @return
	 * @throws Exception
	 */
	JSONObject getJSONObject(String systemCode) throws Exception;
}
