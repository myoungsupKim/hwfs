package com.hwfs.sc.cmn.service;

import java.security.SecureRandom;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dao.OwnCertDAO;
import com.hwfs.sc.cmn.dto.SmsDTO;
import com.sun.org.apache.xml.internal.security.utils.Base64;

 /**
 * 본인인증을 처리하는 OwnCert Service Implementation
 * 
 * @ClassName OwnCertServiceImpl.java
 * @Description OwnCertServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.27    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.04.27
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/ownCertService")
public class OwnCertServiceImpl extends DefaultServiceImpl implements OwnCertService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SmsSendService Bean 생성 */
	@Resource(name = "/sc/cmn/smsSendService")
	private SmsSendService smsSendService;
	
	/** OwnCertDAO Bean 생성 */
	@Resource(name = "/sc/cmn/ownCertDAO")
	private OwnCertDAO ownCertDAO;
	

	/**
	 * 본인인증번호를 요청한다.
	 * <pre>
	 * - 발급된 인증번호는 SMS로 발송한다.
	 * </pre>
	 *
	 * @param mapParam
	 *            요청조건 Map
	 * @return String 
	 *            발급된 인증번호
	 * @throws Exception
	 */
	public String requestCernNum(Map<String, Object> mapParam) throws Exception {
		//1.등록된 사용자인지를 확인
		String sabun = ownCertDAO.selectUserInfo(mapParam);
		if (sabun == null)
			throw processException ("sc.cmn.cern.no.user");
		
		//2.인증번호 Random 채번
		SecureRandom random = new SecureRandom();
		String cernNum = String.format("%06d", random.nextInt(1000000));	//최대 6자리 숫자이며 앞에 0을 추가
		mapParam.put("personCernNum", cernNum);
		
		//3.DB에 저장
		ownCertDAO.updateCernNum(mapParam);
		
		//4.인증번호를 SMS로 발송
		SmsDTO smsDTO = new SmsDTO();
		smsDTO.setTrPhone(mapParam.get("hpNo").toString());	//수신자 전화번호
		smsDTO.setTrMsg(messageService.getMessage("sc.cmn.cern.num.msg", new String[]{cernNum}));	//전송 메시지
		
		//송신자번호가 없는 경우는 기본 전화번호로 설정한다.
		smsDTO.setTrCallback(propertiesService.getString("ems.sms.callback.no", ""));
		
		//전송할 시간 : 생략하면 현재 시간
		
		smsDTO.setTrCcId(propertiesService.getString("ems.sms.cmn.send.deptId", ""));	//시스템공통에서 보내는 메시지에 대한 부서 설정
		smsDTO.setTrUserId(sabun);			//당사자 사번
		smsDTO.setTrCustNo("");				//해당 사항 없음
		
		logger.debug("requestCernNum={}, sendSMS={}", mapParam, smsDTO);
		
		//SMS 전송
		smsSendService.saveSms(smsDTO);
		
		//인증번호 반환
		return cernNum;
	}

	/**
	 * 본인인증번호를 확인한다.
	 * <pre>
	 * - 발급된 번호와 DB에 저장된 번호를 비교하여 확인한다.
	 * </pre>
	 * 
	 * @param mapParam
	 *            확인조건 Map
	 * @return boolean 
	 *            확인결과
	 * @throws Exception
	 */
	public boolean confirmCernNum(Map<String, Object> mapParam) throws Exception {
		//인증번호 조회
		String cernNum = ownCertDAO.selectCernNum(mapParam);
		
		//인증번호 비교
		return cernNum.equals(mapParam.get("personCernNum")) ? true : false;
	}

	/**
	 * 본인인증번호를 확인한다.
	 * <pre>
	 * - 발급된 번호와 DB에 저장된 번호를 비교하여 확인한다.
	 * </pre>
	 * 
	 * @param mapParam
	 *            확인조건 Map
	 * @return boolean 
	 *            확인결과
	 * @throws Exception
	 */
	public String confirmCernNumCheck(Map<String, Object> mapParam) throws Exception {
		
		DateFormat sdFormat = new SimpleDateFormat("yyyyMMdd");
		Date nowDate = new Date();
		
		//인증번호 조회
		String cernNum = ownCertDAO.selectCernNum(mapParam);
		
		String verify = cernNum + sdFormat.format(nowDate);
		String vKey = Base64.encode(verify.getBytes());
		
		return vKey.substring(0, vKey.length()-1);
	}
}
