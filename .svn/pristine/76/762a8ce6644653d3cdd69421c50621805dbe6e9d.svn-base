package com.hwfs.batch.ft.ftr.dao;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.batch.defaults.DefaultBatchDAO;

 /**
 * FtrNonarrivInventoryDAO에 대한 설명 작성
 * @ClassName FtrNonarrivInventoryDAO.java
 * @Description FtrNonarrivInventoryDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2019.10.29.   김명섭        최초생성
 * </pre>
 * @author FC정보기획팀 : 한화시스템ICT 김명섭
 * @since 2019.10.29.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/sc/ftr/ftrNonarrivInventoryDao")
public class FtrNonarrivInventoryDAO extends DefaultBatchDAO {

    public Map<String, Object> ftrNonarrivInventoryPro(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlParameter("strInParams",         Types.VARCHAR),
            new SqlParameter("strUserID",           Types.VARCHAR),
            new SqlParameter("strUserIP",           Types.VARCHAR),
            new SqlParameter("strHPtr",             Types.VARCHAR),
            new SqlOutParameter("lngRtn",           Types.INTEGER),
            new SqlOutParameter("lngCount",         Types.INTEGER),
            new SqlOutParameter("strDesc",          Types.VARCHAR)
        };

        String procedureName = "FTR_NONARRIV_INVENTORY_PRO";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }
	
}
