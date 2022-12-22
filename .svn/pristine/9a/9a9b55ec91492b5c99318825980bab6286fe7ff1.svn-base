package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fms.dao.SmsSendMgmtDAO;
import com.hwfs.cmn.util.StringUtil;
import com.hwfs.rc.rcg.dao.CouponMgntDAO;
import com.hwfs.sc.cmn.dto.LmsMmsDTO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.dto.SmsDTO;
import com.hwfs.sc.cmn.service.LmsMmsSendService;
import com.hwfs.sc.cmn.service.SmsSendService;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 판매단가를 강제변경하는 SmsSendMgmt Service Implementation
 * 
 * @ClassName SmsSendMgmtServiceImpl.java
 * @Description SmsSendMgmtServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016.07.25    kihoon        최초생성
 *  2017.02.03	  kihoon		[CH201702_00137] SMS/LMS 중복발송 에러 수정, 발송이력 미저장 에러 수정
 * </pre>
 * @author FC종합전산구축 : 통합영업 kihoon
 * @since 2016.07.25
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2016 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fms/smsSendMgmtService")
public class SmsSendMgmtServiceImpl extends DefaultServiceImpl implements SmsSendMgmtService {
	
	/** SendSmsMgmtDAO Bean 생성 */
	@Resource(name = "/fm/fms/smsSendMgmtDAO")
	private SmsSendMgmtDAO smsSendDAO;
	
	/** SmsSendService Bean 생성 */
	@Resource(name = "/sc/cmn/smsSendService")
	private SmsSendService smsSendService;
	
	/** LmsMmsSendService Bean 생성 */
	@Resource(name = "/sc/cmn/lmsMmsSendService")
	private LmsMmsSendService lmsMmsSendService;
	
