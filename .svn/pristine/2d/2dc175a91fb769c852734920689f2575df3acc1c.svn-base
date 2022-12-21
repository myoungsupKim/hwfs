package com.hwfs.batch.sc.scp;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.jdbc.core.RowMapper;

/**
 * 미접속계정 잠김주기 건에 대한 ItemReader의 RowMapper
 * @ClassName NonConnDstryNotiRowMapper.java
 * @Description NonConnDstryNotiRowMapper Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 5. 27.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 5. 27.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class NonConnLockRowMapper implements RowMapper<Object> {
	
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

        map.put ("sabun", rs.getString("SABUN"));
        map.put ("nmKor", rs.getString("NM_KOR"));
        return map;
	}

}
