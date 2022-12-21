package com.hwfs.sc.scc.service;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.scc.dao.MobileMsgSendDAO;

 /**
 * 모바일로 메시지를 전송하는 MobileMsgSend Service Implementation
 * 
 * @ClassName MobileMsgSendServiceImpl.java
 * @Description MobileMsgSendServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.16    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.06.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scc/mobileMsgSendService")
public class MobileMsgSendServiceImpl extends DefaultServiceImpl implements MobileMsgSendService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** MobileMsgSendDAO Bean 생성 */
	@Resource(name = "/sc/scc/mobileMsgSendDAO")
	private MobileMsgSendDAO mobileMsgSendDAO;
	

	/**
	 * 모바일 메시지 전송 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return mobileMsgSendDAO.selectList(mapParam);
	}

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
	public int saveList(String jsonMsg, String strCc, String strUpjang) throws Exception {
		int insRowCnt = 0;
		
		Map<String, Object> mapParam = new HashMap<String, Object>();

		mapParam.put("msg", jsonMsg);
		
		//내부사용자에게 메시지 발송
		if (!strCc.equals("")) {
			mapParam.put("userType", "내부");
			mapParam.put("listCc", strCc);
			
			insRowCnt += mobileMsgSendDAO.insert(mapParam);
			
			logger.info("Mobile Push Msg= {}, CC= {}", jsonMsg, strCc);
		}
		
		//외부사용자에게 메시지 발송
		if (!strUpjang.equals("")) {
			mapParam.put("userType", "외부");
			mapParam.put("listUpjang", strUpjang);
			insRowCnt += mobileMsgSendDAO.insert(mapParam);
	
			logger.info("Mobile Push Msg= {}, Upjang= {}", jsonMsg, strUpjang);
		}

		return insRowCnt;
	}
}
