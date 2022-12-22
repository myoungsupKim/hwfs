package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 허브메카 Stop자재 설정하는 hubInterfaceStopItem DAO
 * 
 * @ClassName hubInterfaceStopItemDAO.java
 * @Description hubInterfaceStopItemDAO Class
 * @Modification-Information
 * <pre>
 *    수정일         수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.07.08  김혜진       
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.04.14
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/hubInterfaceStopItemDAO")
public class HubInterfaceStopItemDAO extends DefaultDAO {
	

	/**
	 * 허브메카 stop자재 목록을 조회한다.(단가개시일 기준 조회)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.hubInterfaceStopItemDAO.selectList", mapParam);
	}

	
	
	/**
	 * 허브메카 stop자재 사용유무 업데이트
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.hubInterfaceStopItemDAO.update", mapParam);
	}
	
	
	/**
	 * 허브메카 stop자재 등록용 자재정보를 조회한다.(단가개시일 기준 조회)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectItem(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.hubInterfaceStopItemDAO.selectItem", mapParam);
	}


	/**
	 * 허브메카 엑셀 업로드 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public List<Map>  selectExcel(Map<String, Object> mapParam) throws Exception {
		return super.queryForList("fm.fms.hubInterfaceStopItemDAO.selectExcel", mapParam);
	}
	

	/**
	 * 허브메카 엑셀 업로드 temp 데이터를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int tempDelete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.hubInterfaceStopItemDAO.tempDelete", mapParam);
	}
	
	/**
	 * 허브메카 엑셀 업로드 데이터를 임시 테이블에 저장한다.
	 * 
	 * @param mapParam
	 * @return
	 */
	public int[] tempInsert(List<Map> listParam) throws Exception {
		return super.batchUpdate("fm.fms.hubInterfaceStopItemDAO.tempInsert", listParam);
	}
	
	/**
	 * 허브메카 stop자재를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectStopItem(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.hubInterfaceStopItemDAO.selectStopItem", mapParam);
	}
	
	/**
	 * 허브메카 stop자재 일괄저장
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.hubInterfaceStopItemDAO.insert", mapParam);
	}
	

}
