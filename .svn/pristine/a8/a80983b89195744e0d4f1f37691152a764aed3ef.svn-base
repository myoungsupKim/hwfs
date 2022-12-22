package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dao.EmailSendDAO;
import com.hwfs.sc.cmn.dto.EmailDTO;

 /**
 * Email을 전송하는 EmailSend Service Implementation
 * 
 * @ClassName EmailSendServiceImpl.java
 * @Description EmailSendServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.13    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.03.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/emailSendService")
public class EmailSendServiceImpl extends DefaultServiceImpl implements EmailSendService {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** EmailSendDAO Bean 생성 */
	@Resource(name = "/sc/cmn/emailSendDAO")
	private EmailSendDAO emailSendDAO;
	

	/**
	 * EMAIL 전송 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectListEmail(Map<String, Object> mapParam) throws Exception {
		return emailSendDAO.selectListEmail(mapParam);
	}

	/**
	 * EMAIL 전송 데이터를 EMAIL전송 IF 테이블에 Insert 처리한다.
	 * <pre>
	 * - Transaction이 호출한 업무와 같은 트랜잭션 내에서 처리된다.
	 * </pre>
	 *
	 * @param list
	 *            List<EmailDTO>
	 * @return 처리건수
	 * @throws Exception
	*/
	public int saveEmail(List<EmailDTO> list) throws Exception {
		return emailSendDAO.insertEmail(list);
	}

	/**
	 * EMAIL 전송 데이터를 EMAIL전송 IF 테이블에 Insert 처리한다.
	 * <pre>
	 * - Transaction이 호출한 업무와 같은 트랜잭션 내에서 처리된다.
	 * </pre>
	 *
	 * @param emailDTO
	 *            EmailDTO
	 * @return 처리건수
	 * @throws Exception
	*/
	public int saveEmail(EmailDTO emailDTO) throws Exception {
		return emailSendDAO.insertEmail(emailDTO);
	}

	/**
	 * EMAIL 전송 데이터를 EMAIL전송 IF 테이블에 Insert 처리한다.
	 * <pre>
	 * - Transaction이 호출한 업무와 다른 새로운 트랜잭션 내에서 처리된다.
	 * - 업무 트랜잭션과 분리되어 처리된다.
	 * </pre>
	 *
	 * @param list
	 *            List<EmailDTO>
	 * @return 처리건수
	 * @throws Exception
	*/
	public int saveEmailNewTx(List<EmailDTO> list) throws Exception {
		return emailSendDAO.insertEmail(list);
	}

	/**
	 * EMAIL 전송 데이터를 EMAIL전송 IF 테이블에 Insert 처리한다.
	 * <pre>
	 * - Transaction이 호출한 업무와 다른 새로운 트랜잭션 내에서 처리된다.
	 * - 업무 트랜잭션과 분리되어 처리된다.
	 * </pre>
	 *
	 * @param list
	 *            List<EmailDTO>
	 * @return 처리건수
	 * @throws Exception
	*/
	public int saveEmailNewTx(EmailDTO emailDTO) throws Exception {
		return emailSendDAO.insertEmail(emailDTO);
	}
}
