package com.hwfs.batch.sc.cmn;

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

import com.hwfs.sc.cmn.service.ResizeImageFileService;
import com.hwfs.sc.scb.service.BatchStepLogService;

 /**
 * CmmMakeCreditExcelFileTasklet에 대한 설명 작성
 * @ClassName CmmMakeCreditExcelFileTasklet.java
 * @Description CmmMakeCreditExcelFileTasklet Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016. 12. 5.   901X5L        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 901X5L
 * @since 2016. 12. 5.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class CmmResizeImageFileTasklet implements Tasklet {
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	/** Batch Step Log Service Bean 생성 */
    @Resource(name = "/sc/scb/batchStepLogService")
    private BatchStepLogService batchStepLogService;
    
    /** MakeCreditExcelFileService Bean 생성 */
  	@Resource(name = "/sc/cmn/resizeImageFileService")
  	private ResizeImageFileService resizeImageFileService;

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
		Map<String, Object> param = new HashMap<String, Object>();

		int rtn = resizeImageFileService.resizeImageFile();
		
		return RepeatStatus.FINISHED;
	}
}
