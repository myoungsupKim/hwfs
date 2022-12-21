package com.hwfs.ms.mlm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ms.mlm.dao.EmergencyLoanAppDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.dto.SmsDTO;
import com.hwfs.sc.cmn.service.SmsSendService;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 임시여신승인하는 EmergencyLoanApp Service Implementation
 * 
 * @ClassName EmergencyLoanAppServiceImpl.java
 * @Description EmergencyLoanAppServiceImpl Class
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
@Service("/ms/mlm/emergencyLoanAppService")
public class EmergencyLoanAppServiceImpl extends DefaultServiceImpl implements EmergencyLoanAppService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SmsSendService Bean 생성 */
	@Resource(name = "/sc/cmn/smsSendService")
	private SmsSendService smsSendService;
	
	/** EmergencyLoanAppDAO Bean 생성 */
	@Resource(name = "/ms/mlm/emergencyLoanAppDAO")
	private EmergencyLoanAppDAO emergencyLoanAppDAO;	

	/**
	 * 임시여신승인 목록을 조회한다.
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
		return emergencyLoanAppDAO.selectList(mapParam);
	}

	/**
	 * 임시여신승인 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
		int updRowCnt00 = 0;
		int updRowCnt01 = 0;
		int insRowCntSms = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			String chk = (String)list.get(i).get("chkGubun");
			
			saveChk(rowData); //승인시 기승인건 체크
			
			if(chk.equals("01"))
			{
				updRowCnt00 += emergencyLoanAppDAO.updateUpjang(rowData);	
			}
			
			updRowCnt01 += emergencyLoanAppDAO.updateCreditMobile(rowData);
			
			if(!LimsUtil.checkNull(rowData.get("hpNo")).equals("")){
				
				List<SmsDTO> smsList = new ArrayList<SmsDTO>();
				
				SmsDTO smsDTO = new SmsDTO();
				
				smsDTO.setTrPhone((String) rowData.get("hpNo")); //송신자 전화번호
				smsDTO.setTrCallback("15882299");	//수신자 전화번호
				smsDTO.setTrMsg("임시여신이 승인처리되었습니다. 승인자:" + loginDTO.getNmKor()); // 메세지 내용
				smsDTO.setTrUserId(loginDTO.getSabun()); //송신자 사번
				smsDTO.setTrCustNo(loginDTO.getCcCd()); //송신자 업장코드
				smsDTO.setTrCcId(loginDTO.getCcCd()); //송신자 부서코드
				
				smsList.add(smsDTO);
				logger.debug("smsList >>>" +smsList);
				insRowCntSms = smsSendService.saveSms(smsList);
			}	
			
		}
				
		return updRowCnt00 + updRowCnt01 + insRowCntSms;
	}	

	/**
	 * 임시여신승인 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveReturnList(DataSetMap list, LoginDTO loginDTO) throws Exception {
		int updRowCnt00 = 0;
		int updRowCnt01 = 0;
		int insRowCntSms = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			saveChk(rowData); //반려시 기반려건 체크
			
			//updRowCnt00 += emergencyLoanAppDAO.updateReturnUpjang(rowData);	
			
			updRowCnt01 += emergencyLoanAppDAO.updateReturnCreditMobile(rowData);
			
			if(!LimsUtil.checkNull(rowData.get("hpNo")).equals("")){
				
				List<SmsDTO> smsList = new ArrayList<SmsDTO>();
				
				SmsDTO smsDTO = new SmsDTO();
				
				smsDTO.setTrPhone((String) rowData.get("hpNo")); //송신자 전화번호
				smsDTO.setTrCallback("15882299");	//수신자 전화번호
				smsDTO.setTrMsg("임시여신이 반려처리되었습니다. 반려자:" + loginDTO.getNmKor()); // 메세지 내용
				smsDTO.setTrUserId(loginDTO.getSabun()); //송신자 사번
				smsDTO.setTrCustNo(loginDTO.getCcCd()); //송신자 업장코드
				smsDTO.setTrCcId(loginDTO.getCcCd()); //송신자 부서코드
				
				smsList.add(smsDTO);
				logger.debug("smsList >>>" +smsList);
				insRowCntSms = smsSendService.saveSms(smsList);
			}
		}
				
		return updRowCnt00 + updRowCnt01 + insRowCntSms;
	}
	
	/**
	 * saveChk 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 * @param rowData 
	 *
	 */
	private void saveChk(Map<String, Object> rowData) throws Exception {
		// TODO Auto-generated method stub
		
		RecordSet saveChk = emergencyLoanAppDAO.saveChk(rowData);
		
		String apprYn = (String) saveChk.get(0).get("apprYn");
		
		if(LimsUtil.checkNull(apprYn).equals("Y")){
			
			throw processException("ms.mlm.saveAppChk");
		}	
		
		if(LimsUtil.checkNull(apprYn).equals("C")){
			
			throw processException("ms.mlm.saveReturnChk");
		}	
	}
}
