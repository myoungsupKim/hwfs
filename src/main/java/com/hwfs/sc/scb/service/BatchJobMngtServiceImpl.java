package com.hwfs.sc.scb.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.NoSuchBeanDefinitionException;
import org.springframework.beans.factory.config.AutowireCapableBeanFactory;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.support.BeanDefinitionRegistry;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.scb.dao.BatchJobMngtDAO;
import com.hwfs.sc.scb.dto.JobExecDTO;
import com.hwfs.sc.scb.dto.JobInfoDTO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * Job Repository에 작성된 Job Configuration을 DB에 등록 관리하고 온라인 Job을 실행시키는 BatchJobMngt Service Implementation
 * (주의) HWFS CMN Batch Framework에서 사용하는 updateOnlineExecJobInfo 메소드를 구현해야 한다.
 * 
 * @ClassName BatchJobMngtServiceImpl.java
 * @Description BatchJobMngtServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.08    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.04.08
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scb/batchJobMngtService")
public class BatchJobMngtServiceImpl extends DefaultServiceImpl implements BatchJobMngtService, ApplicationContextAware {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** BatchJobMngtDAO Bean 생성 */
	@Resource(name = "/sc/scb/batchJobMngtDAO")
	private BatchJobMngtDAO batchJobMngtDAO;
	
	/** ApplicationContext : 서비스의 ApplicationContext는 동일하므로 singleton 객체에서도 문제없음*/
	private ApplicationContext appContext;
	
	/**
	 * ApplicationContextAware 구현에 필요한 함수로 ApplicationContext를 설정한다.
	 * <pre>
	 * -Job bean의 정보를 얻기 위해 필요
	 * </pre>
	 *
	 * @param appContext
	 * @throws BeansException
	 * @see org.springframework.context.ApplicationContextAware#setApplicationContext(org.springframework.context.ApplicationContext)
	 */
	public void setApplicationContext(ApplicationContext appContext) throws BeansException {
		this.appContext = appContext;
	}
	
	/**
	 * Job Repository에 저장된 Job Configuration 파일에서 설명을 얻는다.
	 * <pre>
	 * - Job Configuration 파일에 <description>이 설정되어 있어야 한다.
	 * </pre>
	 *
	 * @param jobName Job Configuration 파일에 설정된 job id
	 * @return Job Description
	 */
	public String getJobDefinition (String jobName) {
		try {
			AutowireCapableBeanFactory beanFactory = appContext.getAutowireCapableBeanFactory();
			BeanDefinition beanDefinition = ((BeanDefinitionRegistry) beanFactory).getBeanDefinition(jobName);
			return beanDefinition.getDescription();
		}catch (NoSuchBeanDefinitionException e) {
			logger.error ("error at getJobDefinition:{}", e.getMessage());
			return "";
		}catch (Exception e){
			logger.error ("error at getJobDefinition:{}", e.getMessage());
			return "";
		}
	}

	/**
	 * Job Repository와 DB에 현재 등록된 Job 정보 목록을 조회한다.
	 * <pre>
	 * - Job Repository에 저장된 Job Configuration 파일과 DB에 등록된 Job 정보를 비교하여 생성한다.
	 * - ynRgst에 DB에 등록된 Job인지 여부를 설정한다. ("1"인 경우는 DB에 등록된 Job)
	 * </pre>
	 *
	 * @param jobList
	 *            Job Repository에 저장된 Job 목록
	 * @param mapParam
	 *            조회조건 Map
	 * @return List<JobInfoDTO> 
	 *            조회결과
	 * @throws Exception
	 */
	public List<JobInfoDTO> selectJobInfoList (Set<String> jobList, Map <String, Object> mapParam) throws Exception {
		// 현재 등록된 Job정보를 얻는다.
		List<JobInfoDTO> jobInfoList = batchJobMngtDAO.selectJobInfoList(mapParam);
		
		//Job 찾기를 용이하도록 Map을 생성
		Map<String, String> jobNameMap = new HashMap<String,String>();
		for (JobInfoDTO jobInfo : jobInfoList) {
			jobNameMap.put(jobInfo.getJobName(), jobInfo.getJobDesc());
		}
		
		//DB에 등록된 Job 인지 여부를 검사하여 처리
		String searchName = mapParam.get("jobName") != null ? mapParam.get("jobName").toString().trim() : "";
		for (String jobName : jobList) {
			//jobName 조회조건이 있는 경우 조건에 맞는지 검사
			if (!searchName.equals("") && jobName.indexOf(searchName) == -1) continue;
			
			//등록되지 않은 Job에 등록을 위한 정보를 설정한다.
			if (!jobNameMap.containsKey(jobName)) {
				JobInfoDTO jobInfoDTO = new JobInfoDTO();
				jobInfoDTO.setJobName(jobName);
				jobInfoDTO.setJobDesc(getJobDefinition(jobName));
				jobInfoDTO.setYnRgst("0");	//DB에 등록되지 않은 Job
				jobInfoList.add(jobInfoDTO);
			}
		}
		
		return jobInfoList;
	}

	/**
	 * DB에 등록된 Job 정보 목록을 조회한다.
	 *
	 * @param jobList
	 *            DB에 저장된 Job 목록
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectDbJobList (Map<String, Object> mapParam) throws Exception {
		return batchJobMngtDAO.selectDbJobList (mapParam);
	}

	/**
	 * Job 정보 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveJobList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += batchJobMngtDAO.insertJob(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += batchJobMngtDAO.updateJob(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += batchJobMngtDAO.deleteJob(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * Online Batch Job 실행 정보를 Update 처리한다.
	 * <pre>
	 * - HWFS CMN Batch Framework에서 사용하는 메소드로 이를 구현해야 한다.
	 * </pre>
	 * 
	 * @param jobExecDTO
	 *            JobExecVO Job 실행정보DTO
	 * @return int 처리건수
	 * @throws Exception
	 */
	public int updateOnlineExecJobInfo(JobExecDTO jobExecDTO) throws Exception {
		int intCnt = 0;
		intCnt += batchJobMngtDAO.updateOnlineExecJobInfo(jobExecDTO);

		return intCnt;
	}
	
	/**
	 * 허브메카 주문수동배치 정보를 클리어한다.
	 *
	 * @param parameter
	 * @return int
	 */
	public int updateHubInterfaceManual(Map<String, Object> parameter) throws Exception{
		return batchJobMngtDAO.updateHubInterfaceManual (parameter);
	}
	
	
	/**
	 * 허브메카 주문수동배치 정보를 update 한다.
	 *
	 * @param parameter
	 * @return int
	 */
	public int saveHubInterfaceManual(Map<String, Object> parameter) throws Exception{
		return batchJobMngtDAO.saveHubInterfaceManual (parameter);
	}
	
	/**
	 * 허브메카 단가수동배치 정보를 클리어한다.
	 *
	 * @param parameter
	 * @return int
	 */
	public int updateHubInterfaceManual2(Map<String, Object> parameter) throws Exception{
		return batchJobMngtDAO.updateHubInterfaceManual2 (parameter);
	}
	
	
	/**
	 * 허브메카 단가수동배치 정보를 update 한다.
	 *
	 * @param parameter
	 * @return int
	 */
	public int saveHubInterfaceManual2(Map<String, Object> parameter) throws Exception{
		return batchJobMngtDAO.saveHubInterfaceManual2 (parameter);
	}

}
