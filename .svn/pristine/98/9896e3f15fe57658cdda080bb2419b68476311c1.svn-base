package com.hwfs.sc.cmn.service;

import hanwha.neo.branch.common.approval.dto.SLO_REQUEST;
import hanwha.neo.branch.common.approval.dto.SLO_RESPONSE;
import hanwha.neo.branch.common.slo.service.CommonSloWsProxy;
import hanwha.neo.slo.SLOCrypt4AES;
import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.sc.cmn.dao.GwIfDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 그룹웨어 연동하는 GwIf Service Implementation
 * 
 * @ClassName GwIfServiceImpl.java
 * @Description GwIfServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.18    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.03.18
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/gwIfService")
public class GwIfServiceImpl extends DefaultServiceImpl implements GwIfService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** GwIfDAO Bean 생성 */
	@Resource(name = "/sc/cmn/gwIfDAO")
	private GwIfDAO gwIfDAO;
	

	/**
	 * SLO 연계를 위한 OTA ID를 생성하여 얻는다.
	 *
	 * @param request HttpServletRequest
	 * @return String OTA ID
	 * @throws Exception
	 */
	public String selectOtaId (HttpServletRequest request) throws Exception {
		CommonSloWsProxy proxy = new CommonSloWsProxy();
		proxy.setEndpoint(propertiesService.getString("gw.server.endpoint","") + propertiesService.getString("gw.slo.endpoint", ""));

		logger.info("#####selectOtaId Start#####");
		String empNo;
		//테스트 환경인지 여부에 따라 처리
		if (propertiesService.getBoolean("gw.test.env",true)) {
			empNo = propertiesService.getString("gw.test.empNo", ""); //"9999999990"; // 테스트 사용자 사번
		}else{
			//(실제용) 로그인 사번
			LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
			empNo = loginDTO.getSabun();
		}
		logger.info("#####empNo:" + empNo);
		
		String encEmpNo = SLOCrypt4AES.encrypt(empNo, propertiesService.getString("gw.slo.encrypt.seed"));
		logger.info("#####encEmpNo:" + encEmpNo);
		
		SLO_REQUEST requst = new SLO_REQUEST();
		
		requst.setEMP_NO(encEmpNo);
		requst.setENC_TYPE(propertiesService.getString("gw.slo.encrypt.type","A"));

		logger.info("#####SLO_REQUEST#####");

		SLO_RESPONSE response = proxy.create(requst);
		String strOtaId = response.getENCRYPTED_OTA_ID();
		logger.info("#####strOtaId:" + strOtaId);
		
		logger.debug("encrypted OTA ID={}", strOtaId);
		
		return strOtaId;
	}

	/**
	 * 비즈웰 그룹웨어 연동을 위한 사번 Get
	 *
	 * @param request HttpServletRequest
	 * @return String Sabun
	 * @throws Exception
	 */
	public String selectSabun (HttpServletRequest request) throws Exception {

		logger.info("#####selectSabun Start#####");
		String empNo;
		//테스트 환경인지 여부에 따라 처리
		if (propertiesService.getBoolean("bizwellgw.test.env",true)) {
			empNo = propertiesService.getString("bizwellgw.test.empNo", ""); //테스트 사용자 사번
		}else{
			//(실제용) 로그인 사번
			LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
			empNo = loginDTO.getSabun();
		}
		logger.info("#####empNo:" + empNo);

		return empNo;
	}
	
	/**
	 * 전자결재연동 상태를 처리한다.
	 * <pre>
	 * - 스케쥴러에 의해 호출된다.
	 * - SIGN_IF.TB_EVT_INFO에 쌓이는 정보 중 미처리된 건을 읽어 처리
	 * - SIGN_IF.TB_EVT_INFO에 처리 상태로 Update
	 * - SCC_SIGN_INFO에 결재진행정보 Insert orUpdate
	 * - 건별로 트랜잭션을 분리해서 처리
	 * </pre>
	 *
	 * @return 처리건수
	 * @throws Exception
	 */
	public int processSignStatus () throws Exception {
		//현재 미처리 건 목록을 조회한다.
		RecordSet list = gwIfDAO.selectUntreatedList();

		int procCnt = 0;
		for (Record record:list) {
			//오류 건은 무시하고 처리 
			try {
				procCnt += processSignStatusNewTx (record);
			}catch(Exception e) {
				logger.error(e.getMessage());
			}
		}

		return procCnt;
	}

	/**
	 * 전자결재연동 상태를 건별로 트랜잭션을 분리해서 처리한다.
	 * <pre>
	 * - SIGN_IF.TB_EVT_INFO에 쌓이는 정보 중 미처리된 건을 읽어 처리
	 * - SIGN_IF.TB_EVT_INFO에 처리 상태로 Update
	 * - SCC_SIGN_INFO에 결재진행정보 Insert orUpdate
	 * - 건별로 트랜잭션을 분리해서 처리
	 * </pre>
	 *
	 * @return 처리건수
	 * @throws Exception
	 */
	public int processSignStatusNewTx (Record record) throws Exception {
		int procCnt = 0;
		
		//SCC_SIGN_INFO에 결재진행정보 Insert orUpdate
		procCnt += gwIfDAO.saveSignInfo(record);
		
		//SIGN_IF.TB_EVT_INFO에 처리 상태로 Update
		gwIfDAO.updateTreated(record);

		return procCnt;
	}

}
