package com.hwfs.sc.cmn.defaults;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * IRIS Default DAO
 * @ClassName DefaultIrisDAO.java
 * @Description DefaultIrisDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 12. 11.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 12. 11.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class DefaultIrisDAO extends DefaultDAO {
	/**
     * 리조트 FO 데이터소스 지정
     */
	@Autowired @Qualifier("resortfoDataSource")
	private DataSource dataSource;
	
	public void afterPropertiesSet() throws Exception {
	  	setDataSource(dataSource);
	  	super.afterPropertiesSet();
	}
}
