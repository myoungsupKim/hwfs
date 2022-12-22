package com.hwfs.batch.sc.cmn;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.hwfs.cmn.exception.BizException;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.cmn.service.GetSaleInfoService;
import com.hwfs.sc.scb.service.BatchStepLogService;
import com.hwfs.sc.cmn.dao.GetSaleInfoDAO;

 /**
 * CmmGetSaleInfoTasklet에 대한 설명 작성
 * @ClassName CmmGetSaleInfoTasklet.java
 * @Description CmmGetSaleInfoTasklet Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2019.11.12.   hoseok        최초생성
 * </pre>
 * @author FC종합전산구축 : kihoon
 * @since 2018.05.29.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class CmmGetSaleInfoTasklet implements Tasklet {
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	/** Batch Step Log Service Bean 생성 */
    @Resource(name = "/sc/scb/batchStepLogService")
    private BatchStepLogService batchStepLogService;
    
    /** getSaleInfoSerivce Bean 생성 */
  	@Resource(name = "/sc/cmn/getSaleInfoService")
  	private GetSaleInfoService getSaleInfoSerivce;

	/** GetSaleInfoDAO Bean 생성 */
	@Resource(name = "/sc/cmn/getSaleInfoDAO")
	private GetSaleInfoDAO getSaleInfoDAO;

	/**
	 * execute 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param arg0
	 * @param arg1
	 * @return
	 * @throws Exception
	 * @see org.springframework.batch.core.step.tasklet.Tasklet#execute(org.springframework.batch.core.StepContribution, org.springframework.batch.core.scope.context.ChunkContext)
	*/
	@Override
	public RepeatStatus execute(StepContribution arg0, ChunkContext arg1)
			throws Exception {
    	 long stepExecutionId = arg1.getStepContext().getStepExecution().getId();

		Map<String, Object> param = new HashMap<String, Object>();

        Map<String, Object> retProcVal = new HashMap<String, Object>();

		//매출데이타 수신
		int rtn = getSaleInfoSerivce.GetSaleInfo();
		
		//매출 테이블 생성
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Calendar c0 = Calendar.getInstance(); 
		String tday = sdf.format(c0.getTime()); // String으로 저장 
		c0.add(Calendar.DATE, -1); // 오늘날짜로부터 -1  
		String yday = sdf.format(c0.getTime()); // String으로 저장  
        System.out.println("P_OCCUR_DATE : "+ tday);
		
		Map<String, Object> procParam = new HashMap<String, Object>();      
        procParam.put("P_OCCUR_DATE", tday);
        //procParam.put("PI_SABUN", "SYSTEM");
        //procParam.put("P_USER", "SYSTEM-BT");
      
        retProcVal = getSaleInfoDAO.salePro(procParam);
		
        // 로그를 쌓는다.
        String strRtnMsg = "";
        System.out.println("retProcVal : "+ retProcVal);
        System.out.println("O_RTN : "+ LimsUtil.checkNull(retProcVal.get("O_RTN")));
                
        if (!LimsUtil.checkNull(retProcVal.get("O_RTN")).equals("TRUE")) {
            strRtnMsg = LimsUtil.checkNull(retProcVal.get("O_RTNMSG"));
            batchStepLogService.insertNewTx(stepExecutionId, "CmmGetSaleInfo", "FAILED", strRtnMsg);

            arg0.setExitStatus(ExitStatus.FAILED);		//FAILED로 상태 설정
            // Rollback 처리 위해서 Exception 발생
            throw new BizException (strRtnMsg);
        }
        
        strRtnMsg = LimsUtil.checkNull("정상적으로 처리 되었습니다.");
        batchStepLogService.insertNewTx(stepExecutionId, "CmmGetSaleInfo", "OK", strRtnMsg);
		return RepeatStatus.FINISHED;
	}
}
