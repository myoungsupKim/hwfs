package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;


 /**

 * 
 * @ClassName HubPriceInterfaceDAO.java
 * @Description HubPriceInterfaceDAO Class
 * @Modification-Information
 * <pre>
 *    수정일            수정자                 수정내용
 *  ----------   ----------   -------------------------------
 *  2022.07.19   hye.ji94    최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.04.08
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/hubPriceInterfaceDAO")
public class HubPriceInterfaceDAO extends DefaultDAO {
	

	/**
	 * 현재 등록된 User ID 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회할 정보가 담긴 Map
	 * @return RecordSet 
	 *            배치 Job 정보목록
	 */
	public RecordSet selectPriceUpjang(Map<String, Object> mapParam) throws Exception {
		return queryForRecordSet ("fm.fms.hubPriceInterfaceDAO.selectPriceUpjang", mapParam);
	}
	
	/**
	 * User DATA를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectHubInterface(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.hubPriceInterfaceDAO.selectHubInterface", mapParam);
	}

	/**
	 * User DATA를 추가한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertHubInterface(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.hubPriceInterfaceDAO.insertHubInterface", mapParam);
	}
	
	/**
	 * User DATA를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateHubInterface(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.hubPriceInterfaceDAO.updateHubInterface", mapParam);
	}
	
	/**
	 * User DATA를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteHubInterface(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.hubPriceInterfaceDAO.deleteHubInterface", mapParam);
	}
	
	/**
	 * 수동배치정보를 클리어한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateHubInterfaceManual(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.hubPriceInterfaceDAO.updateHubInterfaceManual", mapParam);
	}
	
	/**
	 * 수동배치정보를 저장한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int saveHubInterfaceManual(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.hubPriceInterfaceDAO.saveHubInterfaceManual", mapParam);
	}
	
	
	/**
	 * 허브메카 수동배치 실행권한을 조회한다.
	 * 추가일자:20220711  처리자:김혜진  
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectBatchAuth(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.hubPriceInterfaceDAO.selectBatchAuth", mapParam);
	}
}
