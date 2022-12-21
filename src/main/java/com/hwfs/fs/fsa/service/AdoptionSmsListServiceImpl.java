package com.hwfs.fs.fsa.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsa.dao.AdoptionSmsListDAO;
import com.hwfs.sc.cmn.dao.SmsSendDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.dto.SmsDTO;
import com.hwfs.sc.cmn.service.SmsSendService;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 채용인력 sms발송하는 AdoptionSmsList Service Implementation
 * 
 * @ClassName AdoptionSmsListServiceImpl.java
 * @Description AdoptionSmsListServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.15    김예진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.04.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsa/adoptionSmsListService")
public class AdoptionSmsListServiceImpl extends DefaultServiceImpl implements AdoptionSmsListService {

	/** AdoptionSmsListDAO Bean 생성 */
	@Resource(name = "/fs/fsa/adoptionSmsListDAO")
	private AdoptionSmsListDAO adoptionSmsListDAO;
	
	/** SmsSendService Bean 생성 */
	@Resource(name = "/sc/cmn/smsSendService")
	private SmsSendService smsSendService;
	

	/**
	 * 채용인력 목록을 조회한다.
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
		return adoptionSmsListDAO.selectList(mapParam);
	}
	public RecordSet selectSmslog(Map<String, Object> mapParam) throws Exception {
		return adoptionSmsListDAO.selectSmslog(mapParam);
	}

	/**
	 * 채용인력 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap parameterSend, DataSetMap parameterForm, LoginDTO loginDTO) throws Exception {
		int insRowCntSms = 0;
		int insRowCnt = 0;
		
		List<SmsDTO> smsList = new ArrayList<SmsDTO>();
		
		for (int i = 0 ; i < parameterSend.size() ; i++) {
			Map<String, Object> rowData = parameterSend.get(i);
			Map<String, Object> formData = parameterForm.get(0);
			SmsDTO smsDTO = new SmsDTO();
			
			smsDTO.setTrPhone(rowData.get("handphoneNum").toString().replaceAll("-", ""));	//수신자 전화번호
			smsDTO.setTrCallback((String)formData.get("sendNum1")+(String)formData.get("sendNum2")+(String)formData.get("sendNum3")); //송신자 전화번호
			smsDTO.setTrMsg((String)formData.get("content")); // 메세지 내용
			smsDTO.setTrUserId(loginDTO.getSabun()); //송신자 사번
			smsDTO.setTrCustNo(""); //수신자의 사업장코드
			smsDTO.setTrCcId(loginDTO.getCcCd()); //송신자 부서코드
			
			smsList.add(smsDTO);
		}
		
		insRowCntSms = smsSendService.saveSms(smsList);
		
		for (int i = 0 ; i < parameterSend.size() ; i++) {
			Map<String, Object> rowData = parameterSend.get(i);
			Map<String, Object> formData = parameterForm.get(0);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				rowData.put("content", formData.get("content"));
				rowData.put("sender", formData.get("sender"));
				insRowCnt += adoptionSmsListDAO.insertSmsLog(rowData);
				//adoptionSmsListDAO.insertSmsLog(rowData);
			}
		}
		return insRowCntSms;
	}
	
}
