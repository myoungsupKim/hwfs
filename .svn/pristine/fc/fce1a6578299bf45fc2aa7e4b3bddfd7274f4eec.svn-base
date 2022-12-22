package com.hwfs.fm.fmo.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 허브메카 데이터처리하는 HubmekaSysInterfaceSqlDAO
 * 
 * @ClassName HubmekaSysInterfaceSqlDAO.java
 * @Description HubmekaSysInterfaceSqlDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2021.06.13   hye.jin94        최초생성
 * </pre>
 * @author hye.jin94
 * @since 2021.10.07
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmo/hubmekaSysInterfaceSqlDAO")
public class HubmekaSysInterfaceSqlDAO extends DefaultDAO {
	
	/**
	 * 고객시스템 Interface(을)를 주문정보를 insert/update 한다.
	 *
	 * @param parameter
	 * @return int
	 */
	public int updateOrderList_old(Map<String, Object> parameter) throws Exception{
		return super.update("fm.fmo.hubmekaSysInterfaceSqlDAO.updateOrderList", parameter);
	}
	
	public int[] updateOrderList(List<Map> listParam) throws Exception {
		return super.batchUpdate("fm.fmo.hubmekaSysInterfaceSqlDAO.updateOrderList", listParam);
	}

	/**
	 * 허브메카 고객정보를 조회한다.
	 *
	 * @param  mapParam 일정시간 정보
	 * @return 처리건수
	 */
	public RecordSet selectUserList(Map<String, Object> mapParam) throws Exception{
		return super.queryForRecordSet("fm.fmo.hubmekaSysInterfaceSqlDAO.selectUserList", mapParam);
	}
	
	/**
	 * 허브메카 주문인터페이스 상태를 update 한다.
	 *
	 * @param parameter
	 * @return int
	 */
	public int updateUserList(Map<String, Object> parameter) throws Exception{
		return super.update("fm.fmo.hubmekaSysInterfaceSqlDAO.updateUserList", parameter);
	}
	
	/**
	 * 허브메카 단가 수동인터페이스 상태를 update 한다.
	 *
	 * @param parameter
	 * @return int
	 */
	public int updateUserList2(Map<String, Object> parameter) throws Exception{
		return super.update("fm.fmo.hubmekaSysInterfaceSqlDAO.updateUserList2", parameter);
	}
	
	/**
	 * 허브메카 고객별/일자별 주문정보 TEMP 데이터를 delete 한다.
	 *
	 * @param parameter
	 * @return int
	 */
	public int deleteOrderTempList(Map<String, Object> parameter) throws Exception{
		return super.update("fm.fmo.hubmekaSysInterfaceSqlDAO.deleteOrderTempList", parameter);
	}
	/**
	 * 허브메카 일자별 주문정보 TEMP 데이터를 일괄delete 한다.
	 *
	 * @param parameter
	 * @return int
	 */
	public int deleteOrderTempAllList(Map<String, Object> parameter) throws Exception{
		return super.update("fm.fmo.hubmekaSysInterfaceSqlDAO.deleteOrderTempAllList", parameter);
	}
	/**
	 * 허브메카 주문정보를 merge 한다.
	 *
	 * @param parameter
	 * @return int
	 */
	public int mergeOrderList(Map<String, Object> parameter) throws Exception{
		return super.update("fm.fmo.hubmekaSysInterfaceSqlDAO.mergeOrderList", parameter);
	}
	
	/**
	 * 허브메카 주문 삭제내역 0처리 한다.
	 *
	 * @param parameter
	 * @return int
	 */
	public int updateZeroList(Map<String, Object> parameter) throws Exception{
		return super.update("fm.fmo.hubmekaSysInterfaceSqlDAO.updateZeroList", parameter);
	}
	
	/**
	 * 허브메카 주문데이터 MERGE 프로시저 호출
	 */
	public Map<String, Object> if_hub_order_temp_pro(Map<String, Object> parameter) throws Exception {
		//전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlParameter("P_USERID",      	Types.VARCHAR),
            new SqlParameter("P_SDATE",      	Types.VARCHAR),
            new SqlParameter("P_EDATE",    		Types.VARCHAR),
  
            new SqlOutParameter("O_RTN",  	Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG",   	Types.VARCHAR)
        };


        String procedureName = "IF_HUB_ORDER_TEMP_PRO";
        // procedure 호출
        return callProcedure("FCUS", null, procedureName, sqlParameter, parameter);
	}
	
	//주문정보 수동실행 시 파라미터
	public RecordSet selectParamList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.hubmekaSysInterfaceSqlDAO.selectParamList", mapParam);
	}	
	
	//단가정보 수동실행 시 파라미터
	public RecordSet selectParamList2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.hubmekaSysInterfaceSqlDAO.selectParamList2", mapParam);
	}	
	
	
	/**
	 * 허브메카로 송신할 단가정보 조회
	 * <pre>
	 * - 
	 * </pre>
	 *
	 * @param  mapParam 일정시간 정보
	 * @return 처리건수
	 */
	public RecordSet selectPriceList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.hubmekaSysInterfaceSqlDAO.selectPriceList", mapParam);
	}

	/**
	 * 허브메카 단가정보 전송 시 기존 로그데이터 delete 한다.
	 *
	 * @param parameter
	 * @return int
	 */
	public int deleteIflog(Map<String, Object> parameter) throws Exception{
		return super.update("fm.fmo.hubmekaSysInterfaceSqlDAO.deleteIflog", parameter);
	}
	
	/**
	 * 허브메카 단가정보 전송 성공 시 로그데이터 insert 한다.
	 *
	 * @param parameter
	 * @return int
	 */
	public int insertIflog(Map<String, Object> parameter) throws Exception{
		return super.update("fm.fmo.hubmekaSysInterfaceSqlDAO.insertIflog", parameter);
	}
	
}
