package com.hwfs.sc.cmn.service;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultQuartzJobBean;
import com.hwfs.cmn.service.ScheduleService;

 /**
 * GetPriceInfoSchdJob에 대한 설명 작성
 * @ClassName GetPriceInfoSchdJob.java
 * @Description GetPriceInfoSchdJob Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018.05.29.   kihoon        최초생성
 * </pre>
 * @author FC종합전산구축 : kihoon
 * @since 2018.05.29.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class GetPriceInfoSchdJob extends DefaultQuartzJobBean {
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
        GetPriceInfoService getPriceInfoService;

        try {
            scheduleService = (ScheduleService)context.getJobDetail().getJobDataMap().get("scheduleService");
            getPriceInfoService = (GetPriceInfoService)context.getJobDetail().getJobDataMap().get("getPriceInfoService");
            //스케쥴러가 실행가능한지 검사
            if(scheduleService.isScheduleExcute(execServer)){
            	logger.info ("****Quartz Scheduler {} executes...", name);
            	getPriceInfoService.getPriceInfo();
            }
        } catch (Exception e) {
        	logger.error(String.format("Quartz Scheduler %s could not execute!", name), e);
        } finally {
            scheduleService = null;
            getPriceInfoService = null;
        }
        logger.info ("****Quartz Scheduler {} is ended!", name);
        isRunning = false;	//실행상태 설정 해제
    }
}
