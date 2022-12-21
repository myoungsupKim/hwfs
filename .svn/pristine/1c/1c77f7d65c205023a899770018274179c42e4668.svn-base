package com.hwfs.sc.cmn.sap.service;

import java.util.List;

import com.hwfs.sc.cmn.sap.EAIList;
import com.hwfs.sc.cmn.sap.EAIListMap;
import com.hwfs.sc.cmn.sap.EAIRequest;
import com.hwfs.sc.cmn.sap.EAIResponse;
import com.hwfs.sc.cmn.sap.EAITable;

/**
 * EAIService에 대한 설명 작성
 *
 * @ClassName EAIService.java
 * @Description EAIService Class
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
public interface EAIService {
	/**
	 * EAI 서버를 실시간으로 수행한다.(단건자료)
	 *
	 * @param eaiRequest
	 * @return
	 * @throws Exception
	 */
	EAIResponse call(EAIRequest eaiRequest) throws Exception;

	/**
	 * EAI 서버를 실시간으로 수행한다.(다건자료)
	 *
	 * @param eaiRequest
	 * @return
	 * @throws Exception
	 */
	EAIResponse call(List<EAIRequest> eaiRequests) throws Exception;

	/**
	 * EAI 서버와 통신하기 위한 TABLE에 자료를 생성한다.(단건)
	 *
	 * @param eaiTable
	 * @return
	 * @throws Exception
	 */
	EAIResponse call(EAITable eaiTable) throws Exception;

	/**
	 * EAI 서버와 통신하기 위한 TABLE에 자료를 생성한다.(다건)
	 *
	 * @param eaiList
	 * @return
	 * @throws Exception
	 */
	EAIResponse call(EAIList eaiList) throws Exception;

	/**
	 * EAI 서버와 통신하기 위한 TABLE에 자료를 생성한다.(다건-마스터/디테일 구조)
	 *
	 * @param listMap
	 * @return
	 * @throws Exception
	 */
	EAIResponse call(EAIListMap listMap) throws Exception;

	/**
	 * EAI 서버를 실시간으로 수행한다.(단건자료)(별도 Transaction으로 처리)
	 *
	 * @param eaiRequest
	 * @return
	 * @throws Exception
	 */
	EAIResponse callNewTx(EAIRequest eaiRequest) throws Exception;

	/**
	 * EAI 서버를 실시간으로 수행한다.(다건자료)(별도 Transaction으로 처리)
	 *
	 * @param eaiRequest
	 * @return
	 * @throws Exception
	 */
	EAIResponse callNewTx(List<EAIRequest> eaiRequests) throws Exception;

	/**
	 * EAI 서버와 통신하기 위한 TABLE에 자료를 생성한다.(단건)(별도 Transaction으로 처리)
	 *
	 * @param eaiTable
	 * @return
	 * @throws Exception
	 */
	EAIResponse callNewTx(EAITable eaiTable) throws Exception;

	/**
	 * EAI 서버와 통신하기 위한 TABLE에 자료를 생성한다.(다건)(별도 Transaction으로 처리)
	 *
	 * @param eaiList
	 * @return
	 * @throws Exception
	 */
	EAIResponse callNewTx(EAIList eaiList) throws Exception;

	/**
	 * EAI 서버와 통신하기 위한 TABLE에 자료를 생성한다.(다건-마스터/디테일 구조)(별도 Transaction으로 처리)
	 *
	 * @param listMap
	 * @return
	 * @throws Exception
	 */
	EAIResponse callNewTx(EAIListMap listMap) throws Exception;
}