	/** CouponMgntDAO Bean 생성 */
	@Resource(name = "/rc/rcg/couponMgntDAO")
	private CouponMgntDAO couponMgntDAO;
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	/**
	 * 업장 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return smsSendDAO.selectList(mapParam);
	}
	
	/**
	 * 고객 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectCustList(Map<String, Object> mapParam) throws Exception {
		return smsSendDAO.selectCustList(mapParam);
	}
	
	/**
	 * SMS 발송처리.
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
		
		int insRowCnt = 0;
		
		if ( "L".equals(parameterForm.get(0).get("trType")) ) {
			List<LmsMmsDTO> lmsMmsList = new ArrayList<LmsMmsDTO>();
			
			for (int i = 0 ; i < parameterSend.size() ; i++) {
				Map<String, Object> rowData = parameterSend.get(i);
				Map<String, Object> formData = parameterForm.get(0);
				LmsMmsDTO lmsMmsDTO = new LmsMmsDTO();
				
				lmsMmsDTO.setPhone(rowData.get("custHpNo").toString().replaceAll("-", ""));	//수신자 전화번호
				lmsMmsDTO.setCallback((String)formData.get("trCallback")); //송신자 전화번호
				lmsMmsDTO.setMsg((String)formData.get("trMsg")); // 메세지 내용
				lmsMmsDTO.setTrUserId(loginDTO.getSabun()); //송신자 사번
				lmsMmsDTO.setTrCustNo(""); //수신자의 사업장코드
				lmsMmsDTO.setTrDeptId(loginDTO.getDeptId());
				lmsMmsDTO.setTrCcId(loginDTO.getCcCd()); //송신자 부서코드
				if ( !StringUtil.isEmpty(rowData.get("reqDate")) ) {
					lmsMmsDTO.setReqDate(rowData.get("reqDate").toString());
				}
				lmsMmsList.add(lmsMmsDTO);
			}
			
			insRowCnt = lmsMmsSendService.saveLmsMms(lmsMmsList);
			
			for (int i = 0 ; i < parameterSend.size() ; i++) {
				Map<String, Object> rowData = parameterSend.get(i);
				Map<String, Object> formData = parameterForm.get(0);
				int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
				
				// CH201701_00580
				//Insert 처리
				//if (rowType == DataSet.ROW_TYPE_INSERTED) {
					
					Date date = new Date();
					Calendar cal = Calendar.getInstance();
					cal.setTime(date);
					cal.add(Calendar.MINUTE, 3);	// 3분 후 발송
					rowData.put("trSendDate", cal);
					rowData.put("trCallback", formData.get("trCallback"));
					rowData.put("trMsg", formData.get("trMsg"));
					rowData.put("trType", formData.get("trType"));
					rowData.put("trSendUser", loginDTO.getSabun());
					
					smsSendDAO.insertSmsLog(rowData);
				//}
			}
			
		} else {
			List<SmsDTO> smsList = new ArrayList<SmsDTO>();
			
			for (int i = 0 ; i < parameterSend.size() ; i++) {
				Map<String, Object> rowData = parameterSend.get(i);
				Map<String, Object> formData = parameterForm.get(0);
				SmsDTO smsDTO = new SmsDTO();
				
				smsDTO.setTrPhone(rowData.get("custHpNo").toString().replaceAll("-", ""));	//수신자 전화번호
				smsDTO.setTrCallback((String)formData.get("trCallback")); //송신자 전화번호
				smsDTO.setTrMsg((String)formData.get("trMsg")); // 메세지 내용
				smsDTO.setTrUserId(loginDTO.getSabun()); //송신자 사번
				smsDTO.setTrCustNo(""); //수신자의 사업장코드
				smsDTO.setTrDeptId(loginDTO.getDeptId()); //송신자 부서코드
				smsDTO.setTrCcId(loginDTO.getCcCd()); //송신자 부서코드
				
				if ( !StringUtil.isEmpty(rowData.get("reqDate")) ) {
					smsDTO.setTrSendDate(rowData.get("reqDate").toString());
				}
				
				smsList.add(smsDTO);
			}
			
			insRowCnt = smsSendService.saveSms(smsList);
			
			for (int i = 0 ; i < parameterSend.size() ; i++) {
				Map<String, Object> rowData = parameterSend.get(i);
				Map<String, Object> formData = parameterForm.get(0);
				int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
				
				// CH201701_00580
				//Insert 처리
				//if (rowType == DataSet.ROW_TYPE_INSERTED) {
					
					
					Date date = new Date();
					Calendar cal = Calendar.getInstance();
					cal.setTime(date);
					cal.add(Calendar.MINUTE, 3);	// 3분 후 발송
					rowData.put("trSendDate", cal);
					rowData.put("trCallback", formData.get("trCallback"));
					rowData.put("trMsg", formData.get("trMsg"));
					rowData.put("trType", formData.get("trType"));
					rowData.put("trSendUser", loginDTO.getSabun());
					
					smsSendDAO.insertSmsLog(rowData);
				//}
			}
		}
		
		
		
		
		return insRowCnt;
	}
	
	
	
	/**
	 * 쿠폰문자발송처리.
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
	public int saveCouponList(DataSetMap parameterSend, DataSetMap parameterForm, LoginDTO loginDTO) throws Exception {
		
		int insRowCnt = 0;
		String barCodeURL = "https://nfics.hanwhafoodist.co.kr/sc/cmn/barCode/selectCode.do";
		String sendMsg = "";
		
		if ( "L".equals(parameterForm.get(0).get("trType")) ) {
			List<LmsMmsDTO> lmsMmsList = new ArrayList<LmsMmsDTO>();
			
			for (int i = 0 ; i < parameterSend.size() ; i++) {
				Map<String, Object> rowData = parameterSend.get(i);
				Map<String, Object> formData = parameterForm.get(0);
				
				if ( "1".equals(rowData.get("chk").toString()) ) {
					
					LmsMmsDTO lmsMmsDTO = new LmsMmsDTO();
					
					long verify = Long.parseLong(rowData.get("couponNum").toString());
					int offset = 0;
					
					while ( verify > 0 ) {
						offset += verify%10;
						verify/=10;
					}
					
					sendMsg = barCodeURL + "?code=" + rowData.get("couponNum").toString() + "&ofs=" + offset + "\r\n" + (String)formData.get("trMsg");
					
					logger.debug("sendMsg=>"+sendMsg);
					
					
					lmsMmsDTO.setPhone(rowData.get("custHpNo").toString().replaceAll("-", ""));	//수신자 전화번호
					lmsMmsDTO.setCallback((String)formData.get("trCallback")); //송신자 전화번호
					lmsMmsDTO.setMsg(sendMsg); // 메세지 내용
					lmsMmsDTO.setTrUserId(loginDTO.getSabun()); //송신자 사번
					lmsMmsDTO.setTrCustNo(""); //수신자의 사업장코드
					lmsMmsDTO.setTrDeptId(formData.get("trSendCcCd").toString());
					lmsMmsDTO.setTrCcId(formData.get("trSendCcCd").toString()); //송신자 부서코드
					lmsMmsDTO.setReqDate(formData.get("trSendDate").toString());
					lmsMmsDTO.setTrEtc1(rowData.get("msgKey").toString());
					
					lmsMmsList.add(lmsMmsDTO);
				}
			}
			
			insRowCnt = lmsMmsSendService.saveLmsMms(lmsMmsList);
			
			
			
			for (int i = 0 ; i < parameterSend.size() ; i++) {
				Map<String, Object> rowData = parameterSend.get(i);
				Map<String, Object> formData = parameterForm.get(0);
				
				long verify = Long.parseLong(rowData.get("couponNum").toString());
				int offset = 0;
				
				while ( verify > 0 ) {
					offset += verify%10;
					verify/=10;
				}
				
				//sendMsg = barCodeURL + "?barCd=" + rowData.get("couponNum").toString() + "\r" + (String)formData.get("trMsg");
				sendMsg = barCodeURL + "?code=" + rowData.get("couponNum").toString() + "&ofs=" + offset + "\r\n" + (String)formData.get("trMsg");
				
				if ( "1".equals(rowData.get("chk").toString()) ) {
					rowData.put("couponNum", rowData.get("couponNum").toString());
					rowData.put("couponType", rowData.get("couponType").toString());
					rowData.put("trSendDate", formData.get("trSendDate").toString());
					rowData.put("trNum", rowData.get("custHpNo").toString());
					rowData.put("trCallback", formData.get("trCallback"));
					rowData.put("billCc", formData.get("trSendCcCd"));
					rowData.put("msgKey", rowData.get("msgKey"));
					rowData.put("trMsg", sendMsg);
					rowData.put("trType", formData.get("trType"));
					rowData.put("billCc", formData.get("trSendCcCd"));
					rowData.put("trSendUser", loginDTO.getSabun());
					
					couponMgntDAO.insert(rowData);	
				}
			}
			
			
		} else {
			List<SmsDTO> smsList = new ArrayList<SmsDTO>();
			
			for (int i = 0 ; i < parameterSend.size() ; i++) {
				Map<String, Object> rowData = parameterSend.get(i);
				Map<String, Object> formData = parameterForm.get(0);
				
				if ( "1".equals(rowData.get("chk").toString()) ) {
					SmsDTO smsDTO = new SmsDTO();
					
					smsDTO.setTrPhone(rowData.get("custHpNo").toString().replaceAll("-", ""));	//수신자 전화번호
					smsDTO.setTrCallback((String)formData.get("trCallback")); //송신자 전화번호
					smsDTO.setTrMsg((String)formData.get("trMsg")); // 메세지 내용
					smsDTO.setTrUserId(loginDTO.getSabun()); //송신자 사번
					smsDTO.setTrCustNo(""); //수신자의 사업장코드
					smsDTO.setTrDeptId(loginDTO.getDeptId()); //송신자 부서코드
					smsDTO.setTrCcId(loginDTO.getCcCd()); //송신자 부서코드
					
					if ( !StringUtil.isEmpty(rowData.get("reqDate")) ) {
						smsDTO.setTrSendDate(rowData.get("reqDate").toString());
					}
					
					smsList.add(smsDTO);
				}
			}
			
			insRowCnt = smsSendService.saveSms(smsList);
			
			for (int i = 0 ; i < parameterSend.size() ; i++) {
				Map<String, Object> rowData = parameterSend.get(i);
				Map<String, Object> formData = parameterForm.get(0);
				
				if ( "1".equals(rowData.get("chk").toString()) ) {
					rowData.put("couponNum", rowData.get("couponNum").toString());
					rowData.put("couponType", rowData.get("couponType").toString());
					rowData.put("trSendDate", rowData.get("trSendDate").toString());
					rowData.put("trNum", rowData.get("custHpNo").toString());
					rowData.put("trCallback", formData.get("trCallback"));
					rowData.put("msgKey", formData.get("msgKey"));
					rowData.put("trMsg", formData.get("trMsg"));
					rowData.put("trType", formData.get("trType"));
					rowData.put("trSendUser", loginDTO.getSabun());
					
					couponMgntDAO.insert(rowData);	
				}
			}
		}
		
		return insRowCnt;
	}
	
	
	/**
	 * SMS목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectSmsLogList(Map<String, Object> mapParam) throws Exception {
		return smsSendDAO.selectSmsLogList(mapParam);
	}
	
	/**
	 * LMS목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	/*
	public RecordSet selectLmsMgmtList(Map<String, Object> mapParam) throws Exception {
		return smsSendDAO.selectLmsMgmtList(mapParam);
	}
	*/
	
	/**
	 * 문자 발송처리.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	/*
	@SuppressWarnings("unchecked")
	public int saveLmsMgmtList(DataSetMap parameterSearch, DataSetMap parameterSend, DataSetMap parameterForm, LoginDTO loginDTO) throws Exception {
		
		int insRowCnt = 0;
		
		
		return insRowCnt;
	}
	*/
}
