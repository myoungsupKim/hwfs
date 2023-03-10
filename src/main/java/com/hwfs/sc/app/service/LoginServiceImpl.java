package com.hwfs.sc.app.service;

import hone.hanwha.CustomAnnotaion.CustomAnnotationDefinition;
import hone.core.util.record.MetadataRecord;
import hone.core.util.record.MetadataRecordSet;
import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.sc.app.dao.LoginDAO;
import com.hwfs.sc.cmn.dao.OwnCertDAO;
import com.hwfs.sc.cmn.dao.PwdChgDAO;
import com.hwfs.sc.cmn.dto.SmsDTO;
import com.hwfs.sc.cmn.service.SmsSendService;

 /**
 * 식재앱 로그인 인터페이스용  ServiceImpl에 대한 설명 작성
 * @ClassName LoginServiceImpl.java
 * @Description LoginServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.06.20.  김명섭        최초생성
 * </pre>
 * @author 푸디스트
 * @since 2022.06.20.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by 한화시스템ICT CO.,LTD. All right reserved.
 * </pre>
 */
@Service
public class LoginServiceImpl extends DefaultServiceImpl implements LoginService {
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	@Resource(name="/sc/app/loginDAO")
	private LoginDAO loginDAO;

	/** SmsSendService Bean 생성 */
	@Resource(name = "/sc/cmn/smsSendService")
	private SmsSendService smsSendService;
	
	/** OwnCertDAO Bean 생성 */
	@Resource(name = "/sc/cmn/ownCertDAO")
	private OwnCertDAO ownCertDAO;

	/** PwdChgDAO Bean 생성 */
	@Resource(name = "/sc/cmn/pwdChgDAO")
	private PwdChgDAO pwdChgDAO;
	
	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param txHeader
	 * @param txData
	 * @param txResult
	 * @return
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	@CustomAnnotationDefinition(txId="IF_LOGIN_SERVICE",Description="식재앱 로그인 인터페이스용 Service")
	public JSONObject callService(JSONObject txHeader, JSONObject txData,JSONObject txResult) throws Exception {

		String txDiv = "";
		
		if(txHeader.has("txDiv")){
			txDiv = txHeader.getString("txDiv");
		} else {
			logger.error("txDiv is empty!");
			throw new BizException ("txDiv is empty!");
		}
		
		String sParamString;
		
		Map<String, Object> parameter = new HashMap<String, Object>();

		RecordSet rs = null;
		
		//반환할 결과 데이터를 설정 : key 값은 업무에 맞게 설정
		JSONObject result = new JSONObject();
		JSONObject procResult = new JSONObject();

		// 패스워드 치환여부
		String pwReplaceYn = "N";
		int index1 = 0;
		int index2 = 0;
		
		if(txDiv.equals("SELECT_TEST")){
			
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = loginDAO.selectTest(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "조회 중 오류가 발생했습니다.");
			} else {
				
				rs = removeNull(rs);
				
				JSONArray rsArray = new JSONArray(rs);
				
				procResult.put("resultData", rsArray.toString());
				procResult.put("resultCount", rs.size());
			}
			
		}
		
