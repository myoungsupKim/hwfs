package com.hwfs.sc.scc.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

 /**
 * 모바일로 메시지를 전송하는 MobileMsgSend Service Interface
 * 
 * @ClassName MobileMsgSendService.java
 * @Description MobileMsgSendService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.16    kksoo        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.06.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface MobileMsgSendService {

	/**
	 * 모바일 메시지 전송 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 모바일 메시지 전송을 처리한다.
	 *
	 * @param jsonMsg
	 *            json형식의 메시지
	 * @param strCc
	 *            내부사용자 부서 목록으로 ,로 구분
	 * @param strUpjang
	 *            외부사용자 업장 목록으로 ,로 구분
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList(String jsonMsg, String strCc, String strUpjang) throws Exception;
}
