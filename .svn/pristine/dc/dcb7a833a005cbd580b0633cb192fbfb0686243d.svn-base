package com.hwfs.batch.sc.scp;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.StepExecution;
import org.springframework.batch.core.annotation.BeforeStep;
import org.springframework.batch.item.ItemWriter;

import com.hwfs.batch.sc.scp.dao.NonConnDstryNotiDAO;
import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.util.DateUtil;
//import com.hwfs.sc.cmn.dto.SmsDTO;
import com.hwfs.sc.cmn.dto.LmsMmsDTO;
import com.hwfs.sc.cmn.service.LmsMmsSendService;
//import com.hwfs.sc.cmn.service.SmsSendService;
import com.hwfs.sc.scb.service.BatchStepLogService;

 /**
 * 미접속계정 파기주기 건에 대한 파기예정 통보 ItemWriter
 * @ClassName CustomerCreditWriter.java
 * @Description CustomerCreditWriter Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 05. 27.   kksoo        최초생성
 *  2016. 06. 02.    kihoon		 sms->lms
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2014. 12. 24.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class NonConnDstryNotiWriter extends DefaultServiceImpl implements ItemWriter<Map<String,Object>>{
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "/batch/sc/scp/nonConnDstryNotiDAO")
	private NonConnDstryNotiDAO nonConnDstryNotiDAO;

	/** Batch Step Log Service Bean 생성 */
	@Resource(name = "/sc/scb/batchStepLogService")
	private BatchStepLogService batchStepLogService;

	/** SmsSendService Bean 생성 
	@Resource(name = "/sc/cmn/smsSendService")
	private SmsSendService smsSendService;
	*/
	
	@Resource(name = "/sc/cmn/lmsMmsSendService")
	private LmsMmsSendService lmsSendService;
	
	private long stepExecutionId;

	/**
	 * stepExecutioId를 얻는다.
	 *
	 * @param stepExecution
	 */
	@BeforeStep
	public void beforeStep(StepExecution stepExecution) {
	    stepExecutionId = stepExecution.getId();
	}
	
	/**
	 * DB로 Item을 Write
	 * <pre>
	 * - Service 보다는 DAO를 호출하여 DB 처리
	 * </pre>
	 *
	 * @param list
	 * @throws Exception
	 * @see org.springframework.batch.item.ItemWriter#write(java.util.List)
	*/
	@Override
	public void write(List<? extends Map<String,Object>> list) throws Exception {
		
		for (Map<String, Object> map:list) {
			//파기예정 통보건을 개인정보파기이력에 기록
			int cnt = nonConnDstryNotiDAO.insertDstryLog(map);
			if (cnt >0) {
				//사용자정보에 파기상태를 기록
				nonConnDstryNotiDAO.updateUserAcctStatus(map);
				
				String reqDt = nonConnDstryNotiDAO.selectReqDate();
				//SMS 통보 : 배치 트랜잭션 이용하여 처리
				String strMsg = messageService.getMessage("persinfo.destroy.notice.sms", new String[]{(String) map.get("nmKor"), (String) map.get("dstrySchdDate")});
				/**
				SmsDTO smsDTO = new SmsDTO();
				smsDTO.setTrPhone(map.get("hpNo").toString());	//수신자 전화번호
				smsDTO.setTrMsg(strMsg);						//전송 메시지
				
				//송신자번호가 없는 경우는 기본 전화번호로 설정한다. (업무에 따라 설정)
				smsDTO.setTrCallback(propertiesService.getString("ems.sms.callback.no", ""));
				
				//전송할 시간 : 오늘 10시에 전송
				smsDTO.setTrSendDate(DateUtil.getYyyymmdd() + " 1000");
				
				smsDTO.setTrCcId(propertiesService.getString("ems.sms.cmn.send.deptId", "")); 		//공통 업부무서
				smsDTO.setTrUserId(propertiesService.getString("ems.sms.cmn.send.defaultSabun", ""));	//디폴트 사용자
				smsDTO.setTrCustNo("");				//업무에서는 수신자의 사업장코드로 설정한다.
				
				logger.info("파기예정 통보={}", smsDTO.toString());

				if (!smsDTO.getTrPhone().equals("")) {
					smsSendService.saveSmsBatch(smsDTO);

					//처리로그 기록
					batchStepLogService.insertNewTx(stepExecutionId, "nonConnDstryNotiStep", "OK",  smsDTO.toString());
				}else{
					//처리로그 기록
					batchStepLogService.insertNewTx(stepExecutionId, "nonConnDstryNotiStep", "SMS_FAIL",  "수신자 핸드폰번호가 없어 SMS발송불가=" + smsDTO.toString());
				}
				*/
				
				/** LMS로 전환 */
				LmsMmsDTO lmsMmsDTO = new LmsMmsDTO();
				lmsMmsDTO.setPhone(map.get("hpNo").toString());	//수신자 전화번호
				//lmsMmsDTO.setPhone("01026673721");	//수신자 전화번호 for test
				lmsMmsDTO.setMsg(strMsg);						//전송 메시지
				
				//송신자번호가 없는 경우는 기본 전화번호로 설정한다. (업무에 따라 설정)
				lmsMmsDTO.setCallback(propertiesService.getString("ems.sms.callback.no", ""));
				
				//전송할 시간 : 오늘 10시에 전송
				//lmsMmsDTO.setReqDate(DateUtil.getYyyymmdd() + " 1000");
				//lmsMmsDTO.setReqDate(DateUtil.getYyyymmdd() + " 2220");
				lmsMmsDTO.setReqDate(reqDt + "1205");
				
				lmsMmsDTO.setTrCcId(propertiesService.getString("ems.sms.cmn.send.deptId", "")); 		//공통 업부무서
				lmsMmsDTO.setTrUserId(propertiesService.getString("ems.sms.cmn.send.defaultSabun", ""));	//디폴트 사용자
				lmsMmsDTO.setTrCustNo("");				//업무에서는 수신자의 사업장코드로 설정한다.
				
				logger.info("파기예정 통보={}", lmsMmsDTO.toString());

				if (!lmsMmsDTO.getPhone().equals("")) {
					//lmsSendService.saveLmsMms(lmsMmsDTO);
					lmsSendService.saveLmsMmsNewTx(lmsMmsDTO);

					//처리로그 기록
					batchStepLogService.insertNewTx(stepExecutionId, "nonConnDstryNotiStep", "OK",  lmsMmsDTO.toString());
				}else{
					//처리로그 기록
					batchStepLogService.insertNewTx(stepExecutionId, "nonConnDstryNotiStep", "SMS_FAIL",  "수신자 핸드폰번호가 없어 SMS발송불가=" + lmsMmsDTO.toString());
				}
			}
		}
	}
	

}
