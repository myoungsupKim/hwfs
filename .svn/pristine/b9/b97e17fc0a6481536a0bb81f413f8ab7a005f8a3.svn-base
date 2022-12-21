package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dao.FaxDAO;
import com.hwfs.sc.cmn.dto.FaxDTO;

 /**
 * Fax 전송 Service Implementation
 * @ClassName FaxServiceImpl.java
 * @Description FaxServiceImpl Class 
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
@Service("/sc/cmn/faxService")
public class FaxServiceImpl extends DefaultServiceImpl implements FaxService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** FaxDAO */
    @Resource(name="/sc/cmn/faxDAO")
    private FaxDAO faxDAO;

	/**
	 * Fax 전송내을 조회한다.
	 *
	 * @param parameter
	 * @return
	*/
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return faxDAO.selectList(parameter);
	}

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
	public int send (FaxDTO faxDTO) throws Exception {
		logger.debug("FAX 전송요청 : {}", faxDTO.toString());
		return faxDAO.insert(faxDTO);
	}
	
}
