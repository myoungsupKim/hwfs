package com.hwfs.sc.scb.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.quartz.CronTrigger;
import org.quartz.JobDataMap;
import org.quartz.SimpleTrigger;
import org.quartz.impl.StdScheduler;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.util.DateUtil;
import com.hwfs.sc.scb.dao.BatchJobMngtDAO;
import com.hwfs.sc.scb.dto.JobInfoDTO;
import com.hwfs.sc.scb.dto.SchdInfoDTO;

 /**
 * Batch Job Repository에 등록된 Batch Job Scheduler 정보를 관리하는 BatchSchdMngt Service Implementation
 * -CronTrigger 정보만 관리한다.
 * 
 * @ClassName BatchSchdMngtServiceImpl.java
 * @Description BatchSchdMngtServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.09    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.04.09
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scb/batchSchdMngtService")
public class BatchSchdMngtServiceImpl extends DefaultServiceImpl implements BatchSchdMngtService {
	
	/** BatchSchedulerFactory */
	@Resource(name = "batchSchedulerFactory")
	protected StdScheduler batchSchedulerFactory;

	/** NonBatchSchedulerFactory */
	@Resource(name = "schedulerFactory")
	protected StdScheduler schedulerFactory;

//	/** BatchSchdMngtDAO Bean 생성 */
//	@Resource(name = "/sc/scb/batchSchdMngtDAO")
//	private BatchSchdMngtDAO batchSchdMngtDAO;
	
	/** BatchJobMngtDAO Bean 생성 */
	@Resource(name = "/sc/scb/batchJobMngtDAO")
	private BatchJobMngtDAO batchJobMngtDAO;


	/**
	 * Job Repository 등록된 Batch Schedule 정보를 얻는다.
	 * <pre>
	 * - Job Repository에 저장된 Batch Scheduler Configuration 파일 정보를 이용하여 생성한다.
	 * - resources/batch/context-batch-scheduler.xml
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return List<SchdInfoDTO> 
	 *            조회결과
	 * @throws Exception
	 */
	public List<SchdInfoDTO> selectList(Map<String, Object> mapParam) throws Exception {
		// 현재 DB에 등록된 Job정보를 얻는다. 조회 조건에 해당하는 Job인지를 비교하기 위해 필요
		List<JobInfoDTO> jobInfoList = batchJobMngtDAO.selectJobInfoList(mapParam);
		
		// 현재 등록된 Job Scheduler 정보를 얻는다. Job이 조회 조건인 어떤 시스템에 속하는지 비교하여 처리한다.
		List<SchdInfoDTO> schdInfoList = new ArrayList<SchdInfoDTO>();
		
		String[] arrJobGroups = batchSchedulerFactory.getJobGroupNames();
		String[] arrTriggerGroups = batchSchedulerFactory.getTriggerGroupNames();
		for (int i=0; i<arrTriggerGroups.length; i++) {
			String[] arrTriggerNames = batchSchedulerFactory.getTriggerNames(arrTriggerGroups[i]);
			for (int j=0; j<arrTriggerNames.length; j++) {
				CronTrigger cronTrigger = (CronTrigger)batchSchedulerFactory.getTrigger(arrTriggerNames[j], arrTriggerGroups[i]);				
				JobDataMap jobDataMap = batchSchedulerFactory.getJobDetail(cronTrigger.getJobName(), arrJobGroups[0]).getJobDataMap();
				
				//조회 조건에 속한 Job인지 확인
				JobInfoDTO jobInfoDTO = findJobInfo(mapParam, (String)jobDataMap.getWrappedMap().get("jobName"), jobInfoList);
				if (jobInfoDTO == null ) continue;
				
				//스케쥴정보 DTO에 설정
				SchdInfoDTO schdInfoDTO = new SchdInfoDTO();
				schdInfoDTO.setSchdName(cronTrigger.getName());
				schdInfoDTO.setJobGroup(cronTrigger.getJobGroup());
				schdInfoDTO.setJobName((String)jobDataMap.getWrappedMap().get("jobName"));
				schdInfoDTO.setSchdDesc(cronTrigger.getDescription());
				schdInfoDTO.setCronExpression(cronTrigger.getCronExpression());
				schdInfoDTO.setExecServer((String)jobDataMap.getWrappedMap().get("execServer"));
				schdInfoDTO.setExecContainer((String)jobDataMap.getWrappedMap().get("execContainer"));
				schdInfoDTO.setSysType(jobInfoDTO.getSysType());
				schdInfoDTO.setSysId(jobInfoDTO.getSysId());

				schdInfoList.add(schdInfoDTO);
			}
		}

		return schdInfoList;
	}

	/**
	 * Job Repository 등록된 NonBatch Schedule 정보를 얻는다.
	 * <pre>
	 * - NonBatch Scheduler Configuration 파일 정보를 이용하여 생성한다.
	 * - WEB-INF/config/framework/service/hone_scheduler.xml
	 * </pre>
	 * 
	 * @return List<SchdInfoDTO> 
	 *            조회결과
	 * @throws Exception
	 */
	public List<SchdInfoDTO> selectNonBatchSchedulerList() throws Exception {
		// 현재 등록된 Job Scheduler 정보를 얻는다. Job이 조회 조건인 어떤 시스템에 속하는지 비교하여 처리한다.
		List<SchdInfoDTO> schdInfoList = new ArrayList<SchdInfoDTO>();
		
		String[] arrJobGroups = schedulerFactory.getJobGroupNames();
		String[] arrTriggerGroups = schedulerFactory.getTriggerGroupNames();
		for (int i=0; i<arrTriggerGroups.length; i++) {
			String[] arrTriggerNames = schedulerFactory.getTriggerNames(arrTriggerGroups[i]);
			for (int j=0; j<arrTriggerNames.length; j++) {
				//CronTrigger
				if (schedulerFactory.getTrigger(arrTriggerNames[j], arrTriggerGroups[i]) instanceof CronTrigger) {
					CronTrigger cronTrigger = (CronTrigger)schedulerFactory.getTrigger(arrTriggerNames[j], arrTriggerGroups[i]);
					JobDataMap jobDataMap = schedulerFactory.getJobDetail(cronTrigger.getJobName(), arrJobGroups[0]).getJobDataMap();

					//스케쥴정보 DTO에 설정
					SchdInfoDTO schdInfoDTO = new SchdInfoDTO();
					schdInfoDTO.setSchdName(cronTrigger.getName());
					schdInfoDTO.setJobGroup(cronTrigger.getJobGroup());
					schdInfoDTO.setJobName((String)jobDataMap.getWrappedMap().get("name"));
					schdInfoDTO.setSchdDesc(cronTrigger.getDescription());
					schdInfoDTO.setCronExpression(cronTrigger.getCronExpression());
					schdInfoDTO.setExecServer((String)jobDataMap.getWrappedMap().get("execServer"));
					schdInfoDTO.setExecContainer((String)jobDataMap.getWrappedMap().get("execContainer"));
					schdInfoDTO.setTriggerType("CronTrigger");
					
					schdInfoList.add(schdInfoDTO);
				}
				//SimpleTrigger
				else if (schedulerFactory.getTrigger(arrTriggerNames[j], arrTriggerGroups[i]) instanceof SimpleTrigger) {
					SimpleTrigger simpleTrigger = (SimpleTrigger)schedulerFactory.getTrigger(arrTriggerNames[j], arrTriggerGroups[i]);
					JobDataMap jobDataMap = schedulerFactory.getJobDetail(simpleTrigger.getJobName(), arrJobGroups[0]).getJobDataMap();
					
					//스케쥴정보 DTO에 설정
					SchdInfoDTO schdInfoDTO = new SchdInfoDTO();
					schdInfoDTO.setSchdName(simpleTrigger.getName());
					schdInfoDTO.setJobGroup(simpleTrigger.getJobGroup());
					schdInfoDTO.setJobName((String)jobDataMap.getWrappedMap().get("name"));
					schdInfoDTO.setSchdDesc(simpleTrigger.getDescription());
					schdInfoDTO.setCronExpression(DateUtil.getYyyymmddhhmmss(simpleTrigger.getStartTime()) + ", Repeat Interval=" + simpleTrigger.getRepeatInterval());
					schdInfoDTO.setExecServer((String)jobDataMap.getWrappedMap().get("execServer"));
					schdInfoDTO.setExecContainer((String)jobDataMap.getWrappedMap().get("execContainer"));
					schdInfoDTO.setTriggerType("SimpleTrigger");
					
					schdInfoList.add(schdInfoDTO);
				}
			}
		}

		return schdInfoList;
	}

	/**
	 * 특정 스케쥴 잡이 조회 조건에 속한 Job인지 확인
	 * <pre>
	 * - 스케쥴 Job은 시스템 구분과같은 조회 조건 정보가 없으므로 DB에 등록된 Job과 비교하여 조회 조건에 속한 것인지 확인
	 * </pre>
	 *
	 * @param mapParam 조회조건 Map
	 * @param jobName 스케쥴 Job 명
	 * @param jobInfoList DB에 등록된 Job 목록
	 * @return
	 */
	private JobInfoDTO findJobInfo (Map<String, Object> mapParam, String jobName, List<JobInfoDTO> jobInfoList) {
		//조회 조건
		String sysType = mapParam.get("sysType").toString();
		String sysId   = mapParam.get("sysId").toString();
		
		//조회 조건에 속한 Job인지 검사
		for (JobInfoDTO jobInfoDTO : jobInfoList) {
			if (jobInfoDTO.getJobName().equals(jobName)) {
				if (sysType.equals(""))
					return jobInfoDTO;
				else if (jobInfoDTO.getSysType().equals(sysType) && (sysId.equals("") || jobInfoDTO.getSysId().equals(sysId)))
					return jobInfoDTO;
				else 
					return null;
			}
		}
		return null;
	}
	
