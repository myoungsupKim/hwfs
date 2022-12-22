package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import java.util.List;
import java.util.Map;

import com.hwfs.sc.cmn.dto.LmsMmsDTO;

 /**
 * LMS/MMS를 전송하는 LmsMmsSend Service Interface
 * 
 * @ClassName LmsMmsSendService.java
 * @Description LmsMmsSendService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.09    kksoo        최초생성
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
public interface LmsMmsSendService {

	/**
	 * LMS/MMS 전송 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectListLmsMms(Map<String, Object> mapParam) throws Exception;

	/**
	 * LMS/MMS 전송 데이터를 LMS/MMS전송 IF 테이블에 Insert 처리한다.
	 * <pre>
	 * - Transaction이 호출한 업무와 같은 트랜잭션 내에서 처리된다.
	 * </pre>
	 *
	 * @param list
	 *            List<LmsMmsDTO>
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveLmsMms(List<LmsMmsDTO> list) throws Exception;

	/**
	 * LMS/MMS 전송 데이터를 LMS/MMS전송 IF 테이블에 Insert 처리한다.
	 * <pre>
	 * - Transaction이 호출한 업무와 같은 트랜잭션 내에서 처리된다.
	 * </pre>
	 *
	 * @param lmsMmsDTO
	 *            LmsMmsDTO
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveLmsMms(LmsMmsDTO lmsMmsDTO) throws Exception;

	/**
	 * LMS/MMS 전송 데이터를 LMS/MMS전송 IF 테이블에 Insert 처리한다.
	 * <pre>
	 * - Transaction이 호출한 업무와 다른 새로운 트랜잭션 내에서 처리된다.
	 * - 업무 트랜잭션과 분리되어 처리된다.
	 * </pre>
	 *
	 * @param list
	 *            List<LmsMmsDTO>
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveLmsMmsNewTx(List<LmsMmsDTO> list) throws Exception;

	/**
	 * LMS/MMS 전송 데이터를 LMS/MMS전송 IF 테이블에 Insert 처리한다.
	 * <pre>
	 * - Transaction이 호출한 업무와 다른 새로운 트랜잭션 내에서 처리된다.
	 * - 업무 트랜잭션과 분리되어 처리된다.
	 * - 배치에서도 사용 가능하다.
	 * </pre>
	 *
	 * @param lmsMmsDTO
	 *            LmsMmsDTO
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveLmsMmsNewTx(LmsMmsDTO lmsMmsDTP) throws Exception;

}
