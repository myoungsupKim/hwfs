package com.hwfs.ms.mlm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ms.cmn.service.MobileCommonService;
import com.hwfs.ms.mlm.dao.EmergencyLoanReqtDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.dto.SmsDTO;
import com.hwfs.sc.cmn.service.SmsSendService;

 /**
 * 임시여신신청하는 EmergencyLoanReqt Service Implementation
 * 
 * @ClassName EmergencyLoanReqtServiceImpl.java
 * @Description EmergencyLoanReqtServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.31    강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 모바일 강대성
 * @since 2015.03.31
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ms/mlm/emergencyLoanReqtService")
public class EmergencyLoanReqtServiceImpl extends DefaultServiceImpl implements EmergencyLoanReqtService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	/** MobileCommonService Bean 생성 */
	@Resource(name = "/ms/cmn/mobileCommonService")
	private MobileCommonService mobileCommonService;
	
	/** SmsSendService Bean 생성 */
	@Resource(name = "/sc/cmn/smsSendService")
	private SmsSendService smsSendService;
	
	/** EmergencyLoanReqtDAO Bean 생성 */
	@Resource(name = "/ms/mlm/emergencyLoanReqtDAO")
	private EmergencyLoanReqtDAO emergencyLoanReqtDAO;
	

	/**
	 * 임시여신신청 목록을 조회한다.
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
	public RecordSet selectHistList(Map<String, Object> mapParam) throws Exception {
		return emergencyLoanReqtDAO.selectHistList(mapParam);
	}
	
	/**
	 * 임시여신신청내역 목록을 조회한다.
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
		return emergencyLoanReqtDAO.selectList(mapParam);
	}

	/**
	 * 임시여신신청 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap list, LoginDTO loginDTO) throws Exception {
		int insRowCnt = 0;
		int insRowCntSms = 0;
		int updRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			RecordSet saveChk = emergencyLoanReqtDAO.selectList(rowData);
			
			String apprYn = (String) saveChk.get(0).get("apprYn");
			
			if(LimsUtil.checkNull(apprYn).equals("N")){
				
				throw processException("ms.mlm.saveChk");
			}				
			
			//FMS_UPJANG테이블의 임시여신요청액, 임시여신한도일 및 요청사유를 업데이트한다(승인시에만 업데이트 해줌)
			//updRowCnt += emergencyLoanReqtDAO.update(rowData);
			
			//FMS_CREDIT_MOBILE테이블에 여신정보를 등록한다
			insRowCnt += emergencyLoanReqtDAO.insert(rowData);
			
			Map <String, Object> inParam = new HashMap<String, Object>();
			inParam.put("groupCode", "FM0014");	 //임시여신승인자 공통 그룹코드			
			
			//모바일 공통 서비스 을(를) 조회한다.
			RecordSet approvList = mobileCommonService.selectList(inParam);	
			
			logger.debug("approvList.size() >>>" +approvList.size());
			
			for (int j = 0 ; j < approvList.size() ; j++) {
				
				List<SmsDTO> smsList = new ArrayList<SmsDTO>();
				
				SmsDTO smsDTO = new SmsDTO();
				
				smsDTO.setTrPhone((String)approvList.get(j).get("set1")+(String)approvList.get(j).get("set2")+(String)approvList.get(j).get("set3")); //송신자 전화번호
				smsDTO.setTrCallback("15882299");	//수신자 전화번호
				smsDTO.setTrMsg("임시여신신청건이 있습니다. 요청자:" + loginDTO.getNmKor() + ",요청업장:" + rowData.get("upjangnmDisp")); // 메세지 내용
				smsDTO.setTrUserId(loginDTO.getSabun()); //송신자 사번
				smsDTO.setTrCustNo(loginDTO.getCcCd()); //송신자 업장코드
				smsDTO.setTrCcId(loginDTO.getCcCd()); //송신자 부서코드
				
				smsList.add(smsDTO);
				logger.debug("smsList >>>" +smsList);
				insRowCntSms = smsSendService.saveSms(smsList);
				
			}			
		}
				
		return insRowCnt + insRowCntSms + updRowCnt;
	}
}