//	/**
//	 * Batch Job Scheduler 정보 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
//	 * <pre>
//	 * - 메소드 상세설명 작성(생략 가능)
//	 * </pre>
//	 *
//	 * @param list
//	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
//	 * @return 처리건수
//	 * @throws Exception
//	*/
//	@SuppressWarnings("unchecked")
//	public int saveList(DataSetMap list) throws Exception {
//		int insRowCnt = 0;
//		int updRowCnt = 0;
//		int delRowCnt = 0;
//		
//		for (int i = 0 ; i < list.size() ; i++) {
//			Map<String, Object> rowData = list.get(i);
//			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
//			
//			//Insert 처리
//			if (rowType == DataSet.ROW_TYPE_INSERTED) {
//				insRowCnt += batchSchdMngtDAO.insert(rowData);
//			}
//			//Update 처리
//			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
//				updRowCnt += batchSchdMngtDAO.update(rowData);
//			}
//			//Delete 처리.
//			else if (rowType == DataSet.ROW_TYPE_DELETED) {
//				delRowCnt += batchSchdMngtDAO.delete(rowData);
//			}
//		}
//				
//		return insRowCnt + updRowCnt + delRowCnt;
//	}
//	
//	/**
//	 * 배치 스케쥴 Job을 DB로 관리하는 경우 초기 스케쥴 정보를 DB로 부터 읽어 초기 설정한다.
//	 * <pre>
//	 * - LoadCacheServiceImpl.initApplication에서 호출
//	 * </pre>
//	 *
//	 * @throws Exception
//	*/
//	public void initBatchScheduleInfo() throws Exception {
//		String[] arrJobGroups = batchSchedulerFactory.getJobGroupNames();
//		String[] arrTriggerGroups = batchSchedulerFactory.getTriggerGroupNames();
//		for (int i=0; i<arrTriggerGroups.length; i++) {
//			String[] arrTriggerNames = batchSchedulerFactory.getTriggerNames(arrTriggerGroups[i]);
//			for (int j=0; j<arrTriggerNames.length; j++) {
//				CronTrigger cronTrigger = (CronTrigger)batchSchedulerFactory.getTrigger(arrTriggerNames[j], arrTriggerGroups[i]);				
//				JobDataMap jobDataMap = batchSchedulerFactory.getJobDetail(cronTrigger.getJobName(), arrJobGroups[0]).getJobDataMap();
//				
//				logger.debug("schdName={}, jobGroup={}, jobName={}, schdDesc={}, cronExpression={}, execServer={}, execContainer={}", 
//						cronTrigger.getName(), 
//						cronTrigger.getJobGroup(), 
//						(String)jobDataMap.getWrappedMap().get("jobName"), 
//						cronTrigger.getDescription(),
//						cronTrigger.getCronExpression(),
//						(String)jobDataMap.getWrappedMap().get("execServer"),
//						(String)jobDataMap.getWrappedMap().get("execContainer"));
//			}
//		}
//	}

}
