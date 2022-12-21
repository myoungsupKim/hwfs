package com.hwfs.batch.sc.scp.dao;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.batch.defaults.DefaultBatchDAO;

/**
 * FSI JOB Schedule Dao Class
 *
 * @ClassName CardExpirationDeleteProDAO.java
 * @Description CardExpirationDeleteProDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016. 7. 15.   kihoon        최초생성
 * </pre>
 * @author FC종합전산구축 : 
 * @since 2016. 7. 15.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2016 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/sc/scp/cardExpirationDeleteProDAO")
public class CardExpirationDeleteProDAO extends DefaultBatchDAO {

    /**
     * 카드 유효기간 일배치 PROCEDURE
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> cardExpirationDeletePro(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
        		new SqlOutParameter("O_CNT", Types.INTEGER),
                new SqlOutParameter("O_RTN", Types.VARCHAR), 
                new SqlOutParameter("O_RTNMSG", Types.VARCHAR) };

        String procedureName = "SCC_CARD_VALID_DEST_PRO";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }

}
