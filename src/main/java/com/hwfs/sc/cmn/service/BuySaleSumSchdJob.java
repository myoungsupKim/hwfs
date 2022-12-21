package com.hwfs.sc.cmn.service;

import java.util.HashMap;
import java.util.Map;

import com.hwfs.cmn.defaults.DefaultQuartzJobBean;
import com.hwfs.cmn.service.ScheduleService;
import com.hwfs.batch.fm.fms.dao.FmsBuySaleSumDAO;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 매입매출집계 월마감 후 집계 프로시져 호출 Scheduler Job Class
 * @ClassName CmmSpFmsBuySaleSumSchdJob.java
 * @Description CmmSpFmsBuySaleSumSchdJob Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018.05.23.   kihoon        최초생성
 * </pre>
 * @author FC종합전산구축 : kihoon
 * @since 2018.05.23.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class BuySaleSumSchdJob  extends DefaultQuartzJobBean {

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
        FmsBuySaleSumDAO fmsBuySaleSumDAO;
        
        Map<String, Object> retProcVal = new HashMap<String, Object>();
        
        try {
            scheduleService = (ScheduleService)context.getJobDetail().getJobDataMap().get("scheduleService");
            fmsBuySaleSumDAO = (FmsBuySaleSumDAO)context.getJobDetail().getJobDataMap().get("buySaleSumService");
            //스케쥴러가 실행가능한지 검사
            if(scheduleService.isScheduleExcute(execServer)){
            	logger.info ("****Quartz Scheduler {} executes...", name);
            	Map<String, Object> parameter = new HashMap<String, Object>();
            	retProcVal = fmsBuySaleSumDAO.callCheckExcute(parameter);
            	
            }
        } catch (Exception e) {
        	logger.error(String.format("Quartz Scheduler %s could not execute!", name), e);
        } finally {
            scheduleService = null;
            fmsBuySaleSumDAO = null;
        }
        logger.info ("****Quartz Scheduler {} is ended!", name);
        isRunning = false;	//실행상태 설정 해제
    }

}
