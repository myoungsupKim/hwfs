package com.hwfs.batch.guide.sample;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.hwfs.batch.guide.sample.dto.CustomerCreditDTO;

/**
 * 배치 샘플 CustomerCreditRowMapper에 대한 설명 작성
 * @ClassName CustomerCreditRowMapper.java
 * @Description CustomerCreditRowMapper Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2014. 12. 22.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2014. 12. 22.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class CustomerCreditRowMapper implements RowMapper<Object> {
	
	// "id"를 나타내는 상수
	public static final String ID_COLUMN = "id";

	// "name"를 나타내는 상수
	public static final String NAME_COLUMN = "name";

	// "credit"를 나타내는 상수
	public static final String CREDIT_COLUMN = "credit";

	/**
	 * CustomerCreditDTO를 set
	 */
	public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
        CustomerCreditDTO customerCredit = new CustomerCreditDTO();

        customerCredit.setId(rs.getInt(ID_COLUMN));
        customerCredit.setName(rs.getString(NAME_COLUMN));
        customerCredit.setCredit(rs.getBigDecimal(CREDIT_COLUMN));

        return customerCredit;
	}

}
