package com.hwfs.sc.scd.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.sap.EAIResponse;
import com.hwfs.sc.cmn.sap.dto.BankAcctNoRequestDTO;
import com.hwfs.sc.cmn.sap.list.BankAcctNoRequestList;
import com.hwfs.sc.cmn.sap.request.RestBudgetInqueryRequest;
import com.hwfs.sc.cmn.sap.request.YearBudgetInqueryRequest;
import com.hwfs.sc.cmn.sap.service.EAIService;
import com.hwfs.sc.scd.dao.SapIfPageDAO;

 /**
 * SAP 인터페이스 샘플 가이드를 설명하는 SapIfPage Service Implementation
 * 
 * @ClassName SapIfPageServiceImpl.java
 * @Description SapIfPageServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.11.10    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.11.10
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scd/sapIfPageService")
public class SapIfPageServiceImpl extends DefaultServiceImpl implements SapIfPageService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SapIfPageDAO Bean 생성 */
	@Resource(name = "/sc/scd/sapIfPageDAO")
	private SapIfPageDAO sapIfPageDAO;
	
	@Resource(name = "EAIService")
	EAIService eaiService;
	
	/**
	 * SAP 인터페이스 샘플 목록을 조회한다.
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
	public String runSample(Map<String, Object> mapParam) throws Exception {
		
		//연간예산실적(실시간)
		if ("REAL_TIME_NROW".equals(mapParam.get("ifId").toString())) {
			YearBudgetInqueryRequest request = new YearBudgetInqueryRequest();
			
			//조회조건을 설정하세요.
			request.setInqYy("2015");
			request.setCctrCd("310120");
			request.setIoCd("");
			request.setAcctCd("43215020");
			
			EAIResponse res = eaiService.call(request);
			
			logger.debug("############################################################################");
			logger.debug(" 실시간(Multi Row)");
			logger.debug("############################################################################");
			if (res.isSuccess()) {
				List<Map<String, Object>> list= res.getListMap();
				
				for (int i = 0 ; i < list.size() ; i++) {
					logger.debug("ROW : " + String.valueOf(i) + " / DATA : " + list.get(i).toString());
				}
				
			} else {
				logger.debug(res.getErrorCode() + " / " + res.getErrorMsg());
				if (res.getErrorCode() == -1) {
					logger.debug("조회된 결과가 없습니다.");
				} else {
					throw super.processException("eai.exception");	
				}
			}
			logger.debug("############################################################################");
		}
		//잔여예산실적(실시간)
		else if ("REAL_TIME_1ROW".equals(mapParam.get("ifId").toString())) {
			RestBudgetInqueryRequest request = new RestBudgetInqueryRequest();
			
			//조회조건을 설정하세요.
			request.setCcFg("");
			request.setCctrCd("");
			request.setIoCd("");
			request.setAcctCd("");
			request.setYymmdd("");
			
			EAIResponse res = eaiService.call(request);
			
			logger.debug("############################################################################");
			logger.debug(" 실시간(Single Row)");
			logger.debug("############################################################################");
			if (res.isSuccess()) {
				List<Map<String, Object>> list= res.getListMap();
				
				for (int i = 0 ; i < list.size() ; i++) {
					logger.debug("ROW : " + String.valueOf(i) + " / DATA : " + list.get(i).toString());
				}
			} else {
				logger.debug(res.getErrorCode() + " / " + res.getErrorMsg());
				if (res.getErrorCode() == -1) {
					logger.debug("조회된 결과가 없습니다.");
				} else {
					throw super.processException("eai.exception");	
				}
			}
			logger.debug("############################################################################");
		}
		//매출세부내역(DB전송)
		else if ("DB_SEND".equals(mapParam.get("ifId").toString())) {
			BankAcctNoRequestList bankAcctNoRequestList = new BankAcctNoRequestList();
			//[[유형1 : DB에서 SELECT한 결과(RecordSet)를 바인딩할 경우 - 이 경우에는 SELECT절의 Alias를 DTO와 맞춰준다.(예> setBuCode인 경우에는 SELECT절의 Alias는 BU_CODE이다.)
			//RecordSet rs = dao.selectData();
			//bankAcctNoRequestList.setDataList(rs);
			//유형1 : DB에서 SELECT한 결과(RecordSet을 바인딩할 경우) - 이 경우에는 SELECT절의 Alias를 DTO와 맞춰준다.(예> setBuCode인 경우에는 SELECT절의 Alias는 BU_CODE이다.)]]
			
			//[[유형2 : UI에서 넘어온 DataSetMap 객체를 바인딩할 경우 - 이 경우에는 DataSet의 Column이 DTO와 맞춰준다.(예> setBuCode인 경우에는 DataSet의 Column은 buCode이다.)
			//bankAcctNoRequestList.setDataList(dataSetMap);
			//유형2 : UI에서 넘어온 DataSetMap 객체를 바인딩할 경우 - 이 경우에는 DataSet의 Column이 DTO와 맞춰준다.(예> setBuCode인 경우에는 DataSet의 Column은 buCode이다.)]]
			
			//[[유형3 : DTO 객체에 setter을 이용하여 바인딩할 경우
			List<BankAcctNoRequestDTO> list = new ArrayList<BankAcctNoRequestDTO>();
			BankAcctNoRequestDTO dto1 = new BankAcctNoRequestDTO();
			dto1.setCcCd("123456");
			dto1.setCustCd("1234567"); //SAP에서 관리되는 거래처코드
			dto1.setUpjangCd(BigDecimal.valueOf(123456));
			dto1.setUpjangNm("업장명1");
			
			BankAcctNoRequestDTO dto2 = new BankAcctNoRequestDTO();
			dto2.setCcCd("123456");
			dto2.setCustCd("1234568"); //SAP에서 관리되는 거래처코드
			dto2.setUpjangCd(BigDecimal.valueOf(123457));
			dto2.setUpjangNm("업장명2");

			list.add(dto1);
			list.add(dto2);
			
			bankAcctNoRequestList.setDataList(list);
			
			EAIResponse res = eaiService.call(bankAcctNoRequestList);

			logger.debug("############################################################################");
			logger.debug(" DB전송 예제");
			logger.debug("############################################################################");
			logger.debug("Error Code : " + res.getErrorCode() + " / Error Message : " + res.getErrorMsg());
			if (res.isSuccess()) {
				logger.debug("※※※※※※※※※※ 성공에 대한 처리 ※※※※※※※※※※");
			}
			else {
				logger.debug("※※※※※※※※※※ 실패에 대한 처리 ※※※※※※※※※※");
			}
			logger.debug("############################################################################");
			//유형3 : DTO 객체에 setter을 이용하여 바인딩할 경우]]
		}
		
		return ""; //sapIfPageDAO.selectList(mapParam);
	}
}
