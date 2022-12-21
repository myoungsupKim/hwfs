package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 허브메카 단가 디데이설정하는 hubInterfaceSalePrice DAO
 * 
 * @ClassName hubInterfaceSalePriceDAO.java
 * @Description hubInterfaceSalePriceDAO Class
 * @Modification-Information
 * <pre>
 *    수정일         수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.06.26  김혜진       
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.04.14
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/hubInterfaceSalePriceDAO")
public class HubInterfaceSalePriceDAO extends DefaultDAO {
	
	/**
	 * 허브메카 ID 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUser(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.hubInterfaceSalePriceDAO.selectUser", mapParam);
	}

	
	/**
	 * 허브메카 단가 목록을 조회한다.(단가개시일 기준 조회)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.hubInterfaceSalePriceDAO.selectList", mapParam);
	}

	
	
	/**
	 * 허브메카 디데이 정보를 merge한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.hubInterfaceSalePriceDAO.insert", mapParam);
	}

	
	/**
	 * 식자재영업 판매단가 생성(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteHubPrice(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.hubInterfaceSalePriceDAO.deleteHubPrice", mapParam);
	}


	/**
	 * 허브메카 엑셀 업로드 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public List<Map>  selectExcel(Map<String, Object> mapParam) throws Exception {
		return super.queryForList("fm.fms.hubInterfaceSalePriceDAO.selectExcel", mapParam);
	}
	

	/**
	 * 허브메카 엑셀 업로드 temp 데이터를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int tempDelete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.hubInterfaceSalePriceDAO.tempDelete", mapParam);
	}
	
	/**
	 * 허브메카 엑셀 업로드 데이터를 임시 테이블에 저장한다.
	 * 
	 * @param mapParam
	 * @return
	 */
	public int[] tempInsert(List<Map> listParam) throws Exception {
		return super.batchUpdate("fm.fms.hubInterfaceSalePriceDAO.tempInsert", listParam);
	}

}
