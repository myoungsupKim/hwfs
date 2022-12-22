package com.hwfs.batch.sc.scp;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.jdbc.core.RowMapper;

/**
 * 업무별 개인정보 보유기간 초과 파기 건에 대한 ItemReader의 RowMapper
 * @ClassName DstryProcessEtcRowMapper.java
 * @Description DstryProcessEtcRowMapper Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 9. 01.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 5. 27.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class DstryProcessEtcRowMapper implements RowMapper<Object> {
	
	/**
	 * ItemReader Item을 DTO에 mapping
	 *
	 * @param rs
	 * @param rowNum
	 * @return
	 * @throws SQLException
	 * @see org.springframework.jdbc.core.RowMapper#mapRow(java.sql.ResultSet, int)
	 */
	public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
        Map<String, Object> map = new HashMap<String, Object>();

        map.put ("mngtNo", rs.getString("MNGT_NO"));
        map.put ("dstrySchdDate", rs.getString("DSTRY_SCHD_DATE"));
        map.put ("dstryObjName", rs.getString("DSTRY_OBJ_NAME"));
        return map;
	}

}
