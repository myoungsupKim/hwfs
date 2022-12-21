package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import com.hwfs.sc.cmn.dto.FaxDTO;

 /**
 * Fax 송신 Service Interface
 * @ClassName FaxService.java
 * @Description FaxService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 2. 3.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 2. 3.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface FaxService {
	
	/**
	 * Fax 전송내을 조회한다.
	 *
	 * @param parameter
	 * @return
	*/
	public RecordSet selectList(Map<String, Object> parameter) throws Exception;

	/**
	 * Fax를 전송한다.
	 * <pre>
	 * - FaxAgent IF Table에 insert 처리하면 FaxAgent가 자동으로 발송
	 * - 실제 전송 여부는 전송내역으로 조회하여 확인
	 * </pre>
	 *
	 * @param faxDTO
	 * @return 전송건수
	 * @throws Exception
	 * @see com.hwfs.sc.cmn.service.FaxService#sendFax(com.hwfs.sc.cmn.dto.FaxDTO)
	 */
	public int send (FaxDTO faxDTO) throws Exception;
}
