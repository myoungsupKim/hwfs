package com.hwfs.sc.scb.dao;

import hone.core.util.record.RecordSet;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;
import com.hwfs.sc.scb.dto.JobExecDTO;
import com.hwfs.sc.scb.dto.JobInfoDTO;

 /**
 * Job Repository에 작성된 Job Configuration을 DB에 등록 관리하고 온라인 Job을 실행시키는 BatchJobMngt DAO
 * (주의) HWFS CMN Batch Framework에서 사용하는 updateOnlineExecJobInfo 메소드를 구현해야 한다.
 * 
 * @ClassName BatchJobMngtDAO.java
 * @Description BatchJobMngtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.08   	kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.04.08
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scb/batchJobMngtDAO")
public class BatchJobMngtDAO extends DefaultDAO {
	
	/**
	 * 현재 등록된 배치 Job 정보목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회할 정보가 담긴 Map
	 * @return List<JobInfoDTO> 
	 *            배치 Job 정보목록
	 */
	@SuppressWarnings("unchecked")
	public List<JobInfoDTO> selectJobInfoList(Map<String, Object> mapParam) throws Exception {
		return (List<JobInfoDTO>)queryForList ("sc.scb.batchJobMngtDAO.selectJobInfoList", mapParam, JobInfoDTO.class);
	}

	/**
	 * 현재 등록된 배치 Job 정보목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회할 정보가 담긴 Map
	 * @return RecordSet 
	 *            배치 Job 정보목록
	 */
	public RecordSet selectDbJobList(Map<String, Object> mapParam) throws Exception {
		return queryForRecordSet ("sc.scb.batchJobMngtDAO.selectDbJobList", mapParam);
	}

	/**
	 * Job 정보(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertJob(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scb.batchJobMngtDAO.insertJob", mapParam);
	}
	
	/**
	 * Job 정보(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateJob(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scb.batchJobMngtDAO.updateJob", mapParam);
	}
	
	/**
	 * Job 정보(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteJob(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scb.batchJobMngtDAO.deleteJob", mapParam);
	}
	
	/**
	 * 배치 Job 정보를 수정한다.
	 * <pre>
	 * - HWFS CMN Batch Framework에서 사용하는 메소드로 이를 구현해야 한다.
	 * </pre>
	 * 
	 * @param jobExecDTO
	 *            JobExecVO Job 실행정보DTO
	 * @return int 1=성공, 0=실패
	 * @exception Exception
	 */
	public int updateOnlineExecJobInfo(JobExecDTO jobExecDTO) throws Exception {
		return update("sc.scb.batchJobMngtDAO.updateOnlineExecJobInfo", jobExecDTO);
	}

}
