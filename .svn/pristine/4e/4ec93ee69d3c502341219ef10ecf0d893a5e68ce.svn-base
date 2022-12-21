package com.hwfs.sc.scp.service;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.hwfs.cmn.defaults.DefaultQuartzJobBean;
import com.hwfs.cmn.service.ScheduleService;

/**
 * 개인정보파기요청이 결재승인이 난 경우 개인정보파기이력 테이블에 등록하는 Scheduler Job Class
 * @ClassName PersDstryReqLogInsSchdJob.java
 * @Description PersDstryReqLogInsSchdJob Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.22.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.05.22.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class PersDstryReqLogInsSchdJob  extends DefaultQuartzJobBean {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** 이중실행방지를 위한 상태 플래그 */
	protected static boolean isRunning = false;

	/**
	 * JobDetailBean에서 Job을 실행시킨다.
	 * @param JobExecutionContext context
	 * @throws JobExecutionException
	 */
    @Override
    protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
    	//현재 실행되고 있는지 검사
    	if (isRunning) {
    		logger.info("****Quartz Scheduler {} is already running!", name);
    		return;
    	}
    	
    	isRunning = true;	//실행상태 설정
    	logger.info("****Quartz Scheduler {} is started!", name);
        ScheduleService scheduleService;
        PersDstryReqService persDstryReqService;

        try {
            scheduleService = (ScheduleService)context.getJobDetail().getJobDataMap().get("scheduleService");
            persDstryReqService = (PersDstryReqService)context.getJobDetail().getJobDataMap().get("persDstryReqLogInsService");
            //스케쥴러가 실행가능한지 검사
            if(scheduleService.isScheduleExcute(execServer)){
                int cnt = persDstryReqService.insertPersDstryReqLog();
            	logger.info ("****Quartz Scheduler {} executes... personal destroy request log insertion count={}", name, cnt);
            }
        } catch (Exception e) {
        	logger.error(String.format("Quartz Scheduler %s could not execute!", name), e);
        } finally {
            scheduleService = null;
            persDstryReqService = null;
        }
        logger.info ("****Quartz Scheduler {} is ended!", name);
        isRunning = false;	//실행상태 설정 해제
    }

}
