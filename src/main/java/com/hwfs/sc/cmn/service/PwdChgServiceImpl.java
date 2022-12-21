package com.hwfs.sc.cmn.service;

import hone.core.util.record.Record;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dao.PwdChgDAO;

/**
 * 비밀번호를 변경하는하는 PwdChg Service Implementation
 *
 * @ClassName PwdChgServiceImpl.java
 * @Description PwdChgServiceImpl Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.24    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.04.24
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/pwdChgService")
public class PwdChgServiceImpl extends DefaultServiceImpl implements
		PwdChgService {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	/** PwdChgDAO Bean 생성 */
	@Resource(name = "/sc/cmn/pwdChgDAO")
	private PwdChgDAO pwdChgDAO;

	/**
	 * 비밀번호 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	 */
	public Map<String, String> save(Map<String, Object> parameter)
			throws Exception {
		Map<String, String> rtn = new HashMap<String, String>();
		
		
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
		
		logger.info("sNewPwd:{} \n sameChar:{} \n sameSpcChar:{} \n ctneNumChar:{} \n ctneChar1:{} \n ctneChar2:{} \n engUpper:{} \n engLower:{} \n numChar:{} \n spcChar:{} \n patternCnt:{} ",sNewPwd, sameChar, sameSpcChar, ctneNumChar, ctneChar1, ctneChar2, engUpper, engLower, numChar, spcChar, patternCnt);
		
		if ( patternCnt < 2 ) {
			rtn.put("status", "FALSE");
			rtn.put("message", "비밀번호로 사용하기에는 적합하지 않습니다.\n\n비밀번호 규칙에 맞지 않습니다.");
			return rtn;
		}
		
		if ( patternCnt == 2 && sNewPwd.length() < 10 ) {
			rtn.put("status", "FALSE");
			rtn.put("message", "비밀번호로 사용하기에는 적합하지 않습니다.\n\n최소 10자리 이상의 비밀번호로 구성되어야 합니다.");
			return rtn;
		}
		
		if ( patternCnt > 2 && sNewPwd.length() < 8 ) {
			rtn.put("status", "FALSE");
			rtn.put("message", "비밀번호로 사용하기에는 적합하지 않습니다.\n\n최소  8자리 이상의 비밀번호로 구성되어야 합니다.");
			return rtn;
		}
		
		if ( sameChar ) {
			rtn.put("status", "FALSE");
			rtn.put("message", "비밀번호로 사용하기에는 적합하지 않습니다.\n\n동일문자[문자,숫자](4회)로 이루어진 비밀번호는 사용할 수 없습니다.");
			return rtn;
		}
		
	
		if ( sameSpcChar ) {
			rtn.put("status", "FALSE");
			rtn.put("message", "비밀번호로 사용하기에는 적합하지 않습니다.\n\n동일문자[특수문자](4회)로 이루어진 비빌번호는 사용할 수 없습니다.");
			return rtn;
		}
		
		if ( ctneNumChar ) {
			rtn.put("status", "FALSE");
			rtn.put("message", "비밀번호로 사용하기에는 적합하지 않습니다.\n\n연속된 숫자(4회)로 이루어진 비밀번호는 사용할 수 없습니다.");
			return rtn;
		}
		
		if ( ctneChar1 ) {
			rtn.put("status", "FALSE");
			rtn.put("message", "비밀번호로 사용하기에는 적합하지 않습니다.\n\n인지하기 쉬운문자(소문자)는 비밀번호로 사용할 수 없습니다.\n(예:asdf, qwer, hjkl등)");
			return rtn;
		}
		
		if ( ctneChar2 ) {
			rtn.put("status", "FALSE");
			rtn.put("message", "비밀번호로 사용하기에는 적합하지 않습니다.\n\n인지하기 쉬운문자(대문자)는 비밀번호로 사용할 수 없습니다.\n(예:ASDF, QWER, HJKL등)");
			return rtn;
		}
		
		
		
		Record r = pwdChgDAO.select(parameter);

		if ("FALSE".equals(r.get("curPwd").toString())) {
			rtn.put("status", "FALSE");
			rtn.put("message", super.messageService
					.getMessage("sc.cmn.pwdChg.curPwdError"));
		}
				
		if ("FALSE".equals(r.get("curPwd").toString())) { 
			rtn.put("status", "FALSE"); 
			rtn.put("message", super.messageService.getMessage("sc.cmn.pwdChg.curPwdError"));
		} else if ( "FALSE".equals(r.get("newPwd").toString()) ) {
			rtn.put("status", "FALSE");
			rtn.put("message", "이전에 사용한 비밀번호는 사용할 수 없습니다.");
		} else if ("TRUE".equals(r.get("curPwd").toString()) && "N".equals(r.get("acctStatus").toString())) {
			rtn.put("status", "FALSE");
			rtn.put("message", "현재 휴직 및 퇴사 상태입니다.");
		} else if ("TRUE".equals(r.get("curPwd").toString())
				&& "TRUE".equals(r.get("newPwd").toString())
				//&& "TRUE".equals(r.get("telNo1").toString()) // 국번제외
				&& "TRUE".equals(r.get("telNo2").toString())
				&& "TRUE".equals(r.get("telNo3").toString())
				&& "TRUE".equals(r.get("telNo").toString())
				&& "TRUE".equals(r.get("hpNo1").toString())
				&& "TRUE".equals(r.get("hpNo2").toString())
				&& "TRUE".equals(r.get("hpNo3").toString())
				&& "TRUE".equals(r.get("hpNo").toString())
				&& "TRUE".equals(r.get("perChk1").toString())) {
			if (pwdChgDAO.update(parameter) > 0) {
				rtn.put("status", "TRUE");
				rtn.put("message",
						super.messageService.getMessage("sc.cmn.pwdChg.ok"));
				rtn.put("sabun", r.getString("sabun"));
			} else {
				rtn.put("status", "FALSE");
				rtn.put("message", "기타 사유로 인하여 비밀번호를 변경할 수 없습니다.\n관리자에게 문의하시기 바랍니다.");
			}
		} else {
			rtn.put("status", "FALSE");
			rtn.put("message", "개인정보(전화번호등)이 포함된 비밀번호는 사용할 수 없습니다.");
		}

		return rtn;
	}
}
