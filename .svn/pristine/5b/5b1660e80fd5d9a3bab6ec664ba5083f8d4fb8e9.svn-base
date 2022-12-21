package com.hwfs.fm.fmp.dao;

import java.util.Map;

import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;
import com.hwfs.ls.cmn.util.LimsUtil;

import hone.core.util.record.RecordSet;

/**
 * 창고일괄변경 Dao Class
 *
 * @ClassName WhPackModifyDAO.java
 * @Description WhPackModifyDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 8. 5.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 8. 5.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmp/whPackModifyDAO")
public class WhPackModifyDAO extends DefaultDAO {

    /**
     * 창고일괄변경 목록을 조회한다
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("fm.fmp.whPackModifyDAO.selectList", parameter);
    }

    /**
     * 일자를 조회한다
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectDdayList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("fm.fmp.whPackModifyDAO.selectDdayList", parameter);
    }

    /**
     * 시간을 조회한다
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectDtimesList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("fm.fmp.whPackModifyDAO.selectDtimesList", parameter);
    }

    /**
     * 일괄 일자 시간을 저장
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int modifyList(Map<String, Object> parameter) throws Exception {
        return super.update("fm.fmp.whPackModifyDAO.modifyList", parameter);
    }

    /**
     * 자재 PROCEDURE
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> modifyItemList(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        /*SqlParameter[] sqlParameter = new SqlParameter[] {
                new SqlParameter("P_SYS_ID", Types.VARCHAR),
                new SqlParameter("P_COMP_CD", Types.VARCHAR),
                new SqlOutParameter("O_RTN_CD", Types.VARCHAR),
                new SqlOutParameter("O_RTN_MSG", Types.VARCHAR) };

        String procedureName = "SP_IF_WH_CD_FCUS";*/

        // procedure 호출
        //return callProcedure(procedureName, sqlParameter, parameter);

        // 구매쪽 계정 사용을 위해 SimpleJdbcCall을 사용한다.
        SimpleJdbcCall itemInterfaceCall = new SimpleJdbcCall(getDataSource()).withSchemaName("EPROCUSR").withProcedureName("SP_IF_WH_CD_FCUS");
        MapSqlParameterSource params = new MapSqlParameterSource();
        params.addValue("P_SYS_ID",  LimsUtil.checkNull(parameter.get("p_sys_id"), "100"));
        params.addValue("P_COMP_CD", LimsUtil.checkNull(parameter.get("p_comp_cd"), "HFC"));

        Map<String, Object> out = itemInterfaceCall.execute(params);

        return out;
    }

}
