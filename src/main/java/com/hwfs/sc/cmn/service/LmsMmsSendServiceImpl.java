package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dao.LmsMmsSendDAO;
import com.hwfs.sc.cmn.dto.LmsMmsDTO;

 /**
 * LMS/MMS를 전송하는 LmsMmsSend Service Implementation
 * 
 * @ClassName LmsMmsSendServiceImpl.java
 * @Description LmsMmsSendServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.09    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.03.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/lmsMmsSendService")
public class LmsMmsSendServiceImpl extends DefaultServiceImpl implements LmsMmsSendService {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** LmsMmsSendDAO Bean 생성 */
	@Resource(name = "/sc/cmn/lmsMmsSendDAO")
	private LmsMmsSendDAO lmsMmsSendDAO;
	
	/**
	 * LMS/MMS 전송 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectListLmsMms(Map<String, Object> mapParam) throws Exception {
		return lmsMmsSendDAO.selectListLmsMms(mapParam);
	}

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
	public int saveLmsMms(List<LmsMmsDTO> list) throws Exception {
		return lmsMmsSendDAO.insertLmsMms(list);
	}

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
	public int saveLmsMms(LmsMmsDTO lmsMmsDTO) throws Exception {
		return lmsMmsSendDAO.insertLmsMms(lmsMmsDTO);
	}

	/**
	 * LMS/MMS 전송 데이터를 LMS/MMS전송 IF 테이블에 Insert 처리한다.
	 * <pre>
	 * - Transaction이 호출한 업무와 다른 새로운 트랜잭션 내에서 처리된다.
	 * - 업무 트랜잭션과 분리되어 처리된다.
	 * - 배치에서도 사용 가능하다.
	 * </pre>
	 *
	 * @param list
	 *            List<LmsMmsDTO>
	 * @return 처리건수
	 * @throws Exception
	*/
	public int saveLmsMmsNewTx(List<LmsMmsDTO> list) throws Exception {
		return lmsMmsSendDAO.insertLmsMms(list);
	}

	/**
	 * LMS/MMS 전송 데이터를 LMS/MMS전송 IF 테이블에 Insert 처리한다.
	 * <pre>
	 * - Transaction이 호출한 업무와 다른 새로운 트랜잭션 내에서 처리된다.
	 * - 업무 트랜잭션과 분리되어 처리된다.
	 * - 배치에서도 사용 가능하다.
	 * </pre>
	 *
	 * @param list
	 *            List<LmsMmsDTO>
	 * @return 처리건수
	 * @throws Exception
	*/
	public int saveLmsMmsNewTx(LmsMmsDTO lmsMmsDTO) throws Exception {
		return lmsMmsSendDAO.insertLmsMms(lmsMmsDTO);
	}

}