		//로그인인증
		else if(txDiv.equals("LoginAuth"))
		{
			
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			pwReplaceYn = "Y";
			
			index1 =  txData.toString().indexOf("userPw");
			index2 =  txData.toString().indexOf("userid");
			
			rs = loginDAO.selectUser(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "사용자정보 조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				if(rs.size() == 0) //사용자정보없는경우
				{
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "아이디가 존재하지 않습니다.");
				}
				else
				{
					String strPwdYn, strAcctSts, strAcctLkReasonCd, strSabun = "", strErrDesc = "";
					int iErrCnt, imaxErrCnt;
					
					Map<String, Object> rowData1 = new HashMap<String, Object>();
					
					strPwdYn = rs.get(0).getString("validPwdYn");
					strAcctSts = rs.get(0).getString("acctStatus");
					strAcctLkReasonCd = rs.get(0).getString("acctLkReasonCd");
					iErrCnt = rs.get(0).getInt("pwdErrCnt");
					imaxErrCnt = rs.get(0).getInt("maxPwdErrCnt");
					strSabun = rs.get(0).getString("sabun");
					
					rowData1.put("appId", "FSMOBILE_NEW");
					rowData1.put("sysType", "FSMOBILE");
					rowData1.put("sabun", strSabun);
					
					//비밀번호가틀린경우
	    			if(strPwdYn.equals("N"))
	    			{
						procResult.put("resultData", "");
						procResult.put("resultCount", 0);
	    				procResult.put("ErrorCode", -1); //오류
	    				strErrDesc = "비밀번호가 일치하지 않습니다.";
	    				procResult.put("ErrorMsg", strErrDesc);
	    				
	    				//비밀번호 오류 임계치관리 정보 DB Update
	    				loginDAO.updateLoginPwdErrCnt(parameter);
	    				
	    				//5회 이상 비밀번호 오류가 발생한 경우
	    				if(iErrCnt+1 >= imaxErrCnt)
	    				{
	    					strErrDesc = "비밀번호 오류가 " + imaxErrCnt + "회 이상 발생하여 계정이 잠겨 로그인을 할 수 없습니다.\n\n로그인 화면에서 비밀번호를 재설정하셔야 합니다.";
	        				procResult.put("ErrorMsg", strErrDesc);
	        				//계정을잠근다
	        				if(iErrCnt+1 == imaxErrCnt)
	        				{
	        					loginDAO.updateAccountLockForPwdErrOver (parameter);
	        				}
	    				}
	    			}
	    			//비밀번호정상인경우
	    			else
	    			{
	    				//정상 로그인인 경우 임계치관리 정보 DB 초기화
	    				if(iErrCnt > 0)
	    					loginDAO.updateLoginPwdErrCntInit(parameter);
	    				//계정이잠긴경우
	    				if(strAcctSts.equalsIgnoreCase("LOCK"))
	    				{
	    					if(strAcctLkReasonCd.equalsIgnoreCase("PWD_ERR_OVER"))
	    					{
	    						procResult.put("resultData", "");
	    						procResult.put("resultCount", 0);
	    	    				procResult.put("ErrorCode", -1); //오류
	    	    				strErrDesc = "비밀번호 오류가 " + imaxErrCnt + "회 이상 발생하여 계정이 잠겨 로그인을 할 수 없습니다.\n\n로그인 화면에서 비밀번호를 재설정하셔야 합니다.";
	    	    				procResult.put("ErrorMsg", strErrDesc);
	    						
	    					} else if(strAcctLkReasonCd.equalsIgnoreCase("NO_USE_TIME_OVER"))
	    					{
	    						procResult.put("resultData", "");
	    						procResult.put("resultCount", 0);
	    	    				procResult.put("ErrorCode", -93); //비밀번호 재설정
	    	    				strErrDesc = "일정기간 동안 시스템을 사용하지 않아 계정이 잠긴 상태입니다. 비밀번호를 변경해야 시스템을 사용할 수 있습니다.";
	    	    				procResult.put("ErrorMsg", strErrDesc);
	    					} else
	    					{
	    						procResult.put("resultData", "");
	    						procResult.put("resultCount", 0);
	    	    				procResult.put("ErrorCode", -1); //오류
	    	    				strErrDesc = "계정이 잠겨 로그인을 할 수 없습니다.";
	    	    				procResult.put("ErrorMsg", strErrDesc);    						
	    					}
	    				}
	    				//사용자인증정상
	    				else
	    				{
	    					JSONArray rsArray = new JSONArray(rs);
	    					
	    					procResult.put("resultData", rsArray.toString());
	    					procResult.put("resultCount", rs.size());
	    					
	    					//접속정보 저장
	    					loginDAO.saveLoginConnUser(rowData1);
	    					
	    					//영업사원매출처정보조회
	    					rs = null;
	    					rsArray = null;
	    					rs = loginDAO.selectSalesUpjang(parameter);
	    					rsArray = new JSONArray(rs);					
	    					procResult.put("resultData2", rsArray.toString());

	    					//사용자모바일권한
	    					rs = null;
	    					rsArray = null;
	    					rs = loginDAO.selectUserRole(parameter);
	    					rsArray = new JSONArray(rs);					
	    					procResult.put("resultData3", rsArray.toString());
	    				}
	    			}

					rowData1.put("errDesc", strErrDesc);
					rowData1.put("logDesc", "Login");
					
    				//접속로그 저장
    				loginDAO.insertConnUserLog(rowData1);
				}

			}
		}
		//사용자정보조회
		else if(txDiv.equals("UserInfo")) 
		{

			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = loginDAO.selectUser(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "사용자정보 조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				if(rs.size() == 0) //사용자정보없는경우
				{
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "아이디가 존재하지 않습니다.");
				}
				else
				{
					JSONArray rsArray = new JSONArray(rs);
					
					procResult.put("resultData", rsArray.toString());
					procResult.put("resultCount", rs.size());
					
					Map<String, Object> rowData1 = new HashMap<String, Object>();
					
					rowData1.put("appId", "FSMOBILE_NEW");
					rowData1.put("sysType", "FSMOBILE");
					rowData1.put("sabun", rs.get(0).getString("sabun"));
					rowData1.put("errDesc", "");
					rowData1.put("logDesc", "Renew Login");
					
					//접속정보 저장
					loginDAO.saveLoginConnUser(rowData1);
					
					//접속로그 저장
					loginDAO.insertConnUserLog(rowData1);
					
					//영업사원매출처정보조회
					rs = null;
					rsArray = null;
					rs = loginDAO.selectSalesUpjang(parameter);
					rsArray = new JSONArray(rs);					
					procResult.put("resultData2", rsArray.toString());

					//사용자모바일권한
					rs = null;
					rsArray = null;
					rs = loginDAO.selectUserRole(parameter);
					rsArray = new JSONArray(rs);					
					procResult.put("resultData3", rsArray.toString());
				}
			}			
		} 
		//개인정보동의처리
		else if(txDiv.equals("PinfocolAgree")) 
		{
			
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			String strType = parameter.get("type").toString();
			String strMrcvYn = parameter.get("mrcvYn").toString();
			
			//데이터오류
			if(!strMrcvYn.equals("Y") && !strMrcvYn.equals("N"))
			{
				procResult.put("resultCount", 0);
				procResult.put("ErrorCode", -9); //오류
				procResult.put("ErrorMsg", "동의여부 데이터가 올바르지 않습니다.");
			}
			else if(!strType.equals("1") && !strType.equals("2") && !strType.equals("3") && !strType.equals("4"))
			{
				procResult.put("resultCount", 0);
				procResult.put("ErrorCode", -9); //오류
				procResult.put("ErrorMsg", "처리유형 데이터가 올바르지 않습니다.");
			}
			//데이터정상
			else
			{
				int iRow = 0;

				//데이터오류
				if("1".equals(strType) || "2".equals(strType)) {
					iRow = loginDAO.updateMrecvYn2(parameter);
				} else {
					iRow = loginDAO.updateMrecvYn(parameter);
				}
				
				if(iRow <= 0) {
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "개인정보처리 저장 중 오류가 발생했습니다.");
				} else {
					procResult.put("resultCount", iRow);
				}			
			}
		}

		//인증번호요청_비밀번호찾기(재설정)
		else if(txDiv.equals("AuthnumReq")) 
		{
			
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			//1.등록된 사용자인지를 확인
			String sabun = ownCertDAO.selectUserInfo(parameter);
			if (sabun == null)
			{
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "해당정보와 일치하는 사용자가 없습니다.");				
			}
			else
			{
				//2.인증번호 Random 채번
				SecureRandom random = new SecureRandom();
				String cernNum = String.format("%06d", random.nextInt(1000000));	//최대 6자리 숫자이며 앞에 0을 추가
				parameter.put("personCernNum", cernNum);
				
				//3.DB에 저장
				ownCertDAO.updateCernNum(parameter);
				
				//4.인증번호를 SMS로 발송
				SmsDTO smsDTO = new SmsDTO();
				smsDTO.setTrPhone(parameter.get("hpNo").toString());	//수신자 전화번호
				smsDTO.setTrMsg(messageService.getMessage("sc.cmn.cern.num.msg", new String[]{cernNum}));	//전송 메시지
				
				//송신자번호가 없는 경우는 기본 전화번호로 설정한다.
				smsDTO.setTrCallback(propertiesService.getString("ems.sms.callback.no", ""));
				
				//전송할 시간 : 생략하면 현재 시간
				
				smsDTO.setTrCcId(propertiesService.getString("ems.sms.cmn.send.deptId", ""));	//시스템공통에서 보내는 메시지에 대한 부서 설정
				smsDTO.setTrUserId(sabun);			//당사자 사번
				smsDTO.setTrCustNo("");				//해당 사항 없음
				
				//SMS 전송
				smsSendService.saveSms(smsDTO);
				
				procResult.put("resultData", cernNum);
				procResult.put("resultCount", 1);
			}			
		}
		
		//비밀번호재설정
		else if(txDiv.equals("PwdChg")) 
		{
			
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			pwReplaceYn = "Y";
			
			index1 =  txData.toString().indexOf("newPwd");
			index2 =  txData.toString().indexOf("userid");
			
			String sNewPwd = parameter.get("newPwd").toString();
			
			int patternCnt = 0;
			
			boolean sameChar = Pattern.matches(".*(\\w)\\1\\1\\1.*", sNewPwd);
			boolean sameSpcChar = Pattern.matches(".*([@#$%^&+=?.,:;!~])\\1\\1\\1.*", sNewPwd);	
			boolean ctneNumChar = Pattern.matches(".*(0123|1234|2345|3456|4567|5678|6789|7890).*", sNewPwd);
			boolean ctneChar1 = Pattern.matches(".*(qwer|wert|erty|rtyu|tyui|yuio|uiop|asdf|sdfg|dfgh|fghj|ghjk|hjkl|zxcv|xcvb|cvbn|vbnm).*", sNewPwd);
			boolean ctneChar2 = Pattern.matches(".*(QWER|WERT|ERTY|RTYU|TYUI|YUIO|UIOP|ASDF|SDFG|DFGH|FGHJ|GHJK|HJKL|ZXCV|XCVB|CVBN|VBNM).*", sNewPwd);
			boolean engUpper = Pattern.matches(".*[A-Z].*", sNewPwd);
			boolean engLower = Pattern.matches(".*[a-z].*", sNewPwd); 
			boolean numChar = Pattern.matches(".*[0-9].*", sNewPwd);
			boolean spcChar = Pattern.matches(".*[@#$%^&+=?.,:;!~].*", sNewPwd);
			
			
			if ( engUpper )	patternCnt++;
			if ( engLower ) patternCnt++;
			if ( numChar )	patternCnt++;
			if ( spcChar )	patternCnt++;

			procResult.put("resultCount", 0);

			if ( patternCnt < 2 ) {
				procResult.put("ErrorCode", -11);
				procResult.put("ErrorMsg", "비밀번호로 사용하기에는 적합하지 않습니다.\n\n비밀번호 규칙에 맞지 않습니다.");
			}
			
			else if ( patternCnt == 2 && sNewPwd.length() < 10 ) {
				procResult.put("ErrorCode", -12);
				procResult.put("ErrorMsg", "비밀번호로 사용하기에는 적합하지 않습니다.\n\n최소 10자리 이상의 비밀번호로 구성되어야 합니다.");
			}
			
			else if ( patternCnt > 2 && sNewPwd.length() < 8 ) {
				procResult.put("ErrorCode", -13);
				procResult.put("ErrorMsg", "비밀번호로 사용하기에는 적합하지 않습니다.\n\n최소  8자리 이상의 비밀번호로 구성되어야 합니다.");
			}
			
			else if ( sameChar ) {
				procResult.put("ErrorCode", -14);
				procResult.put("ErrorMsg", "비밀번호로 사용하기에는 적합하지 않습니다.\n\n동일문자[문자,숫자](4회)로 이루어진 비밀번호는 사용할 수 없습니다.");
			}
			
			else if ( sameSpcChar ) {
				procResult.put("ErrorCode", -15);
				procResult.put("ErrorMsg", "비밀번호로 사용하기에는 적합하지 않습니다.\n\n동일문자[특수문자](4회)로 이루어진 비빌번호는 사용할 수 없습니다.");
			}
			
			else if ( ctneNumChar ) {
				procResult.put("ErrorCode", -16);
				procResult.put("ErrorMsg", "비밀번호로 사용하기에는 적합하지 않습니다.\n\n연속된 숫자(4회)로 이루어진 비밀번호는 사용할 수 없습니다.");
			}
			
			else if ( ctneChar1 ) {
				procResult.put("ErrorCode", -17);
				procResult.put("ErrorMsg", "비밀번호로 사용하기에는 적합하지 않습니다.\n\n인지하기 쉬운문자(소문자)는 비밀번호로 사용할 수 없습니다.\n(예:asdf, qwer, hjkl등)");
			}
			
			else if ( ctneChar2 ) {
				procResult.put("ErrorCode", -18);
				procResult.put("ErrorMsg", "비밀번호로 사용하기에는 적합하지 않습니다.\n\n인지하기 쉬운문자(대문자)는 비밀번호로 사용할 수 없습니다.\n(예:ASDF, QWER, HJKL등)");
			}
			
			else
			{
				
				Record r = loginDAO.selectPwdChg(parameter);

				parameter.put("curPwd", r.get("passWord"));

				if ("FALSE".equals(r.get("curPwd").toString())) { 
					procResult.put("ErrorCode", -21);
					procResult.put("ErrorMsg", super.messageService.getMessage("sc.cmn.pwdChg.curPwdError"));
				} else if ( "FALSE".equals(r.get("newPwd").toString()) ) {
					procResult.put("ErrorCode", -22);
					procResult.put("ErrorMsg", "이전에 사용한 비밀번호는 사용할 수 없습니다.");
				} else if ("TRUE".equals(r.get("curPwd").toString()) && "N".equals(r.get("acctStatus").toString())) {
					procResult.put("ErrorCode", -23);
					procResult.put("ErrorMsg", "현재 휴직 및 퇴사 상태입니다.");
				} else if ("TRUE".equals(r.get("curPwd").toString())
						&& "TRUE".equals(r.get("newPwd").toString())
						&& "TRUE".equals(r.get("telNo2").toString())
						&& "TRUE".equals(r.get("telNo3").toString())
						&& "TRUE".equals(r.get("telNo").toString())
						&& "TRUE".equals(r.get("hpNo1").toString())
						&& "TRUE".equals(r.get("hpNo2").toString())
						&& "TRUE".equals(r.get("hpNo3").toString())
						&& "TRUE".equals(r.get("hpNo").toString())
						&& "TRUE".equals(r.get("perChk1").toString())) {
					if (loginDAO.updatePwd(parameter) > 0) {
						procResult.put("resultCount", 1);
					} else {
						procResult.put("ErrorCode", -24);
						procResult.put("ErrorMsg", "기타 사유로 인하여 비밀번호를 변경할 수 없습니다.\n관리자에게 문의하시기 바랍니다.");
					}
				} else {
					procResult.put("ErrorCode", -25);
					procResult.put("ErrorMsg", "개인정보(전화번호등)이 포함된 비밀번호는 사용할 수 없습니다.");
				}
				
			}
		}

		//인증번호요청_아이디찾기
		else if(txDiv.equals("IdfindReq")) 
		{
			
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			//1.등록된 사용자인지를 확인
			rs = loginDAO.selectIdFind(parameter);
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "해당정보와 일치하는 사용자가 없습니다.");
			} else {
				rs = removeNull(rs);
				
				if(rs.size() == 0) //사용자정보없는경우
				{
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "해당정보와 일치하는 사용자가 없습니다.");
				}
				else
				{
					//인증번호 Random 채번
					SecureRandom random = new SecureRandom();
					String cernNum = String.format("%06d", random.nextInt(1000000));	//최대 6자리 숫자이며 앞에 0을 추가
					parameter.put("personCernNum", cernNum);
					
					//4.인증번호를 SMS로 발송
					SmsDTO smsDTO = new SmsDTO();
					smsDTO.setTrPhone(parameter.get("hpNo").toString());	//수신자 전화번호
					smsDTO.setTrMsg(messageService.getMessage("sc.cmn.cern.num.msg", new String[]{cernNum}));	//전송 메시지
					
					//송신자번호가 없는 경우는 기본 전화번호로 설정한다.
					smsDTO.setTrCallback(propertiesService.getString("ems.sms.callback.no", ""));
					
					smsDTO.setTrCcId(propertiesService.getString("ems.sms.cmn.send.deptId", ""));	//시스템공통에서 보내는 메시지에 대한 부서 설정
					smsDTO.setTrUserId("MobileAdmin");			//
					smsDTO.setTrCustNo("");				//해당 사항 없음
					
					//SMS 전송
					smsSendService.saveSms(smsDTO);
				
					JSONArray rsArray = new JSONArray(rs);
					
					procResult.put("resultData", rsArray.toString());
					procResult.put("resultCount", rs.size());					
					procResult.put("resultCertnum", cernNum);
					procResult.put("resultCount", 1);					
				}
			}
						
		}
		
		else
		{
			procResult.put("resultData", "");
			procResult.put("resultCount", 0);
			procResult.put("ErrorCode", -99); //오류
			procResult.put("ErrorMsg", "서비스ID가 올바르지 않습니다.");    									
		}
		
		procResult.put("txDiv", txDiv);

		result.put("data", procResult);

		//로그저장start
		int insLogCnt = 0;
		String tHeader = "";
		String tData = "";
		String tResult = "";
		tHeader = txHeader.toString();
		tData = txData.toString();
		
		if("Y".equals(pwReplaceYn)){
			// tData = txData.toString().replaceAll(txData.getJSONObject("data").getString("userPw").indexOf(0) , "");
			// index1 : pw, index2 : id
			if(index2 > index1){
				tData = tData.substring(0,index1) + tData.substring(index2);
			} else {
				tData = tData.substring(0,index1 - 2) + "}}";
			}
		}
		
		tResult = result.getJSONObject("data").toString();
		parameter.put("txId", txHeader.getString("txId"));
		parameter.put("txDiv", txDiv);
		parameter.put("tHeader", tHeader);
		parameter.put("tData", tData);
		parameter.put("tResult", tResult);
		insLogCnt += loginDAO.logInsert(parameter);
		//로그저장end
		
		return result;
	}
	
	/**
	 * 데이터 널 여부 체크
	 * isNull 기능 설명
	 *
	 * @param data
	 * @return
	 */
	public boolean isNull(String data){
		if(data == null || data.equals("")){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 데이터의 길이 체크
	 * isLength 기능 설명
	 *
	 * @param data
	 * @param lengthSize
	 * @return
	 */
	public boolean isLength(String data, int lengthSize){
		if(data.length() > lengthSize)return true;
		return false;
	}
	
	/**
	 * 데이터의 날짜 길이 체크
	 *
	 * @param data
	 * @return
	 */
	public boolean isDate(String data){
		if(data.length() == 8)return true;
		return false;
	}
	
	public String chkIsNull(JSONArray datas,int row,String col) throws Exception{
		String data = "";
		try{
			data = datas.getJSONObject(row).getString(col);
		}catch(Exception e){
			return "";
		}
		return data;
	}

    @SuppressWarnings("unchecked")
	public static Map<String, Object> toMap(JSONObject object) throws JSONException {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		Iterator <String> keys = object.keys();
		while(keys.hasNext()){
			String key = keys.next();
			Object value = object.get(key);
			
			if(value instanceof JSONArray){
				value = toList((JSONArray)value);
			}else if (value instanceof JSONObject){
				value = toMap((JSONObject)value);
			}
			map.put(key, value);
			
		}
		
		return map;
	}

	public static List<Object> toList(JSONArray array) throws JSONException {
		List<Object> list = new ArrayList<Object>();
		
		for(int i=0; i< array.length();i++){
			Object value = array.get(i);
			if(value instanceof JSONArray){
				value = toList((JSONArray)value);
			}else if(value instanceof JSONObject){
				value = toMap((JSONObject)value);
			}
			list.add(value);
		}
		return list;
	}

    public static RecordSet removeNull(RecordSet rs) {
    	
    	MetadataRecordSet result = new MetadataRecordSet(rs.getMetadata());
    	
		for(int i = 0; i < rs.size(); i++){
    		
			MetadataRecord metadataRecord = new MetadataRecord(rs.getMetadata());
			Iterator<String> meta = rs.getMetadata().getKeys();
			
			while(meta.hasNext()){
    			
				String key = meta.next();
    		
    			String value = rs.get(i).getString(key);
    			
    			if(value == null || "null".equals(value)){
    				value = "";
    			}
    			
    			metadataRecord.put(key, value);
			}
			
			result.add(metadataRecord);
    	}
    	return result;
    	
    }
	
}
