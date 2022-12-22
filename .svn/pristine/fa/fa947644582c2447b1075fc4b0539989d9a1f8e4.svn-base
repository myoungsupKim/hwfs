package com.hwfs.sc.cmn.dao;

import hone.core.util.record.RecordSet;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;
import com.hwfs.cmn.service.PropertiesService;
import com.hwfs.sc.cmn.dto.SmsDTO;

 /**
 * SMS를 전송하는 SmsSend DAO
 * 
 * @ClassName SmsSendDAO.java
 * @Description SmsSendDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.13   	kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.03.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/smsSendDAO")
public class SmsSendDAO extends DefaultDAO {
	
	/** PropertyService DI */
	@Resource(name = "propertiesService")
	protected PropertiesService propertiesService;

	/**
	 * SMS 전송 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectListSms(Map<String, Object> mapParam) throws Exception {
//		if (isTest())
//			return super.queryForRecordSet("sc.cmn.smsSendDAO.selectListSmsTest", mapParam);
//		else
		//실제 환경의 로그 조회
			return super.queryForRecordSet("sc.cmn.smsSendDAO.selectListSms", mapParam);
	}

	/**
	 * SMS 전송(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertSms(List<SmsDTO> list) throws Exception {
		String queryId;
		if (isTest())
			queryId = "sc.cmn.smsSendDAO.insertSmsTest";
		else
			queryId = "sc.cmn.smsSendDAO.insertSms";
		
		int cnt = 0;
		for (int i=0; i < list.size(); i++)
			cnt += super.update(queryId, list.get(i));
		
		return cnt;
	}

	/**
	 * SMS 전송(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertSms(SmsDTO smsDTO) throws Exception {
		String queryId;
		if (isTest())
			queryId = "sc.cmn.smsSendDAO.insertSmsTest";
		else
			queryId = "sc.cmn.smsSendDAO.insertSms";
		
		return super.update(queryId, smsDTO);
	}

	/**
	 * EMS가 테스트 환경인지 여부인지 검사한다.
	 * <pre>
	 * - ems.test.env=true이면 테스트 테이블로 처리, 아니면 실제 환경으로 처리한다.
	 * </pre>
	 *
	 * @return
	 */
	private boolean isTest () {
		return propertiesService.getBoolean("ems.test.env", true);
	}
}
