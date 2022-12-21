package com.hwfs.sc.scc.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 모바일로 메시지를 전송하는 MobileMsgSend DAO
 * 
 * @ClassName MobileMsgSendDAO.java
 * @Description MobileMsgSendDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.16   	kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.06.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scc/mobileMsgSendDAO")
public class MobileMsgSendDAO extends DefaultDAO {
	
	/**
	 * 모바일 메시지 전송 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scc.mobileMsgSendDAO.selectList", mapParam);
	}

	/**
	 * 모바일 메시지 전송(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scc.mobileMsgSendDAO.insert", mapParam);
	}
	
}
