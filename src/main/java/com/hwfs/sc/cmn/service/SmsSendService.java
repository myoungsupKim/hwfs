package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import java.util.List;
import java.util.Map;

import com.hwfs.sc.cmn.dto.SmsDTO;

 /**
 * SMS를 전송하는 SmsSend Service Interface
 * 
 * @ClassName SmsSendService.java
 * @Description SmsSendService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.13    kksoo        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.03.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface SmsSendService {

	/**
	 * SMS 전송 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectListSms(Map<String, Object> mapParam) throws Exception;

	/**
	 * SMS 전송 데이터를 SMS전송 IF 테이블에 Insert 처리한다.
	 * <pre>
	 * - Transaction이 호출한 업무와 같은 트랜잭션 내에서 처리된다.
	 * </pre>
	 *
	 * @param list
	 *            List<SmsDTO>
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveSms(List<SmsDTO> list) throws Exception;

	/**
	 * SMS 전송 데이터를 SMS전송 IF 테이블에 Insert 처리한다.
	 * <pre>
	 * - Transaction이 호출한 업무와 같은 트랜잭션 내에서 처리된다.
	 * </pre>
	 *
	 * @param smsDTO
	 *            SmsDTO
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveSms(SmsDTO smsDTO) throws Exception;

	/**
	 * SMS 전송 데이터를 SMS전송 IF 테이블에 Insert 처리한다.
	 * <pre>
	 * - Transaction이 호출한 업무와 다른 새로운 트랜잭션 내에서 처리된다.
	 * - 업무 트랜잭션과 분리되어 처리된다.
	 * </pre>
	 *
	 * @param list
	 *            List<SmsDTO>
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveSmsNewTx(List<SmsDTO> list) throws Exception;

	/**
	 * SMS 전송 데이터를 SMS전송 IF 테이블에 Insert 처리한다.
	 * <pre>
	 * - Transaction이 호출한 업무와 다른 새로운 트랜잭션 내에서 처리된다.
	 * - 업무 트랜잭션과 분리되어 처리된다.
	 * - 배치에서도 사용 가능하다.
	 * </pre>
	 *
	 * @param smsDTO
	 *            SmsDTO
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveSmsNewTx(SmsDTO smsDTP) throws Exception;

	/**
	 * 배치에서 SMS 전송 데이터를 SMS전송 IF 테이블에 Insert 처리한다.
	 * <pre>
	 * - Transaction이 호출한 업무와 같은 트랜잭션 내에서 처리된다.
	 * - 업무 트랜잭션과 분리되어 처리된다.
	 * - 배치에서도 사용 가능하다.
	 * </pre>
	 *
	 * @param list
	 *            List<SmsDTO>
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveSmsBatch(List<SmsDTO> list) throws Exception;

	/**
	 * 배치에서 SMS 전송 데이터를 SMS전송 IF 테이블에 Insert 처리한다.
	 * <pre>
	 * - Transaction이 호출한 업무와 같은 트랜잭션 내에서 처리된다.
	 * </pre>
	 *
	 * @param smsDTO
	 *            SmsDTO
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveSmsBatch(SmsDTO smsDTO) throws Exception;

}
