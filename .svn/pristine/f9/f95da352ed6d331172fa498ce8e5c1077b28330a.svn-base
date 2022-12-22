package com.hwfs.sc.cmn.dao;

import java.sql.Types;
import java.util.Map;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 
 * 
 * @ClassName GetSaleInfoDAO.java
 * @Description GetSaleInfoDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018. 8. 21.   kihoon        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kihoon
 * @since 2018. 8. 21.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/getSaleInfoDAO")
public class GetSaleInfoDAO extends DefaultDAO {
	
	/**
	 * 매출정보 저장
	 * <pre>
	 * - 
	 * </pre>
	 *
	 * @param  mapParam 일정시간 정보
	 * @return 처리건수
	 */
	public int insertSaleInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.GetSaleInfoDAO.insertSaleInfo", mapParam);
	}
	
	/**
	 * 매출정보 삭제
	 * <pre>
	 * - 
	 * </pre>
	 *
	 * @param  mapParam 일정시간 정보
	 * @return 처리건수
	 */
	public int deleteSaleInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.GetSaleInfoDAO.deleteSaleInfo", mapParam);
	}
	
	/**
	 * 대상정보 조회
	 * <pre>
	 * - 
	 * </pre>
	 *
	 * @param  mapParam 일정시간 정보
	 * @return 처리건수
	 */
	public RecordSet selectSaleInfo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.GetSaleInfoDAO.selectSaleInfo", mapParam);
	}
	
	 /**
     * 매출정보 생성 PROCEDURE
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> salePro(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {    
                new SqlParameter("P_OCCUR_DATE",            Types.VARCHAR),
                new SqlOutParameter("O_RTN",         Types.VARCHAR),
                new SqlOutParameter("O_RTNMSG",        Types.VARCHAR)                
        };

        String procedureName = "FSM_IF_SLA_SALESINFO_PRO";
        System.out.println("procedureName: "+procedureName);
        System.out.println("sqlParameter: "+sqlParameter);
        System.out.println("parameter: "+parameter);

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }

}
